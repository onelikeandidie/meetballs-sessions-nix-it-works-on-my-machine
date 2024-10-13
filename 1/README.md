# What is Nix?

Nix is a declarative package manager, which transforms a configuration file 
written in nix and outputs an enviroment with those configurations making sure
that you can always make reproducible builds for any machine.

Nix can be installed on most UNIX operating systems, with Windows support via
WSL. You can download it [here](https://nixos.org/download/). If you don't want
to have Nix installed permanently on your linux system, I recommend using the
"Single-user" installation as it might be easier to
[uninstall](https://nix.dev/manual/nix/2.24/installation/uninstall.html). Make
sure to install Nix now.

The first step to using nix is using it for obtaining packages temporarilly
which we call a Ad hoc shell enviroment. You can look for packages at
[search.nixos.org](https://search.nixos.org/packages). We'll start with the
basic _hello_ package, "A program that produces a familiar, friendly greeting".

```bash
$ nix-shell -p hello
```

`nix-shell` is the command used to create or configure ad hoc shells, the
`-p` (`--packages`) option lets us request specific packages to exist in this
shell. After a few moments we should be able to access the `hello` command.

```bash
$ hello
Hello, world!
```

Then you can exit this shell with the `exit` command or `<C>-D` and try to use
the hello command only to find that you cannot use this command.

```bash
$ hello
bash: hello: command not found
```

This is because Nix will store these packages in a special directory called the
Nix store which has each package versioned and hashed. Every time you run a
nix-shell it will create dynamic links and add variables to your _$PATH_ to
create a separate enviroment.

This was the basics of nix, now try and find a package that you would like to
try. If you don't have any package in mind here's a couple to try:

- Development Tools
  - `helix` - A post-modal text editor
  - `zellij` - Terminal Workspace
  - `gitui` - Git Terminal UI tool
  - `vscode` - Microsoft's code editor
- GUI Programs
  - `gimp` - Highly capable mage editor
  - `kdenlive` - Open source free video editor with hardware encoding
  - `obs-studio` - Open source broadcast software
- Games
  - `openarena` - Quake-like
  - `supertux` - You know super tux
  - `zeroad` - Age of Empires alternative strategy game
  - `steam` - Game library manager and store

_note:_ You can try more packages at the same time by writing them after one
another like so

```bash
$ nix-shell -p cowsay lolcat sl
$ cowsay help | lolcat
$ sl
```
