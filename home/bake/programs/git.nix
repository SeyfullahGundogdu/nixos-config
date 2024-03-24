{
  gitUsername,
  gitEmail,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
