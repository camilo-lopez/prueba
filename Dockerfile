FROM python:3.8.3-slim-buster
ENV DEBIAN_FRONTEND noninteractive
RUN apt update
RUN     apt-get install -y x11vnc xvfb
RUN     mkdir ~/.vnc
RUN     x11vnc -storepasswd 1234 ~/.vnc/passwd
RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        bzip2 \
        libfontconfig \
        curl
RUN apt-get install -y libmagic-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN set -x && apt-get update
RUN apt-get -y install libcurl4-openssl-dev libssl-dev
RUN apt-get -y install gcc
RUN apt-get -y install python3-dev
RUN apt-get -y install wget
RUN apt-get -y install gconf-service \
        libasound2 \
        libatk1.0-0 \
        libc6 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libexpat1 \
        libfontconfig1 \
        libgcc1 \
        libgconf-2-4 \
        libgdk-pixbuf2.0-0 \
        libglib2.0-0 \
        libgtk-3-0 \
        libnspr4 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libstdc++6 \
        libx11-6 \
        libx11-xcb1 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxtst6 \
        fonts-liberation \
        libappindicator1 \
        libnss3 \
        lsb-release \
        xdg-utils\
        xvfb
RUN wget -O ~/FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-73.0&os=linux64"
RUN tar xjf ~/FirefoxSetup.tar.bz2 -C /opt/
RUN mkdir -p /usr/lib/firefox
RUN ln -s /opt/firefox/firefox /usr/bin/firefox
RUN rm ~/FirefoxSetup.tar.bz2
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz
RUN tar -xvzf geckodriver-v0.26.0-linux64.tar.gz
RUN mkdir -p /opt/drivers
RUN mv geckodriver /opt/drivers/geckodriver


COPY app/requirements.txt requirements.txt
RUN pip3 install -r requirements.txt


# Set working directory to function root directory

WORKDIR /app


ENV AWS_DEFAULT_REGION=us-east-1
ENV ENV=production


COPY . .

RUN mkdir -p /tmp/download

RUN ls 

CMD /usr/local/bin/shell.sh ; sleep infinity
