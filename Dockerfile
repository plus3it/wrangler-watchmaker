FROM plus3it/tardigrade-ci:0.26.0

WORKDIR /ci-harness
ENTRYPOINT ["make"]
