{ pkgs, lib, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages =
    (with pkgs; [
      just
      taplo
      nodejs
      clang
      curl
    ])
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin (
      with pkgs;
      [
        libclang
        libiconv
        darwin.apple_sdk.frameworks.Security
      ]
    );

  # https://devenv.sh/scripts/
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = "";

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    cargo --version
  '';

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/languages/
  languages = {
    rust = {
      enable = true;
      channel = "nightly";
      targets = [ "wasm32-unknown-unknown" ];
      components = [
        "rustc"
        "cargo"
        "clippy"
        "rustfmt"
        "rust-analyzer"
        "rust-std"
      ];
    };
  };

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  env.RUSTFLAGS = lib.mkIf pkgs.stdenv.isDarwin (lib.mkForce "");

  # See full reference at https://devenv.sh/reference/options/
}
