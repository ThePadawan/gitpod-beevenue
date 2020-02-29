FROM gitpod/workspace-full

USER gitpod

RUN pyenv install 3.7.6 && pyenv global 3.7.6

RUN git clone https://github.com/ThePadawan/beevenue.git && \
    git clone https://github.com/ThePadawan/beevenue-ui.git

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && \
#     sudo apt-get install -yq bastet && \
#     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/
