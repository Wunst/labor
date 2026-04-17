{ config, lib, pkgs, ... }:
let
  cfg = config.programs.orca-slicer;
in {
  options.programs.orca-slicer.enable = lib.mkEnableOption "G-code generator for 3D printers (Bambu, Prusa, Voron, VzBot, RatRig, Creality, etc.)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.orca-slicer ];
    networking.firewall.extraCommands = ''
      iptables -I INPUT -m pkttype --pkt-type multicast -j ACCEPT
      iptables -A INPUT -m pkttype --pkt-type multicast -j ACCEPT
      iptables -I INPUT -p udp -m udp --match multiport --dports 1990,2021 -j ACCEPT
    '';
  };
}
