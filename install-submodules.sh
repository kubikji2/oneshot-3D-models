#! /bin/bash

# init submodule and update them recursively
# '-> `git submodule init` init submodules
# '-> `git submodule update` update initialized submodules
# '-> `git submodule update --remote` update initialized submodules to the latest version
# '-> `git submodule update --init --remote` joins previous commands
# '-> `git submodule update --init --recursive --remote` recursively init potential submodules within the submodules
# SEE: https://git-scm.com/book/en/v2/Git-Tools-Submodules
git submodule update --init --recursive --remote
