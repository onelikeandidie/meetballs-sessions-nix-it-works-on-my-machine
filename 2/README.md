# Ok declare your intentions

Let's consider this, you used `nix-shell` to download your packages but a couple
of weeks later your `cowsay` no-loger supports the word "lemon" and you really
like making lemonade. To solve this, nix supports creating a configurable
enviroment from a nix file, the default being `shell.nix`.

Create a `shell.nix` file with the following content:

```nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    cowsay
    lolcat
  ];

  HELLO = "world";

  shellHook = ''
    cowsay $HELLO | lolcat
  '';
}
```

Nix is not like other configuration languages, it is actually a fully realized
programming language to configure packages with variables and functions. This
might seem overwelming, but with my 2 years experience with Nix I've only ever
had to "program" something on my own once, and it was pointless since I realize
someone already made what I was doing.

Basically, your variables are set in `let ... in` which is a list of whatever
variables you want to use to create your configuration. Here we create 2
variables:

- `nixpkgs = fetchTarball "...";` - This will pin the version of nix's
packages we want to use in our configuration. This is basically nix's
configuration information for all packages.
- `pkgs = import nixpkgs { config = {}; overlays = []; };` - Imports that
configuration with the option of applying our own custom settings or overlays.
Overlays are other nix files that add or modify packages.

Then we can run functions after the `in` like the `pkgs.mkShellNoCC` which
creates a shell enviroment. The reason for the naming is because initially
`pkgs.mkShell` was used to construct shell enviroments containing tools needed
to debug package builds such aas Make or GCC.

This `mkShellNoCC` takes a shell configuration as a input where we can pass
`packages` to create our enviroment. On line 7, the `with pkgs; [` is to
abreviate the verbosity of declaring packages, it's easier to explain with an
example.

```nix
packages = with pkgs; [
  cowsay
  lolcat
];
# Or
packages = [
  pkgs.cowsay
  pkgs.lolcat
];
```

Optionally, you can add any enviroment variable you want to that enviroment as
can be seen on line 11 with `HELLO = "world"`.

Also optionally, you can add a `shellHook` which will run every time you open
this shell

Now, run `nix-shell` to load this file into your shell and try out your
enviroment.

```bash
# Make sure you are cd'd into the same directory as your shell.nix
$ nix-shell
unpacking '...' into the Git cache...
# ...
 _______ 
< world >
 ------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

Now you have a reproducible enviroment for your packages, but lets try
something more serious next time!
