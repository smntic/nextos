{ pkgs, ... }:

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

          (deflayer qwerty
           grv   1    2    3    4    5    6    7    8    9    0    -    =     bspc
           tab    q    w    e    r    t    y    u    i    o    p    [    ]    \
           esc     a    s    d    f    g    h    j    k    l    ;    '        ret
           lsft     z    x    c    v    b    n    m    ,    .     /           rsft
           lctl lalt lmet             spc              rmet ralt rctl
          )
        '';
      };

      external = {
        device = "/dev/input/by-id/usb-Keychron_Keychron_K2-event-kbd";
        config = ''
          (defcfg
            input (device-file "/dev/input/by-id/usb-Keychron_Keychron_K2-event-kbd")
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
      };
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="input", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="024f", RUN+="/bin/sh -c '${pkgs.coreutils}/bin/sleep 0.5 && ${pkgs.systemd}/bin/systemctl restart kmonad-external.service' &"
  '';
}
