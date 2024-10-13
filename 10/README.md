# Cleaning up after nix

When you download packages using nix, the package manager doesn't actually
delete the temporary packages or the deprecated packages and you can end up
with a large Nix store under `/nix`. To delete the packages that are no-longer
used in your system you can use the `nix-collect-garbage --delete-old` command
which will remove any packages that are no-longer required. An alternative is
`nix-collect-garbage --delete-older-than <period>` with a value such as `7d`
to delete packages that are older than 7 days that are no longer used.

You can read more about cleaning up
[here](https://nix.dev/manual/nix/2.18/command-ref/nix-collect-garbage.html#opt-delete-older-than)
