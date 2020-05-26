{
  network.description = "hivemind dev network";

  lurker = {
    imports = [ ./hive-lurker-devserver.nix ];
    deployment.targetHost = "lurker";
  };

  drone = {
    imports = [ ./hive-drone-devserver.nix ];
    deployment.targetHost = "drone";
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
    deployment.targetHost = "192.168.199.140";
  };

  nydusworm = {
    imports = [ ./hive-nydusworm-plex.nix ];
    deployment.targetHost = "nydusworm";
  };

  zergling = {
    imports = [ ./hive-zergling-x280.nix ];
    deployment.targetHost = "zergling";
  };

  infestedTerran = {
    imports = [ ./hive-infested-terran-opstest.nix ];
    deployment.targetHost = "infested-terran";
  };

  spawningPool = {
    imports = [ ./hive-spawning-pool-printserver.nix ];
    deployment.targetHost = "spawning-pool";
  };
}
