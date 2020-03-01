FROM gitpod/workspace-full

USER gitpod

RUN pyenv install -s 3.8.1 && pyenv global 3.8.1

RUN sudo apt-get update && sudo apt-get install -y ffmpeg && sudo apt-get clean &&\
    sudo rm -rf /var/cache/apt/* && sudo rm -rf /var/lib/apt/lists/*

ADD https://api.github.com/repos/ThePadawan/beevenue/git/commits/61e75c56be5466df8b22907458511a00dd33f259 beevenue-version.json
RUN git clone https://github.com/ThePadawan/beevenue.git

ADD https://api.github.com/repos/ThePadawan/beevenue-ui/git/commits/c1c6cd806c5c6d2464e5283e3a1eee6f6a706355 beevenue-ui-version.json
RUN git clone https://github.com/ThePadawan/beevenue-ui.git

# Since this is a dev environment, we won't use PostgreSQL, but something lighterweight instead.
# Thus, we don't have to install this huge requirement, speeding things up a bit.
RUN sed -e "/psycopg2.*$/d" -i beevenue/requirements.txt

RUN cd beevenue && pip install -r requirements.txt && pip install -r requirements.linuxonly.txt && cd ..

RUN cd beevenue-ui && npm install && cd ..
