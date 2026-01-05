FROM mambaorg/micromamba:1.5.8

USER root
RUN apt-get update && apt-get install -y \
    build-essential gfortran \
    && rm -rf /var/lib/apt/lists/*

# Install WITHOUT --chown (repo2docker handles it)
COPY environment.yml /tmp/

# Use ARG for Binder compatibility
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV UID ${NB_UID}
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean --all -y && \
    chown -R ${NB_UID}:${NB_UID} /opt/mamba

USER ${NB_UID}
WORKDIR /home/${NB_USER}
EXPOSE 8888

