#! /bin/bash
set -eufx -o pipefail
hugo
rsync -a --progress public/ backwardspy@azantys:/var/www/html/
