FROM base/archlinux
MAINTAINER Humphrey Butau:hbutau35@gmail.com
# add a South African mirror so that packages install faster
ADD mirrorlist /etc/pacman.d/mirrorlist
# Install gcc which is required to install uwsg
# Install python, and python-psycopg2 for Postgres support
RUN set -ex \
    && pacman -Sy --noconfirm \
    gcc \
    python \
    python-pip \
    python-psycopg2
# Let us copy our requirements file so that we can install our python dependencies.
ADD requirements.txt /requirements.txt
RUN pip install -U pip \
    && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pip install -U  --no-cache-dir -r requirements.txt "
RUN pacman -S -c -c --noconfirm \
    && pacman -R gcc python2 python-pip --noconfirm
# Set the project directory for the source code to:  /home/django
RUN mkdir -p /home/django
WORKDIR /home/django/
# Copy our source code to the working directory
ADD . /home/django
EXPOSE 8000
# Run migrations, collectstatic, start uwsgi .... e.t.c
CMD ["/home/django/run-prod.sh"]

