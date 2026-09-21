FROM ubuntu:24.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates curl lua5.1 \
    && rm -rf /var/lib/apt/lists/*

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

WORKDIR /workspace
COPY . .

CMD find colors lua tests -name '*.lua' -print0 | xargs -0 -r luac5.1 -p \
    && for version in v0.9.5 v0.10.4 v0.11.7 v0.12.5; do \
      echo "Testing Neovim $version"; \
      "/opt/neovim/$version/bin/nvim" --headless --clean --cmd 'set rtp^=.' -l tests/theme_spec.lua; \
    done
