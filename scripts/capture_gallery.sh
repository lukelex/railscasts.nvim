#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

docker build --tag railscasts-gallery "$root"
docker run --rm --volume "$root:/workspace" --workdir /workspace --entrypoint bash railscasts-gallery -lc '
  set -euo pipefail
  frames=$(mktemp -d)
  xvfb_pid=""
  cleanup() {
    rm -rf "$frames"
    if [[ -n "$xvfb_pid" ]]; then kill "$xvfb_pid" 2>/dev/null || true; fi
  }
  trap cleanup EXIT

  Xvfb :99 -screen 0 1000x700x24 >/tmp/railscasts-xvfb.log 2>&1 &
  xvfb_pid=$!
  export DISPLAY=:99

  capture() {
    local fixture=$1 filetype=$2 label=$3 output=$4
    kitty --config NONE \
      --override font_family="DejaVu Sans Mono" \
      --override font_size=14 \
      --override initial_window_width=80c \
      --override initial_window_height=24c \
      --override background="#2B2B2B" \
      --override foreground="#E6E1DC" \
      --override cursor_blink_interval=0 \
      --override enable_audio_bell=no \
      --override confirm_os_window_close=0 \
      /opt/neovim/v0.11.7/bin/nvim --clean --cmd "set rtp^=." \
      --cmd "set winhighlight=WinBar:Normal" --cmd "let &winbar = \"%=%#Function# ${label} \"" \
      "+edit $fixture" "+set filetype=$filetype" "+syntax on" "+colorscheme railscasts" \
      "+set number" "+set laststatus=0" "+set noshowmode" "+set noruler" \
      "+normal! gg" &
    local kitty_pid=$!
    sleep 2
    import -display :99 -window nvim "$output"
    kill "$kitty_pid"
    wait "$kitty_pid" || true
    sleep 1
  }

  capture tests/fixtures/ruby.rb ruby "◆ Ruby" "$frames/ruby.png"
  capture tests/fixtures/lua.lua lua "◆ Lua" "$frames/lua.png"
  capture tests/fixtures/release.sh sh "◆ Bash" "$frames/bash.png"
  capture tests/fixtures/config.yaml yaml "◆ YAML" "$frames/yaml.png"
  capture tests/fixtures/example.ts typescript "◆ TypeScript" "$frames/typescript.png"
  capture tests/fixtures/package.json json "◆ JSON" "$frames/json.png"
  capture tests/fixtures/guide.md markdown "◆ Markdown" "$frames/markdown.png"
  capture tests/fixtures/index.html html "◆ HTML" "$frames/html.png"
  capture tests/fixtures/theme.css css "◆ CSS" "$frames/css.png"

  convert -delay 180 -loop 0 \
    "$frames/ruby.png" "$frames/lua.png" "$frames/bash.png" "$frames/yaml.png" \
    "$frames/typescript.png" "$frames/json.png" "$frames/markdown.png" "$frames/html.png" "$frames/css.png" \
    -layers Optimize screenshots/gallery.gif
'
