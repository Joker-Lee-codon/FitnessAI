#!/bin/zsh
set -eu

[[ "$(uname -m)" == "arm64" ]] || { print -u2 "Expected arm64 host"; exit 1; }
[[ "$(xcodebuild -version | tr '\n' ' ')" == "Xcode 26.6 Build version 17F113 " ]] || {
  print -u2 "Expected Xcode 26.6 build 17F113"; exit 1
}
[[ "$(xcrun swift --version)" == *"Apple Swift version 6.3.3"* ]] || {
  print -u2 "Expected Apple Swift 6.3.3"; exit 1
}
