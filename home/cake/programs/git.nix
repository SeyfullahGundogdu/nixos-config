{
  gitUsername,
  gitEmail,
  ...
}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "${gitEmail}";
        name = "${gitUsername}";
      };
      init.defaultBranch = "main";
    };
  };
}
