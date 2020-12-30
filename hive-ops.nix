{
  network.description = "hivemind dev network";

  lurker = {
    imports = [ ./hive-lurker-devserver.nix ];
    deployment.targetHost = "lurker";
    nix.gc.automatic = false;
  };

  drone = {
    imports = [ ./hive-drone-devserver.nix ];
    deployment.targetHost = "drone";
    nix.gc.automatic = false;
  };

  viper = {
    imports = [ ./hive-viper-devserver.nix ];
    deployment.targetHost = "192.168.199.118";
    nix.gc.automatic = false;
  };

  ultralisk = {
    imports = [ ./hive-ultralisk-postgres.nix ];
    deployment.targetHost = "ultralisk";
    nix.gc.automatic = true;
  };

  hydralisk = {
    imports = [ ./hive-hydralisk-desktop.nix ];
    deployment.targetHost = "hydralisk";
    nix.gc.automatic = false;
  };

  overlord = {
    imports = [ ./hive-overlord-dnsmasq.nix ];
    deployment.targetHost = "192.168.199.140";
    nix.gc.automatic = true;
  };

  nydusworm = {
    imports = [ ./hive-nydusworm-plex.nix ];
    deployment.targetHost = "nydusworm";
    nix.gc.automatic = true;
  };

  #zergling = {
  #  imports = [ ./hive-zergling-x280.nix ];
  #  deployment.targetHost = "zergling";
  #};

  #infestedTerran = {
  #  imports = [ ./hive-infested-terran-opstest.nix ];
  #  deployment.targetHost = "infested-terran";
  #  nix.gc.automatic = true;
  #};

  spawningPool = {
    imports = [ ./hive-spawning-pool-printserver.nix ];
    deployment.targetHost = "spawning-pool";
    nix.gc.automatic = true;
  };

  swarmHost = {
    imports = [ ./hive-swarm-host-nas.nix ];
    deployment.targetHost = "192.168.199.95";
    nix.gc.automatic = true;
  };
}
