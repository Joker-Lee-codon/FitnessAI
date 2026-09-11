#!/bin/zsh
set -eu

readonly NODE_VERSION="24.18.0"
readonly NODE_ARCHIVE="node-v${NODE_VERSION}-darwin-arm64.tar.gz"
readonly NODE_URL="https://nodejs.org/dist/v${NODE_VERSION}/${NODE_ARCHIVE}"
readonly NODE_SHASUMS_URL="https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt"
readonly NODE_SHA256="e1a97e14c99c803e96c7339403282ea05a499c32f8d83defe9ef5ec66f979ed1"
readonly CONDA_ROOT="${FITNESSAI_CONDA_ROOT:-/Users/seanlee/anaconda3}"
readonly NODE_DIR="${CONDA_ROOT}/node-v${NODE_VERSION}-darwin-arm64"
readonly BMAD_BIN="${CONDA_ROOT}/envs/BMAD/bin"

fail() {
  print -u2 -- "ERROR: $*"
  exit 1
}

ensure_link() {
  local link_path="$1"
  local target_path="$2"

  if [[ -L "$link_path" ]]; then
    [[ "$(readlink "$link_path")" == "$target_path" ]] || fail "$link_path points to an unexpected target"
    return
  fi
  [[ ! -e "$link_path" ]] || fail "$link_path exists and is not a symbolic link"
  ln -s "$target_path" "$link_path"
}

remove_link() {
  local link_path="$1"
  local target_path="$2"

  [[ -e "$link_path" || -L "$link_path" ]] || return
  [[ -L "$link_path" && "$(readlink "$link_path")" == "$target_path" ]] || fail "refusing to remove unexpected $link_path"
  unlink "$link_path"
}

verify_installation() {
  local npm_version npx_version
  [[ -x "${NODE_DIR}/bin/node" ]] || fail "Node.js executable is missing"
  [[ "$("${NODE_DIR}/bin/node" --version)" == "v${NODE_VERSION}" ]] || fail "Node.js version mismatch"
  [[ "$("${NODE_DIR}/bin/node" -p 'process.arch')" == "arm64" ]] || fail "Node.js is not arm64"
  file "${NODE_DIR}/bin/node" | grep -q 'Mach-O 64-bit executable arm64' || fail "Node.js binary type mismatch"

  for tool in node npm npx; do
    [[ -L "${CONDA_ROOT}/bin/${tool}" ]] || fail "missing global ${tool} link"
    [[ -L "${BMAD_BIN}/${tool}" ]] || fail "missing BMAD ${tool} link"
  done

  npm_version="$(PATH="${NODE_DIR}/bin:${PATH}" "${NODE_DIR}/bin/npm" --version)"
  npx_version="$(PATH="${NODE_DIR}/bin:${PATH}" "${NODE_DIR}/bin/npx" --version)"
  [[ "$npm_version" == "11.16.0" ]] || fail "npm version mismatch: $npm_version"
  [[ "$npx_version" == "11.16.0" ]] || fail "npx version mismatch: $npx_version"
  print -- "Node $("${NODE_DIR}/bin/node" --version), npm ${npm_version}, npx ${npx_version}, arm64"
}

install_node() {
  if [[ ! -d "$NODE_DIR" ]]; then
    local download_dir archive_path actual_sha
    download_dir="$(mktemp -d "${TMPDIR:-/tmp}/fitnessai-node.XXXXXX")"
    trap 'rm -rf "$download_dir"' EXIT
    archive_path="${download_dir}/${NODE_ARCHIVE}"

    curl --fail --location --proto '=https' --tlsv1.2 "$NODE_URL" --output "$archive_path"
    actual_sha="$(shasum -a 256 "$archive_path" | awk '{print $1}')"
    [[ "$actual_sha" == "$NODE_SHA256" ]] || fail "SHA-256 mismatch: $actual_sha"
    tar -xzf "$archive_path" -C "$CONDA_ROOT"
  fi

  [[ -d "$BMAD_BIN" ]] || fail "BMAD environment does not exist at $BMAD_BIN"
  for tool in node npm npx; do
    ensure_link "${CONDA_ROOT}/bin/${tool}" "../node-v${NODE_VERSION}-darwin-arm64/bin/${tool}"
    ensure_link "${BMAD_BIN}/${tool}" "${NODE_DIR}/bin/${tool}"
  done
  verify_installation
}

unlink_node() {
  for tool in node npm npx; do
    remove_link "${BMAD_BIN}/${tool}" "${NODE_DIR}/bin/${tool}"
    remove_link "${CONDA_ROOT}/bin/${tool}" "../node-v${NODE_VERSION}-darwin-arm64/bin/${tool}"
  done
  print -- "Links removed. Recoverable distribution retained at ${NODE_DIR}."
}

case "${1:-verify}" in
  install) install_node ;;
  verify) verify_installation ;;
  unlink) unlink_node ;;
  *) fail "usage: $0 [install|verify|unlink]" ;;
esac
