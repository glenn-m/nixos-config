{ config, pkgs, ... }:
{
  systemd.services.hostapd.after = [ "sys-subsystem-net-devices-wlp4s0.device" ];

  services.hostapd =
    let secrets = (import ../secrets.nix).wifi;
    in {
      enable = true;
      interface = "wlp4s0";
      ssid = secrets.ssid;
      hwMode = "a";
      channel = 0; # 0 searches for channel with least interference
      wpaPassphrase = secrets.wpaPassphrase;
      extraConfig = ''
	ieee80211n=1
	ieee80211ac=1
	wpa_pairwise=TKIP CCMP
	rsn_pairwise=CCMP
      '';
    };
}
