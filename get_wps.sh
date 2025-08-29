#!/usr/bin/bash

VERSION="12.1.2.22570"
dest_filename="wps-office.deb"
if [[ "$(uname -m)" == "x86_64" ]]; then
  ARCH="amd64"
elif [[ "$(uname -m)" == "aarch64" ]]; then
  ARCH="arm64"
fi

_get_source_url() {
  local furl="https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2023/${VERSION##*.}/wps-office_${VERSION}.AK.preread.sw_474164_${ARCH}.deb"
  local uri="${furl#https://wps-linux-personal.wpscdn.cn}"
  local secrityKey='7f8faaaa468174dc1c9cd62e5f218a5b'
  local timestamp10=$(date '+%s')
  local md5hash=$(echo -n "${secrityKey}${uri}${timestamp10}" | md5sum)
  echo "${furl}?t=${timestamp10}&k=${md5hash%% *}"
}

download() {
  curl -L -o "$dest_filename" "$(_get_source_url)"
}

download
