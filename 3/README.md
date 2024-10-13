# Configuring packages declaritively

For this enviroment, we'll setup a python development enviroment. Nix python
enviroments are akin to virtualenv or conda, a shell enviroment with access to
pinned versions of the `python` executable and packages, this means that
entering this enviroment will yield the same result on most systems without
much configuration or creating a `requirements.txt` file. Let's start with a
small pygame. Create a `shell.nix` file with the following contents:

```nix
let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    (python3.withPackages (python-pkgs: with python-pkgs; [
      pygame
    ]))
  ];
}
```

_note:_ Some python packages are not available on the nix package manager and
can require extra effort to import. Visit [the wiki](https://wiki.nixos.org/wiki/Python)
to read more about this if you are interested. If you use poetry to manage
python dependencies, you can use [poetry2nix](https://github.com/nix-community/poetry2nix)
to automagically create environments with your poetry configuration.

Once you have that you can run `nix-shell` to enter into your python enviroment
and start developing stuff. The example game in how pygame works you can use
the following base code or the included `game.py`.

```python
# Example file showing a circle moving on screen
import pygame

# pygame setup
pygame.init()
screen = pygame.display.set_mode((1280, 720))
clock = pygame.time.Clock()
running = True
dt = 0

player_pos = pygame.Vector2(screen.get_width() / 2, screen.get_height() / 2)

while running:
    # poll for events
    # pygame.QUIT event means the user clicked X to close your window
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # fill the screen with a color to wipe away anything from last frame
    screen.fill("purple")

    pygame.draw.circle(screen, "red", player_pos, 40)

    keys = pygame.key.get_pressed()
    if keys[pygame.K_w]:
        player_pos.y -= 300 * dt
    if keys[pygame.K_s]:
        player_pos.y += 300 * dt
    if keys[pygame.K_a]:
        player_pos.x -= 300 * dt
    if keys[pygame.K_d]:
        player_pos.x += 300 * dt

    # flip() the display to put your work on screen
    pygame.display.flip()

    # limits FPS to 60
    # dt is delta time in seconds since last frame, used for framerate-
    # independent physics.
    dt = clock.tick(60) / 1000

pygame.quit()
```

Have fun gaming in your fully reproducible environment!
