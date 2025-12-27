# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-selkies:debiantrixie

# set version label
ARG BUILD_DATE
ARG CODIUM_VERSION
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thelamer"

# title
ENV TITLE=VSCodium

RUN \
  echo "**** add icon ****" && \
  curl -o \
  /usr/share/selkies/www/icon.png \
  https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/vscodium-icon.png && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  caja \
  chromium \
  chromium-l10n \
  git \
  gnome-keyring \
  ssh-askpass \
  stterm && \
  echo "**** install codium ****" && \
  mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg | \
  gpg --dearmor --yes -o /etc/apt/keyrings/antigravity-repo-key.gpg && \
  echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | \
  tee /etc/apt/sources.list.d/antigravity.list > /dev/null && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  antigravity && \
  echo "**** container tweaks ****" && \
  mv \
  /usr/bin/chromium \
  /usr/bin/chromium-real && \
  mv \
  /usr/bin/antigravity \
  /usr/bin/antigravity-real && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
  /var/lib/apt/lists/* \
  /var/tmp/* \
  /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3001

VOLUME /config


RUN apt-get update && \
  apt-get install -y curl ca-certificates kmod lsb-release && \
  curl -s https://repo.waydro.id | bash && \
  apt-get install -y waydroid && \
  rm -rf /var/lib/apt/lists/*