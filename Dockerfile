FROM mambaorg/micromamba:1.5.8

# Explicitly switch to root for apt
USER root

RUN apt-get update && apt-get install -y \
    build-essential gfortran \
    && rm -rf /var/lib/apt/lists/*

ARG NB_USER=jovyan
ARG NB_UID=1000

COPY environment.yml /tmp/
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean --all -y

# Create Binder user
RUN useradd --create-home --shell /bin/bash -u $NB_UID $NB_USER && \
    chown -R $NB_UID:$NB_UID /home/$NB_USER

USER $NB_UID
WORKDIR /home/$NB_USER
EXPOSE 8888
CMD ["start-notebook.sh"]
