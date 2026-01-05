
FROM clawpack/v5.7.0_dockerimage:release
# this dockerhub image has a user jovyan and clawpack installed 
# in /home/jovyan/clawpack-v5.7.0


ENV NB_USER jovyan
User jovyan

WORKDIR ${HOME}


RUN pip install ipywidgets

ENV PATH ${PATH}:/home/jovyan/.local/bin



# Add book's files
RUN git clone --depth=1 https://github.com/maojrs/jbook2test

RUN pip install --user --no-cache-dir -r https://raw.githubusercontent.com/maojrs/jbook2test/main/requirements.txt

# The command below starts the notebook server, but better to not
# do this by default in case the user also wants to examine files or use
# the docker container for running other things...
#CMD jupyter notebook riemann_book/Index.ipynb --ip=0.0.0.0 --port=8889 --no-browser

