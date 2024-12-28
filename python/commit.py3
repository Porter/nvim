#!/usr/bin/python3

from os import environ
from sys import argv
from pynvim import attach

if len(argv) != 2:
    print("Usage: commit.py3 FILE_TO_EDIT")
    exit(1)

socket_path = environ['NVIM']
if not socket_path:
    print("NVIM is not set, is this running in a nvim terminal emulator?")
    exit(1)

nvim = attach('socket', path=socket_path)

nvim.command('tabnew ' + argv[1])

rpcnotify = f':call rpcnotify({nvim.channel_id}, "commit-message-done")'
nvim.command('augroup notify')
nvim.command('autocmd BufHidden ''' + argv[1] + ' ' + rpcnotify)
nvim.command('augroup END')

# Wait to exit until the commit-message-done event is sent.
# So fig doesn't see that this program has finished and considers
# the contents of FILE_TO_EDIT as final.
nvim.next_message()
