FROM alpine as buildx

RUN apk add curl jq

RUN mkdir -p /root/.docker/cli-plugins
RUN curl -L https://github.com/docker/buildx/releases/download/v0.5.1/buildx-v0.5.1.linux-amd64 > /root/.docker/cli-plugins/docker-buildx
RUN chmod a+x /root/.docker/cli-plugins/docker-buildx

FROM docker:20

RUN apk add bash ip6tables pigz sysstat procps lsof

COPY etc/docker/daemon.json /etc/docker/daemon.json

COPY --from=buildx /root/.docker /root/.docker

COPY ./entrypoint ./entrypoint
COPY ./docker-entrypoint.d/* ./docker-entrypoint.d/

ENV DOCKER_TMPDIR=/data/docker/tmp

ENTRYPOINT ["./entrypoint"]

CMD ["dockerd", "-p", "/var/run/docker.pid", "--tls=false"]