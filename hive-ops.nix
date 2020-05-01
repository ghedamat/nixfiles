{
  network.description = "hivemind dev network";

  lurker = {
    imports = [ ./hive-lurker-devserver.nix ];
    deployment.targetHost = "lurker";
  };

  ultralisk = {
    imports = [ ./hive-ultralisk-postgres.nix ];
    deployment.targetHost = "ultralisk";
  };

  hydralisk = {
    imports = [ ./hive-hydralisk-desktop.nix ];
    deployment.targetHost = "hydralisk";
  };

  overlord = {
    imports = [ ./hive-overlord-dnsmasq.nix ];
    deployment.targetHost = "overlord";
  };
}
