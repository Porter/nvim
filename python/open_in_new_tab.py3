#!/usr/bin/python3

from os import getcwd,environ,path
from sys import argv
from pynvim import attach

if len(argv) != 2:
    print("Usage: open_in_new_tab.py3 FILE_TO_EDIT")
    exit(1)

socket_path = environ['NVIM']
if not socket_path:
    print("NVIM is not set, is this running in a nvim terminal emulator?")
    exit(1)

nvim = attach('socket', path=socket_path)

nvim.command('tabnew ' + path.join(getcwd(), argv[1]))
