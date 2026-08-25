{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    clang-tools
    llvm
  ];

  programs.helix.languages = lib.mkIf config.programs.helix.enable {
    language-server.clangd.command = "${pkgs.clang-tools}/bin/clangd";
    language = [
      {
        name = "c";
        language-servers = [ "clangd" ];
        formatter.command = "${pkgs.clang-tools}/bin/clang-format";
        auto-format = true;
      }
      {
        name = "cpp";
        language-servers = [ "clangd" ];
        formatter.command = "${pkgs.clang-tools}/bin/clang-format";
        auto-format = true;
      }
    ];
  };
}
