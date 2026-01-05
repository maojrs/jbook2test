
# Simple Clawpack + Jupyter Binder (~90s build)
FROM mambaorg/micromamba:1.5.8

USER root
RUN apt-get update && apt-get install -y \
    build-essential gfortran \
    && rm -rf /var/lib/apt/lists/*

COPY --chown=$MAMBA_USER:$MAMBA_GID environment.yml /tmp/
RUN micromamba install -y -n base -f /tmp/ && \
    micromamba clean --all -y

USER $MAMBA_USER
WORKDIR /home/$MAMBA_USER/work
EXPOSE 8888

