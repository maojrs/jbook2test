FROM mambaorg/micromamba:1.5.8

USER root
RUN apt-get update && apt-get install -y \
    build-essential gfortran \
    && rm -rf /var/lib/apt/lists/*

ARG NB_USER=jovyan
ARG NB_UID=1000

COPY environment.yml /tmp/
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean --all -y

# CRITICAL: Create user + copy repo contents
RUN useradd --create-home --shell /bin/bash -u $NB_UID $NB_USER
COPY --chown=$NB_UID:$NB_UID . /home/$NB_USER/work

USER $NB_UID
WORKDIR /home/$NB_USER/work
EXPOSE 8888
CMD ["start-notebook.sh"]
