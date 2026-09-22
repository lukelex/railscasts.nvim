# Accessibility and contrast

Railscasts prioritizes the original Railscasts/TextMate character, while this
port also protects the roles read most often in a modern Neovim UI. Contrast is
measured with the WCAG relative-luminance formula against the default
`background` (`#2B2B2B`).

## Core palette measurements

| Token | Contrast | Role |
| --- | ---: | --- |
| `beige_grey` | 10.90:1 | Primary text |
| `white` | 12.86:1 | High-emphasis text |
| `light_orange` | 9.14:1 | Functions |
| `yellow` | 10.93:1 | Search |
| `moss` | 7.07:1 | Numbers |
| `light_green` | 5.61:1 | Strings, special syntax, additions |
| `blue` | 4.83:1 | Booleans and information |
| `cyan` | 4.82:1 | Changes and visual mode |
| `dark_orange` | 4.25:1 | Keywords and warnings |
| `red` | 3.37:1 | Errors and deletions |
| `light_brown` | 3.32:1 | Comments and muted metadata |

## Applied fixes

- Special syntax and diff additions use `light_green` instead of the
  low-contrast `dark_green`.
- Statements and warning messages use `dark_orange` instead of lower-contrast
  brown or maroon shades.
- Delimiters use primary text rather than the low-contrast separator gray.
- Tabline and Lualine secondary surfaces use `grey` with `beige_grey` text.
- Inactive Lualine text uses `beige_grey`, not black on charcoal.

## Deliberate muted roles

Comments, some diagnostic colors, and legacy UI metadata retain muted tones to
preserve the original Railscasts hierarchy. They should not be the sole carrier
of meaning: diagnostics also use signs and underlines, and diff states use
separate groups. Enable `high_contrast` through `require("railscasts").setup()`
when stronger muted-text contrast is needed.

The supported UI integrations inherit the same semantic groups in high-contrast
mode, including transparent and dimmed-inactive-window configurations.
