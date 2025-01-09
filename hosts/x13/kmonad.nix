{ ... }:

{
  modules.kmonad = {
    enable = true;
    keyboards = {
      builtin = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = ''
          (defcfg
            input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
            output (uinput-sink "uinput")

            cmp-seq ralt
            cmp-seq-delay 5

            fallthrough true
          )

          (defsrc
            grv   1    2    3    4    5    6    7    8    9    0    -    =     bspc
            tab    q    w    e    r    t    y    u    i    o    p    [    ]    \
            caps    a    s    d    f    g    h    j    k    l    ;    '        ret
            lsft     z    x    c    v    b    n    m    ,    .    /            rsft
            lctl lmet lalt             spc              ralt sys  rctl
          )

          (defalias rnm (layer-toggle reach-no-more))
          (defalias srnm (layer-toggle shift-reach-no-more))

          (deflayer qwerty
            grv   1    2    3    4    5    6    7    8    9    0    -    =     bspc
            tab    q    w    e    r    t    y    u    i    o    p    [    ]    \
            esc     a    s    d    f    g    h    j    k    l    ;    @rnm     ret
            lsft     z    x    c    v    b    n    m    ,    .    rsft         rsft
            lctl lalt lmet             spc              rmet ralt rctl
          )

          (deflayer colemak-dh
            grv   1    2    3    4    5    6    7    8    9    0    -    =     bspc
            tab    q    w    f    p    b    j    l    u    y    ;    [    ]    \
            esc     a    r    s    t    g    m    n    e    i    o    @rnm     ret
            lsft     x    c    d    v    z    k    h    ,    .    rsft         rsft
            lctl lalt lmet             spc              rmet ralt rctl
          )

          (deflayer reach-no-more
            _     _    _    _    _    _    _    _    _    _    _    _    _     _
            _      -    +    {    }    |    _    "    '    `    _    _    _    _
            _       /    *    \(   \)   &    left down up   rght _    _        _
            @srnm    =    ^     [    ]   _    bspc \    !    ?    @srnm        @srnm
            _    _    _                \_               _    sys  _   
          )

          (deflayer shift-reach-no-more
            _     _    _    _    _    _    _    _    _    _    _    _    _     _
            _      _    _    _    _    _    _    _    _    _    _    _    _    _
            _       _    _    _    _    _    home pgdn pgup end  _    _        _
            _        _    _    _    _    _    del  _    _    _    _            _
            _    _    _                _                _    _    _   
          )
        '';
      };
    };
  };
}
