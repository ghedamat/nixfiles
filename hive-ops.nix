{
  network.description = "hivemind dev network";
  ultralisk = (import ./hive-ultralisk-postgres.nix);
  lurker = (import ./hive-lurker-devserver.nix);
}
