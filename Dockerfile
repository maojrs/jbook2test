FROM mambaorg/micromamba:1.5.8

USER root
RUN apt-get update && apt-get install -y \
    build-essential gfortran \
    && rm -rf /var/lib/apt/lists/*

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV NB_USER=${NB_USER}
ENV NB_UID=${NB_UID}

COPY environment.yml /tmp/
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean --all -y

# Fix ownership for Binder (micromamba default paths)
RUN chown -R ${NB_UID}:${NB_UID} /usr/local/micromamba && \
    find /usr/local -user root -exec chown ${NB_UID}:${NB_UID} {} +

USER ${NB_UID}
WORKDIR /home/${NB_USER}
EXPOSE 8888
CMD ["/usr/local/micromamba/bin/micromamba", "shell", "hook", "--shell=bash", "-c", "start-notebook.sh"]
