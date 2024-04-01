# Simple nix VM for just anything

Fork of https://github.com/jecaro/simple-nix-vm for my own learning.

Build with:

```bash
$ nix build  ./#nixosConfigurations.vm.config.system.build.vm
```

Then run with:

```bash
$ ./result/bin/run-nixos-vm
```

