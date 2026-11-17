{
  description = "Compatibility entry point for the notebook configuration";
  inputs.notebook.url = "path:./devices/notebook/nix";
  outputs = { notebook, ... }: {
    inherit (notebook) nixosConfigurations;
  };
}
