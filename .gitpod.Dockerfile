FROM gitpod/workspace-full

USER gitpod

RUN pyenv install -s 3.8.1 && pyenv global 3.8.1

RUN git clone https://github.com/ThePadawan/beevenue.git && \
    git clone https://github.com/ThePadawan/beevenue-ui.git

# Since this is a dev environment, we won't use PostgreSQL, but something lighterweight instead.
# Thus, we don't have to install this huge requirement, speeding things up a bit.
RUN sed -e "/psycopg2.*$/d" -i beevenue/requirements.txt

RUN cd beevenue && pip install -r requirements.txt && pip install -r requirements.linuxonly.txt && cd .. &&\
    mv /workspace/gitpod-beevenue/beevenue_config.py beevenue/ &&\
    mv /workspace/gitpod-beevenue/beevenue_rules.json beevenue/

RUN cd beevenue-ui && npm install && cd .. && \
    mv /workspace/gitpod-beevenue/ui-config.json beevenue-ui/src/config.json

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && \
#     sudo apt-get install -yq bastet && \
#     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/
