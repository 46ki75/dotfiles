#!/bin/bash

set -euo pipefail

git pull > /dev/null

stow --no-folding */
