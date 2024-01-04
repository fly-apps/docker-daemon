FROM docker/buildx-bin:v0.12 as buildx

FROM docker:24-dind

RUN apk add bash iptables-legacy pigz sysstat procps lsof \
    && mv /sbin/iptables /sbin/iptables.original \
    && mv /sbin/ip6tables /sbin/ip6tables.original \
    && ln -s /sbin/iptables-legacy /sbin/iptables \
    && ln -s /sbin/ip6tables-legacy /sbin/ip6tables

COPY etc/docker/daemon.json /etc/docker/daemon.json

COPY --from=buildx /buildx /root/.docker/cli-plugins/docker-buildx

COPY ./entrypoint ./entrypoint
COPY ./docker-entrypoint.d/* ./docker-entrypoint.d/

ENV DOCKER_TMPDIR=/data/docker/tmp

ENTRYPOINT ["./entrypoint"]

CMD ["dockerd", "-p", "/var/run/docker.pid"]
