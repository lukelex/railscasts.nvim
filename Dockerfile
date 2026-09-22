FROM ubuntu:24.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates curl g++ gcc imagemagick kitty lua5.1 nodejs unzip xvfb \
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
    && mkdir /tmp/grammars \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter/tree-sitter-bash/archive/a06c2e4415e9bc0346c6b86d401879ffb44058f7.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/bash \
    && mkdir /tmp/grammars \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter/tree-sitter-typescript/archive/75b3874edb2dc714fb1fd77a32013d0f8699989f.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/typescript \
    && mkdir /tmp/grammars \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter/tree-sitter-json/archive/254c42a6476413b776221e03982ac8ae159eeb72.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/json \
    && mkdir /tmp/grammars \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter/tree-sitter-html/archive/73a3947324f6efddf9e17c0ea58d454843590cc0.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/html \
    && mkdir /tmp/grammars \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter/tree-sitter-css/archive/dda5cfc5722c429eaba1c910ca32c2c0c5bb1a3f.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/css \
    && mkdir /tmp/grammars \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter-grammars/tree-sitter-markdown/archive/a0a00f817d02412bd92c54d316f164d827b57b5c.tar.gz \
      | tar --extract --gzip --directory /tmp/grammars --strip-components=1 \
    && mv /tmp/grammars /tmp/markdown \
    && for language in ruby lua bash json html css; do \
      scanner=""; test -f "/tmp/$language/src/scanner.c" && scanner="/tmp/$language/src/scanner.c"; \
      gcc -shared -fPIC -O2 -I "/tmp/$language/src" "/tmp/$language/src/parser.c" $scanner -o "/opt/treesitter/parsers/$language.so"; \
    done \
    && gcc -shared -fPIC -O2 -I /tmp/typescript/typescript/src /tmp/typescript/typescript/src/parser.c /tmp/typescript/typescript/src/scanner.c -o /opt/treesitter/parsers/typescript.so \
    && gcc -shared -fPIC -O2 -I /tmp/typescript/tsx/src /tmp/typescript/tsx/src/parser.c /tmp/typescript/tsx/src/scanner.c -o /opt/treesitter/parsers/tsx.so \
    && gcc -shared -fPIC -O2 -I /tmp/markdown/tree-sitter-markdown/src /tmp/markdown/tree-sitter-markdown/src/parser.c /tmp/markdown/tree-sitter-markdown/src/scanner.c -o /opt/treesitter/parsers/markdown.so \
    && gcc -fPIC -O2 -I /tmp/yaml/src -c /tmp/yaml/src/parser.c -o /tmp/yaml-parser.o \
    && g++ -fPIC -O2 -I /tmp/yaml/src -c /tmp/yaml/src/scanner.cc -o /tmp/yaml-scanner.o \
    && g++ -shared /tmp/yaml-parser.o /tmp/yaml-scanner.o -o /opt/treesitter/parsers/yaml.so \
    && rm -rf /tmp/grammars /tmp/ruby /tmp/lua /tmp/yaml /tmp/bash /tmp/typescript /tmp/json /tmp/html /tmp/css /tmp/markdown /tmp/yaml-parser.o /tmp/yaml-scanner.o

