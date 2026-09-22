if exists("b:current_syntax")
  finish
endif

syn keyword kmonadkeyword defcfg defsrc defalias deflayer
syn keyword kmonadBool true false
syn keyword kmonaddefcfgOptName input output init cmp-seq allow-cmd fallthrough
syn keyword kmonaddefcfgIOName kext uinput-sink send-event-sink device-file low-level-hook iokit-name
syn keyword kmonaddefaliasMod around around-next around-next-single cmd-button multi-tap layer-add layer-delay layer-next layer-rem layer-switch layer-toggle tap-hold tap-hold-next
syn match kmonadLineComment ";;.*$"
syn region kmonadMultiComment start="#|" end="|#"
syn region kmonadSingleQuotes start=/"/ skip=/\\"/ end=/"/
syn region kmonadDoubleQuotes start=/'/ skip=/\\'/ end=/'/
syn match kmonadAliascode "@[^ 	)"]\+"
syn match kmonadNumber "\<\d\+\>"
syn match kmonadPlus "\s\zs+\S\+\ze"
syn match kmonaddefaliasName "^\s\+\zs\h[[:alnum:]_-]*\ze\s\+("

let b:current_syntax = "kmonad"
