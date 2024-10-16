# Your first package!

To package our little python game we have to add a couple more things to our
python script. We need a setup.py with the following contents:

```python
from setuptools import setup, find_packages

setup(name='myGame',
      version='1.0',
      # Modules to import from other scripts:
      packages=find_packages(),
      # Executables
      scripts=["game.py"],
     )
```

This setup file in python is used to indicate what script in our package is the
main script, which we indicate with the scripts argument.

Lastly we need to add `#!/usr/bin/env python3` to our `game.py` to make sure
nix knows what binary to run this script.
