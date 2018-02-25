FROM hamub/django:v2
MAINTAINER Humphrey Butau <hbutau35@gmail.com>
# Let us copy our requirements file so that we can install our python dependencies.
ADD requirements.txt /requirements.txt

RUN set -ex \
    && apk add --no-cache --virtual \
    libpq-dev \
    postgresql-dev \
    musl-dev \
    libgcc \
    gcc \
    && pip install -U pip \
    && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pip install -U  --no-cache-dir -r requirements.txt " \ 
    # && apk del .build-deps
# Set the project directory for the source code to:  /home/django
WORKDIR /home/django/
# Copy our source code to the working directory
ADD . /home/django
EXPOSE 8000
# Run migrations, collectstatic, start uwsgi .... e.t.c
CMD ["/home/django/run-prod.sh"]
