# Development

Use Docker for the same complete checks run by GitHub Actions:

```sh
docker build --tag railscasts-ci .
docker run --rm railscasts-ci
```

To run the current working tree without rebuilding the image:

```sh
docker run --rm --volume "$PWD:/workspace" railscasts-ci
```

The suite checks Lua 5.1 syntax, StyLua, Kitty configuration, plugin
integrations, snapshots, and the theme on Neovim 0.9.5, 0.10.4, 0.11.7, and
0.12.5. Parser-backed fixture checks run on 0.11.7 and 0.12.5 because of parser
ABI compatibility.

## Focused checks

```sh
docker run --rm --entrypoint bash railscasts-ci \
  -o pipefail -c "find colors lua tests -name '*.lua' -print0 | xargs -0 -r luac5.1 -p && stylua --check colors lua tests"

docker run --rm --entrypoint /opt/neovim/v0.12.5/bin/nvim railscasts-ci \
  --headless --clean --cmd 'set rtp^=.' -l tests/plugins_spec.lua
```

## Visual assets

Update [`tests/snapshots/theme.svg`](../tests/snapshots/theme.svg) only after an
intentional visual review:

```sh
docker run --rm --env UPDATE_SNAPSHOTS=1 --volume "$PWD:/workspace" railscasts-ci
```

Regenerate the README gallery from the fixture files with:

```sh
scripts/capture_gallery.sh
```

Keep the relevant GitHub Wiki page current when user-facing behavior changes.

## Releases

Add concise user-facing notes at `docs/releases/vX.Y.Z.md` before creating a
matching tag. The tag-triggered Release workflow validates that file and creates
the GitHub release if one does not already exist.
