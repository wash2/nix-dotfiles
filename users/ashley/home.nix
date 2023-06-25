{ pkgs, ... }: {
  # ==== https://mipmip.github.io/home-manager-option-search/ ====
  # ==============================================================
  #
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ blender fzf zoxide ];
  programs.bash.enable = true;

  programs.bash.bashrcExtra = ''
    eval "$(zoxide init bash)"
    eval "$(ssh-agent -s)" 2&> /dev/null
    ssh-add ~/.ssh/ashley.pem 2&> /dev/null
  '';
}
