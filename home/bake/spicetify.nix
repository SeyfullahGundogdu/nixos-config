{
  pkgs,
  spicetify-nix,
  ...
}: {
  #customized using the example config from the README at spicetify-nix repo.
  imports = [spicetify-nix.homeManagerModules.default];

  # configure spicetify :)
  programs.spicetify = let
    comfy_theme = pkgs.fetchgit {
      url = "https://github.com/Comfy-Themes/Spicetify";
      rev = "21b70a9c3a8f2eb05819f7b57393cef89e6e3079";
      sha256 = "sha256-F6e83schEWjTshK68n0OFJHbDy5XCHv4NB5YU3CNnf8=";
    };
  in {
    # actually enable the installation of spicetify
    enable = true;

    #Comfy theme
    theme = {
      name = "Comfy";
      src = comfy_theme;
      requiredExtensions = [
        # define extensions that will be installed with this theme
        {
          # extension is "${src}/Comfy/theme.js"
          filename = "theme.js";
          src = "${comfy_theme}/Comfy";
        }
      ];
      appendName = true; # theme is located at "${src}/Comfy" not just "${src}"
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };
  };
}
