#!/usr/bin/env -S just --justfile

set default-list
set default-script
set lazy
set quiet
set minimum-version := '1.55.1'
set shell := ['bash', '-euo', 'pipefail', '-c']

# Bootstrap Recipes
[group: 'Bootstrap']
mod bootstrap "bootstrap"

# Kube Recipes
[group: 'Kube']
mod kube "kubernetes"

[group: 'talos']
mod? talos 'talos'

[private]
log lvl msg *args:
    gum log -t rfc3339 -s -l "{{ lvl }}" "{{ msg }}" {{ args }}

# === template ===

[group: 'template']
mod template 'template'

[doc('Render and validate configuration files')]
[group('template')]
configure:
    just template configure

[doc('Initialize configuration files (cluster.toml, age key, deploy key, webhook token)')]
[group('template')]
init:
    just template init
