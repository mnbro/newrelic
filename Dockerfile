FROM fluent/fluentd:v1.14-debian-1

ARG plugins="fluent-plugin-systemd fluent-plugin-newrelic"
#Use root account to use apt
USER root

RUN buildDeps="sudo make gcc g++ libc-dev" \
 && apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo gem install $plugins \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem
