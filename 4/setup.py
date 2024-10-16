from setuptools import setup, find_packages

setup(name='myGame',
      version='1.0',
      # Modules to import from other scripts:
      packages=find_packages(),
      # Executables
      scripts=["game.py"],
     )
