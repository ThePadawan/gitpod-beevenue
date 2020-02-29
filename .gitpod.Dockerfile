FROM gitpod/workspace-full

USER gitpod

RUN pyenv install -s 3.8.1 && pyenv global 3.8.1

ADD https://api.github.com/repos/ThePadawan/beevenue/git/refs/heads/master beevenue-version.json
RUN git clone https://github.com/ThePadawan/beevenue.git

ADD https://api.github.com/repos/ThePadawan/beevenue-ui/git/refs/heads/master beevenue-ui-version.json
RUN git clone https://github.com/ThePadawan/beevenue-ui.git

# Since this is a dev environment, we won't use PostgreSQL, but something lighterweight instead.
# Thus, we don't have to install this huge requirement, speeding things up a bit.
RUN sed -e "/psycopg2.*$/d" -i beevenue/requirements.txt

RUN cd beevenue && pip install -r requirements.txt && pip install -r requirements.linuxonly.txt && cd ..

RUN cd beevenue-ui && npm install && cd ..
