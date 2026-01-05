FROM mambaorg/micromamba:1.5.8

# System deps
RUN apt-get update && apt-get install -y \
    build-essential gfortran \
    && rm -rf /var/lib/apt/lists/*

# Binder args
ARG NB_USER=jovyan
ARG NB_UID=1000

# Install packages (as root)
COPY environment.yml /tmp/
RUN micromamba install -y -n base -f /tmp/environment.yml && \
    micromamba clean --all -y

# Create jovyan user + fix perms
RUN adduser --disabled-password --gecos '' --uid $NB_UID $NB_USER && \
    chown -R $NB_UID:$NB_UID /home/$NB_USER /opt/conda

USER $NB_UID
WORKDIR /home/$NB_USER
EXPOSE 8888