RUN set -e; \
    fetch() { \
      local name="$1" repository="$2" revision="$3"; \
      mkdir /tmp/grammar; \
      curl --fail --location --retry 3 --retry-all-errors "https://github.com/${repository}/archive/${revision}.tar.gz" \
        | tar --extract --gzip --directory /tmp/grammar --strip-components=1; \
      mv /tmp/grammar "/tmp/${name}"; \
    }; \
    fetch javascript tree-sitter/tree-sitter-javascript 58404d8cf191d69f2674a8fd507bd5776f46cb11; \
    fetch go tree-sitter/tree-sitter-go 2346a3ab1bb3857b48b29d779a1ef9799a248cd7; \
    fetch rust tree-sitter/tree-sitter-rust 77a3747266f4d621d0757825e6b11edcbf991ca5; \
    fetch sql DerekStride/tree-sitter-sql 97614d051eebfd3bc5d97c0bdb5a1638719ca811; \
    fetch toml tree-sitter-grammars/tree-sitter-toml 64b56832c2cffe41758f28e05c756a3a98d16f41; \
    fetch dockerfile camdencheek/tree-sitter-dockerfile 971acdd908568b4531b0ba28a445bf0bb720aba5; \
    fetch make alemuller/tree-sitter-make 8881e0dc005862fa6954f1c67ecceacd53daa633; \
    fetch c tree-sitter/tree-sitter-c b780e47fc780ddc8da13afa35a3f4ed5c157823d; \
    fetch cpp tree-sitter/tree-sitter-cpp c009222808634c1014f82438d4883753516a2c24; \
    fetch java tree-sitter/tree-sitter-java e10607b45ff745f5f876bfa3e94fbcc6b44bdc11; \
    fetch c_sharp tree-sitter/tree-sitter-c-sharp 9150f7d56bb47f1a809fa23623f1ba1413e93fa9; \
    fetch vue ikatyang/tree-sitter-vue 91fe2754796cd8fba5f229505a23fa08f3546c06; \
    fetch svelte tree-sitter-grammars/tree-sitter-svelte ae5199db47757f785e43a14b332118a5474de1a2; \
    fetch python tree-sitter/tree-sitter-python 26855eabccb19c6abf499fbc5b8dc7cc9ab8bc64; \
    fetch gitcommit gbprod/tree-sitter-gitcommit 55a265cf763ec15d6e2d96bb206e3f5e30d82bae; \
    curl --fail --location --retry 3 --retry-all-errors https://github.com/tree-sitter/tree-sitter/releases/download/v0.24.7/tree-sitter-linux-x64.gz \
      | gunzip > /usr/local/bin/tree-sitter; \
    chmod +x /usr/local/bin/tree-sitter; \
    (cd /tmp/sql && tree-sitter generate); \
    for language in javascript go rust sql toml dockerfile make c cpp java c_sharp vue svelte python gitcommit; do \
      scanner=""; test -f "/tmp/$language/src/scanner.c" && scanner="/tmp/$language/src/scanner.c"; \
      gcc -shared -fPIC -O2 -I "/tmp/$language/src" "/tmp/$language/src/parser.c" $scanner -o "/opt/treesitter/parsers/$language.so"; \
    done \
    && gcc -fPIC -O2 -I /tmp/vue/src -c /tmp/vue/src/parser.c -o /tmp/vue-parser.o \
    && g++ -fPIC -O2 -I /tmp/vue/src -c /tmp/vue/src/scanner.cc -o /tmp/vue-scanner.o \
    && g++ -shared /tmp/vue-parser.o /tmp/vue-scanner.o -o /opt/treesitter/parsers/vue.so \
    && rm -rf /tmp/grammar /tmp/javascript /tmp/go /tmp/rust /tmp/sql /tmp/toml /tmp/dockerfile /tmp/make /tmp/c /tmp/cpp /tmp/java /tmp/c_sharp /tmp/vue /tmp/svelte /tmp/python /tmp/gitcommit /tmp/vue-parser.o /tmp/vue-scanner.o

RUN mkdir -p /opt/plugins/{mini.nvim,nvim-notify,trouble.nvim,snacks.nvim} \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/echasnovski/mini.nvim/archive/561751e839b99a4baca36b9d963166b66d2536a6.tar.gz \
      | tar --extract --gzip --directory /opt/plugins/mini.nvim --strip-components=1 \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/rcarriga/nvim-notify/archive/8701bece920b38ea289b457f902e2ad184131a5d.tar.gz \
      | tar --extract --gzip --directory /opt/plugins/nvim-notify --strip-components=1 \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/folke/trouble.nvim/archive/bd67efe408d4816e25e8491cc5ad4088e708a69a.tar.gz \
      | tar --extract --gzip --directory /opt/plugins/trouble.nvim --strip-components=1 \
    && curl --fail --location --retry 3 --retry-all-errors https://github.com/folke/snacks.nvim/archive/882c996cf28183f4d63640de0b4c02ec886d01f2.tar.gz \
      | tar --extract --gzip --directory /opt/plugins/snacks.nvim --strip-components=1

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
    /opt/neovim/v0.12.5/bin/nvim --headless --clean --cmd 'set rtp^=.' -l tests/plugins_spec.lua; \
    kitty +runpy 'import kitty.config; bad = []; kitty.config.load_config("extras/kitty.conf", accumulate_bad_lines=bad); assert not bad, bad'
