{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = with pkgs.mpvScripts; [
          mpris
        ];
        extraMakeWrapperArgs = [
          # nvidia prime render offload
          "--set"
          "__NV_PRIME_RENDER_OFFLOAD"
          "1"
          "--set"
          "__NV_PRIME_RENDER_OFFLOAD_PROVIDER"
          "NVIDIA-G0"
          "--set"
          "__GLX_VENDOR_LIBRARY_NAME"
          "nvidia"
          "--set"
          "__VK_LAYER_NV_optimus"
          "NVIDIA_only"
        ];
      };
    })
  ];
}
