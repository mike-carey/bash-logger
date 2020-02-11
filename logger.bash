#!/usr/bin/env bash

function log() {
  {
    local args=$-
    set +x

    local reset=$'\e[39m'
    local no_color="${NO_COLOR:-false}"

    local color="$1"
    shift
    local id="$1"
    shift

    echo -n '['

    if [[ ${no_color} != true ]]; then
      echo -en "${color}"
    fi

    echo -n "$id"

    if [[ ${no_color} != true ]]; then
      echo -en "${reset}"
    fi
    echo -n '] '

    echo "${@:-}"

    set $args
  }>&2
}

function log_debug() {
  if [[ "${DEBUG:-false}" == true ]]; then
    log $'\e[96m' DEBUG "$*"
  fi
}
export -f log_debug

function log_info() {
  log $'\e[92m' INFO "$*"
}
export -f log_info

function log_warn() {
  log $'\e[93m' WARN "$*"
}
export -f log_warn

function log_error() {
  log $'\e[91m' ERROR "$*"
}
export -f log_error
