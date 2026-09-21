FROM ubuntu:24.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates curl g++ gcc kitty lua5.1 unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl --fail --location --retry 3 --retry-all-errors \
      https://github.com/JohnnyMorganz/StyLua/releases/download/v2.5.2/stylua-linux-x86_64.zip \
      --output /tmp/stylua.zip \
    && unzip -q /tmp/stylua.zip -d /usr/local/bin \
    && rm /tmp/stylua.zip

RUN for version in v0.9.5 v0.10.4 v0.11.7 v0.12.5; do \
      if [[ "$version" == "v0.9.5" ]]; then archive="nvim-linux64.tar.gz"; \
      else archive="nvim-linux-x86_64.tar.gz"; fi; \
      mkdir -p "/opt/neovim/$version"; \
      curl --fail --location --retry 3 --retry-all-errors \
        "https://github.com/neovim/neovim/releases/download/$version/$archive" \
        --output /tmp/nvim.tar.gz; \
      tar --extract --gzip --file /tmp/nvim.tar.gz \
        --directory "/opt/neovim/$version" --strip-components=1; \
    done \
    && rm /tmp/nvim.tar.gz

RUN mkdir -p /tmp/grammars /opt/treesitter/parsers \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter/tree-sitter-ruby/archive/ad907a69da0c8a4f7a943a7fe012712208da6dee.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/ruby \
    && mkdir /tmp/grammars \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter-grammars/tree-sitter-lua/archive/10fe0054734eec83049514ea2e718b2a56acd0c9.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/lua \
    && mkdir /tmp/grammars \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/ikatyang/tree-sitter-yaml/archive/0e36bed171768908f331ff7dff9d956bae016efb.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/yaml \
    && for language in ruby lua; do \
      scanner=""; test -f "/tmp/$language/src/scanner.c" && scanner="/tmp/$language/src/scanner.c"; \
      gcc -shared -fPIC -O2 -I "/tmp/$language/src" "/tmp/$language/src/parser.c" $scanner -o "/opt/treesitter/parsers/$language.so"; \
    done \
    && gcc -fPIC -O2 -I /tmp/yaml/src -c /tmp/yaml/src/parser.c -o /tmp/yaml-parser.o \
    && g++ -fPIC -O2 -I /tmp/yaml/src -c /tmp/yaml/src/scanner.cc -o /tmp/yaml-scanner.o \
    && g++ -shared /tmp/yaml-parser.o /tmp/yaml-scanner.o -o /opt/treesitter/parsers/yaml.so \
    && rm -rf /tmp/grammars /tmp/ruby /tmp/lua /tmp/yaml /tmp/yaml-parser.o /tmp/yaml-scanner.o

WORKDIR /workspace
COPY . .

ENV RAILSCASTS_PARSER_DIR=/opt/treesitter/parsers

CMD set -e; \
    find colors lua tests -name '*.lua' -print0 | xargs -0 -r luac5.1 -p; \
    stylua --check colors lua tests; \
    for version in v0.9.5 v0.10.4 v0.11.7 v0.12.5; do \
      echo "Testing Neovim $version"; \
      nvim="/opt/neovim/$version/bin/nvim"; \
      if [[ "$version" == v0.9.* || "$version" == v0.10.* ]]; then \
        RAILSCASTS_PARSER_DIR= "$nvim" --headless --clean --cmd 'set rtp^=.' -l tests/theme_spec.lua; \
      else \
        "$nvim" --headless --clean --cmd 'set rtp^=.' -l tests/theme_spec.lua; \
      fi; \
      "$nvim" --headless --clean --cmd 'set rtp^=.' -l tests/screenshot_spec.lua; \
    done; \
    kitty +runpy 'import kitty.config; bad = []; kitty.config.load_config("extras/kitty.conf", accumulate_bad_lines=bad); assert not bad, bad'
