{ hostRoot, ... }:

{
  programs.zsh = {
    envExtra = ''
      export CPP_TEMPLATE=${hostRoot}/assets/cp/cpp_template.cpp
    '';
  };
}
