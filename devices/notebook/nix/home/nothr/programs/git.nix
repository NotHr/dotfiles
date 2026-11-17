{ pkgs, ... }:

{

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Harshith Madhadi";
        email = "harshith@nothr.in";
      };

      init.defaultBranch = "master";

      core = {
        editor = "codium --wait";
        autocrlf = "input";
      };

      pull.rebase = true;
      push.autoSetupRemote = true;
      fetch.prune = true;

      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --decorate --all";
        undo = "reset --soft HEAD~1";
      };

      diff.colorMoved = "default";
      rerere.enabled = true;
    };

    ignores = [
      ".DS_Store"
      "*.swp"
      ".direnv/"
      ".env.local"
    ];
  };
}
