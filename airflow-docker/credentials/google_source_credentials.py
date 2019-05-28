#!/usr/bin/env python
import os
import subprocess as sp

dir_path = os.path.dirname(os.path.realpath(__file__))
print(f"current working dir: {dir_path}")


def subprocess_cmd(command, executable='/bin/sh'):
    process = sp.Popen(command, stdout=sp.PIPE, shell=True, executable='/bin/bash')
    proc_stdout = process.communicate()[0].strip()
    print(proc_stdout)


with open(f"{dir_path}/google-source-credentials.sh", "rt") as file_in:

    _cmd = ''
    for line in file_in:
        _cmd = f"{_cmd}\n{line}"

    print(_cmd)
    subprocess_cmd(_cmd)
    print('finished')
