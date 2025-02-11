{ ... }:

{
  modules.kmonad = {
    enable = true;
    keyboards = rec {
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

          (deflayer qwerty
           grv   1    2    3    4    5    6    7    8    9    0    -    =     bspc
           tab    q    w    e    r    t    y    u    i    o    p    [    ]    \
           esc     a    s    d    f    g    h    j    k    l    ;    '        ret
           lsft     z    x    c    v    b    n    m    ,    .     /           rsft
           lctl lalt lmet             spc              rmet ralt rctl
          )
        '';

          # (defalias rnm (layer-toggle reach-no-more))
          # (defalias srnm (layer-toggle shift-reach-no-more))
          # (defalias num (layer-toggle numpad))
          #
          # (deflayer colemak-dh
          #   grv   1    2    3    4    5    6    7    8    9    0    -    =     bspc
          #   tab    q    w    f    p    b    j    l    u    y    ;    bspc del  @num
          #   esc     a    r    s    t    g    m    n    e    i    o    @rnm     ret
          #   lsft     x    c    d    v    z    k    h    ,    .    rsft         rsft
          #   lctl lalt lmet             spc              rmet ralt rctl
          # )
          #
          # (deflayer qwerty
          #  grv   1    2    3    4    5    6    7    8    9    0    -    =     bspc
          #  tab    q    w    e    r    t    y    u    i    o    p    bspc del  @num
          #  esc     a    s    d    f    g    h    j    k    l    ;    @rnm     ret
          #  lsft     z    x    c    v    b    n    m    ,    .    rsft         rsft
          #  lctl lalt lmet             spc              rmet ralt rctl
          # )
          #
          # (deflayer reach-no-more
          #   _     _    _    <    >    _    _    _    _    _    _    _    _     _
          #   _      -    +    {    }    |    down rght ?    !    _    _    _    _
          #   _       /    *    \(   \)   &    \    "    '    `    _    _        _
          #   @srnm    =    ^    [    ]    _    up   left #    @    @srnm        @srnm
          #   _    _    _                \_               _    sys  _   
          # )
          #
          # (deflayer shift-reach-no-more
          #   _     _    _    _    _    _    _    _    _    _    _    _    _     _
          #   _      _    _    _    _    _    pgdn end  _    _    _    _    _    _
          #   _       _    _    _    _    _    _    _    _    ~    _    _        _
          #   _        _    _    _    _    _    pgup home $    %    _            _
          #   _    _    _                _                _    _    _   
          # )
          #
          # (deflayer numpad
          #   _     _    7    8    9    bspc _    _    _    _    _    _    _     _
          #   _      ^    4    5    6    -    _    _    _    _    _    _    _    _
          #   _       /    1    2    3    +    _    _    _    _    _    _        _
          #   _        *    .    0    =    ret  _    _    _    _    _            _
          #   _    _    _                _                _    _    _   
          # )
        # '';
      };

      external = builtin // {
        device = "/dev/input/by-path/pci-0000:c3:00.3-usb-0:2.2:1.0-event-kbd";
      };
    };
  };
}
