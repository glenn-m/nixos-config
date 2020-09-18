{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.gm = {
    programs.bash = {
      enable = true;
      shellAliases = {
        # sudo
        sudo = "sudo ";

        # git
        ga = "git add";
        gc = "git commit";
        gco = "git checkout";
        gcp = "git cherry-pick";
        gdiff = "git diff";
        gl = "git prettylog";
        gp = "git push";
        gs = "git status";
        gt = "git tag";

        # ls
        ls = "ls --color=auto";
        ll = "ls -ls --color=auto";
        lla = "ls -lsa --color=auto";

        # grep
        grep = "grep --color=auto";
        fgrep = "fgrep --color=auto";
        egrep = "egrep --color=auto";

        # ip
        ip = "ip -color";
        ipb = "ip -color -brief";

        todo = "e $HOME/org/inbox.org";
        info = "info --vi-keys";

        # untar/unrar
        untar = "tar -xvf";
        unrar = "unar";

        # interactive file actions
        cp = "cp -i";
        mv = "mv -i";

        # nixos
        rebuild = "sudo nixos-rebuild switch";
        channel-update = "sudo nix-channel --update";
        nix-stray-roots = ''
          nix-store --gc --print-roots | egrep -v "^(/nix/var|/run/w+-system|{memory)"'';

        # emacs
        e = "emacsclient -c";

        # Shortcuts
        dl = "cd $HOME/Downloads";
        code = "cd $HOME/code";
        k8s = "kubectl";
        h = "history";

        # tmux
        t =
          "(tmux has-session 2>/dev/null && tmux attach) || (tmux new-session)";
      };
      sessionVariables = {
        PATH = "$PATH:$HOME/.emacs.d/bin:$HOME/code/go/bin";
        EDITOR = "emacsclient -c";
        PAGER = "less -FirSwX";
        MANPAGER = "$PAGER";
        GOPATH = "$HOME/code/go";
      };
      bashrcExtra = ''
        parse_git_branch() {
             git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
        }

        export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

        if hash kubectl 2>/dev/null; then
          source <(kubectl completion bash)
        fi

        # Work Specific Things
        source $HOME/code/work/.work_bashrc
                      '';
    };
  };
}
