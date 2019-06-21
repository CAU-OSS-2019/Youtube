FROM python:3.7.3-alpine3.9

ENV TZ=Asia/Seoul
VOLUME [/tmp,/app]

RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/* \
        && /bin/bash

RUN pip3 install oauth2client python-dateutil httplib2 google_auth_oauthlib google-api-python-client pickle-mixin

ENV BROADCAST_ID=""

RUN mkdir /app
ADD ./ /app/

RUN echo -e '#!/bin/bash \n \
python bot.py $BROADCAST_ID' > /app/start.sh


WORKDIR /app
ENTRYPOINT ["bash","start.sh"]
