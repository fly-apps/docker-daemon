FROM docker/buildx-bin:v0.8 as buildx

FROM docker:20

RUN apk add bash ip6tables pigz sysstat procps lsof

COPY etc/docker/daemon.json /etc/docker/daemon.json

COPY --from=buildx /buildx /root/.docker/cli-plugins/docker-buildx

COPY ./entrypoint ./entrypoint
COPY ./docker-entrypoint.d/* ./docker-entrypoint.d/

ENV DOCKER_TMPDIR=/data/docker/tmp

ENTRYPOINT ["./entrypoint"]

CMD ["dockerd", "-p", "/var/run/docker.pid"]