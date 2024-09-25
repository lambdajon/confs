# Keep all declarative gpu driver support configurations here
{
  # List all gpu modules here
  intel = import ./intel.nix;
  nvidia = import ./nvidia.nix;
}
