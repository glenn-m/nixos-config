{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.gm = 
  let secrets = (import ../secrets.nix).users.gm.email;
  in {
    programs = {
      notmuch.enable = true;
      mbsync.enable = true;
      msmtp.enable = true;
    };
    accounts.email = {
      maildirBasePath = ".mail";
      accounts.fastmail = {
        address = secrets.address;
        userName = secrets.userName;
        realName = secrets.realName;
        passwordCommand = "mail-password";
        imap.host = "imap.fastmail.com";
        smtp.host = "smtp.fastmail.com";
        mbsync = {
          enable = true;
          create = "maildir";
        };
        primary = true;
        msmtp.enable = true;
        notmuch.enable = true;
      };
    };
  };
}
