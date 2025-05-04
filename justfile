# vim: tabstop=4 shiftwidth=4 softtabstop=4 smarttab expandtab autoindent
#
# Tackler Documentation 2025
# SPDX-License-Identifier: Apache-2.0
#

# Just list all targets
default:
    @just --list --unsorted

alias db := debug-build
alias rb := release-build

# Clean build and cache
clean: clean-cache clean-build

# Clean build (the site)
clean-build:
    rm -rf build/site

# Clean Antora data cache
clean-cache:
    rm -rf .cache/antora/

# Build the release versio the documentatoin
debug-build: clean-build
    podman run -v $PWD:$PWD:Z -w $PWD  --rm -t antora/antora local-antora-playbook.yml

# Build the release versio the documentatoin
release-build: clean
    podman run -v $PWD:$PWD:Z -w $PWD  --rm -t antora/antora antora-playbook.yml

# Publish documentation
publish: release-build
    sh bin/publish-docs.sh
