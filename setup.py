#!/usr/bin/env python

from setuptools import setup
import os

__version__ = None
exec(open('ansible_runner/_version.py', 'r').read())

os.environ['PBR_VERSION'] = __version__

setup(
    setup_requires=['pbr'],
    pbr=True,
)
