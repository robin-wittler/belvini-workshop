#!/usr/bin/env python3
# -*- coding: utf8 -*-


__author__ = 'Robin Wittler'
__contact__ = 'robin.wittler@cloudwuerdig.com'
__version__ = '0.0.1'


import logging
from setuptools import setup, find_packages


logger = logging.getLogger(__name__)


with open("./requirements.txt") as fp:
    setup(
        name="stateful-set-example",
        packages=find_packages(),
        version=__version__,
        description="Simple async restful api for demonstrate a stateful set.",
        author="Robin Wittler",
        author_email="robin.wittler@cloudwuerdig.com",
        install_requires=fp.readlines()
    )


if __name__ == '__main__':
    pass
