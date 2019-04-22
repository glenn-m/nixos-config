{ config, lib, pkgs, ...}:
{
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [
      "conntrack"
      "diskstats"
      "entropy"
      "filefd"
      "filesystem"
      "interrupts"
      "ksmd"
      "loadavg"
      "logind"
      "mdadm"
      "meminfo"
      "netdev"
      "netstat"
      "stat"
      "systemd"
      "time"
      "vmstat"
    ];
  };
}
