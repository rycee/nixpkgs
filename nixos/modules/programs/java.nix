# This module provides JAVA_HOME, with a different way to install java
# system-wide.

{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.java;

  trustStore =
    pkgs.runCommand
      "java-cacerts"
      {
        nativeBuildInputs = [ pkgs.perl ];
        preferLocalBuild = true;
        allowSubstitutes = false;
      }
      ''
        mkdir -p $out
        cd $out
        perl \
          ${../../../pkgs/development/compilers/openjdk/generate-cacerts.pl} \
          ${cfg.package}/lib/openjdk/jre/bin/keytool \
          ${config.environment.etc."ssl/certs/ca-certificates.crt".source}
        ls
      '';

in

{

  options = {

    programs.java = {

      enable = mkEnableOption "java" // {
        description = ''
          Install and setup the Java development kit.
          <note>
          <para>This adds JAVA_HOME to the global environment, by sourcing the
            jdk's setup-hook on shell init. It is equivalent to starting a shell
            through 'nix-shell -p jdk', or roughly the following system-wide
            configuration:
          </para>
          <programlisting>
            environment.variables.JAVA_HOME = ''${pkgs.jdk.home}/lib/openjdk;
            environment.systemPackages = [ pkgs.jdk ];
          </programlisting>
          </note>
        '';
      };

      package = mkOption {
        default = pkgs.jdk;
        defaultText = "pkgs.jdk";
        description = ''
          Java package to install. Typical values are pkgs.jdk or pkgs.jre.
        '';
        type = types.package;
      };

    };

  };

  config = mkIf cfg.enable {

    environment.systemPackages = [ cfg.package ];

    environment.shellInit = ''
      test -e ${cfg.package}/nix-support/setup-hook && source ${cfg.package}/nix-support/setup-hook
    '';

    environment.etc."ssl/certs/java/cacerts".source = "${trustStore}/cacerts";
    environment.sessionVariables.JAVAX_NET_SSL_TRUSTSTORE = "${trustStore}/cacerts";

  };

}
