{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.orca-slicer ];

  # Printer discovery.
  networking.firewall.extraCommands = ''
    iptables -I INPUT -m pkttype --pkt-type multicast -j ACCEPT
    iptables -A INPUT -m pkttype --pkt-type multicast -j ACCEPT
    iptables -I INPUT -p udp -m udp --match multiport --dports 1990,2021 -j ACCEPT
  '';
}
