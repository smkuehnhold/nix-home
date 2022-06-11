{ pkgs, ...}:

{
  # Use FHS variant for now
  # FIXME: Change to non-FHS variant when I get a better idea of what extensions I want
  home.packages = with pkgs; [ vscodium-fhs ];
}
