#! /bin/bash
set -eufx -o pipefail
hugo
rsync -a --progress public/ chris@azantys:/var/www/html/
