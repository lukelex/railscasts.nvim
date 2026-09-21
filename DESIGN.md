# Railscasts design language

This document describes the visual system used by Railscasts integrations. It
is intended for plugin themes and external applications such as Kitty.

The canonical runtime palette is
[`lua/railscasts/colors.lua`](lua/railscasts/colors.lua). This document also
contains the complete token values and is self-contained for consumers that do
not use Neovim or Lua. Integrations should use the semantic roles below rather
than introducing colors of their own.

## Consumer and derivative contract

This design language is portable. It can be used by terminal profiles, editor
themes, web interfaces, documentation sites, screenshots, or a derivative
colorscheme.

- Treat the palette token names and semantic-role names as the public contract.
  A consumer should reference names such as `surface.base` and
  `syntax.function`, then resolve them through the tables in this file.
- A consumer that cannot represent a role should fall back in this order:
  `text.primary` for text, `text.muted` for metadata, `surface.base` for
  surfaces, and `syntax.special` for uncategorized syntax.
- Consumers with only 16 terminal colors should follow the ANSI mapping below.
  Consumers with true color should use the token values exactly.
- Derivatives may change token **values**, but should retain token and role
  **names** where their meaning is unchanged. New roles must be documented with
  a purpose, foreground/background behavior, and fallback role.
- A derivative must not silently change the meaning of stable roles such as
  `change.added`, `change.changed`, `change.deleted`, or `diagnostic.error`.
  Rename a role if its semantic meaning changes.

### Minimal portable interface

Every implementation based on Railscasts should provide these roles:

```text
surface.base        surface.current      surface.raised
text.primary        text.strong          text.muted
syntax.function     syntax.keyword       syntax.string
syntax.number       syntax.boolean       syntax.member       syntax.special
state.selection     state.search
change.added        change.changed       change.deleted
diagnostic.error    diagnostic.warning   diagnostic.info     diagnostic.hint
```

Optional capabilities add `mode.normal`, `mode.insert`, `mode.visual`,
`mode.replace`, and `mode.command`, using the mode language below. A consumer
that has no syntax, diagnostic, or mode support can safely omit those roles
while preserving the base surface and text roles.

## Character

- **Origin:** a faithful dark port of the original Railscasts TextMate theme.
- **Mood:** warm charcoal surfaces, readable cream text, muted earth-tone
  comments, and saturated syntax accents.
- **Hierarchy:** keep the editor surface quiet; reserve brighter colors for
  selection, completion, diagnostics, and the active mode.
- **Contrast:** use the default palette for fidelity. Use the opt-in
  high-contrast palette only when accessibility is preferred over exact
  historical matching.

## Palette tokens

| Token | Value | Intended use |
| --- | --- | --- |
| `background` | `#2B2B2B` | Main editor and terminal background |
| `black` | `#000000` | Strong inverse foreground/background |
| `beige_grey` | `#E6E1DC` | Primary readable text |
| `white` | `#F3F4F5` | High-emphasis foreground |
| `grey` | `#333435` | Current-line surface |
| `light_grey` | `#7C6F64` | Quiet separators and secondary surfaces |
| `dark_grey` | `#5F5F87` | Bright terminal black / muted accent |
| `red` | `#DA4939` | Errors, deletions, constants, command mode |
| `light_green` | `#87AF5F` | Strings, success, normal mode, selection |
| `dark_green` | `#005F00` | Special syntax and diff additions |
| `light_orange` | `#FFC66D` | Functions and methods |
| `dark_orange` | `#CC7833` | Keywords, preprocessor text, insert mode |
| `yellow` | `#EBE774` | Search matches and replace mode |
| `blue` | `#6E9CBE` | Booleans and built-in constants |
| `cyan` | `#6D9CBE` | Changed diffs, Ruby symbols, visual mode |
| `purple` | `#D0D0FF` | Labels and member-like identifiers |
| `light_brown` | `#92764C` | Comments and muted metadata |
| `dark_brown` | `#AF5F00` | Statements and indentation scope |
| `moss` | `#A5C261` | Numeric literals |
| `pink` | `#F9D7E4` | Reserved palette accent |

## Semantic roles

Use these roles when a target supports named styling categories.

| Role | Palette token | Examples |
| --- | --- | --- |
| `surface.base` | `background` | Main window, terminal, inactive background |
| `surface.current` | `grey` | Cursor line |
| `surface.raised` | `light_grey` | Secondary statusline surface |
| `text.primary` | `beige_grey` | Normal text, variables, punctuation |
| `text.strong` | `white` | Titles and high-emphasis text |
| `text.muted` | `light_brown` | Comments and metadata |
| `syntax.function` | `light_orange` | Functions, methods, tags |
| `syntax.keyword` | `dark_orange` | Keywords and preprocessor directives |
| `syntax.string` | `light_green` | Strings and paths |
| `syntax.number` | `moss` | Numbers and floats |
| `syntax.boolean` | `blue` | Booleans and built-ins |
| `syntax.member` | `purple` | Labels and member identifiers |
| `syntax.special` | `light_green` | Special characters and symbols |
| `state.selection` | `light_green` on `black` | Completion or selected list item |
| `state.search` | `yellow` on `background` | Search and current quickfix item |
| `change.added` | `light_green` | Added lines and Git additions |
| `change.changed` | `cyan` | Modified lines and Git changes |
| `change.deleted` | `red` | Deleted lines and Git deletions |
| `diagnostic.error` | `red` | Errors |
| `diagnostic.warning` | `dark_orange` | Warnings |
| `diagnostic.info` | `blue` | Information |
| `diagnostic.hint` | `beige_grey` | Hints |

## Mode language

Statusline-like integrations should use the following mode accents. The active
segment uses black text on the accent; adjacent segments use the accent on a
black surface.

| Mode | Accent token |
| --- | --- |
| Normal | `light_green` |
| Insert | `dark_orange` |
| Visual | `cyan` |
| Replace | `yellow` |
| Command | `red` |
| Inactive | `light_green` with a `background` surface |

This is the contract implemented by the Lualine theme.

## Terminal language

For ANSI-capable terminals, retain the mapping in
[`extras/kitty.conf`](extras/kitty.conf):

| ANSI colors | Palette token |
| --- | --- |
| 0 | `background` |
| 1 / 9 | `red` / `dark_orange` |
| 2 / 10 | `light_orange` / `moss` |
| 3 / 11 | `moss` / `light_orange` |
| 4 / 12 | `cyan` |
| 5 / 13 | `purple` |
| 6 / 14 | `light_green` |
| 7 / 15 | `white` |
| 8 | `dark_grey` |

Kitty should use `background` and `beige_grey` for its default surface and
foreground, `light_green` for selections, and `dark_orange` for the cursor.

## Integration rules

1. Prefer semantic-role links over direct color assignments.
2. Use only the palette tokens above; do not derive lighter, darker, or blended
   variants in an integration.
3. Do not use an accent as a large background except for an intentional active
   state such as a selection or statusline mode.
4. Keep comments and inactive metadata muted with `light_brown`.
5. Map adds, changes, and deletions consistently to `dark_green`, `cyan`, and
   `red`.
6. Keep default colors stable; accessibility adjustments belong to the explicit
   high-contrast variant.
