FROM openjdk:23-jdk-slim

RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/*

VOLUME /app/server
VOLUME /app/backup

WORKDIR /app/config

COPY ./server.properties /app/config/server.properties
COPY ./eula.txt /app/config/eula.txt
COPY ./paper-1.21.8-60.jar /app/config/paper-1.21.8-60.jar

WORKDIR /app/cron

COPY ./scripts/cron-bkp-5m.sh /app/cron/cron-bkp-5m.sh
COPY ./scripts/cron-bkp-1d.sh /app/cron/cron-bkp-1d.sh
COPY ./scripts/cron-bkp-1w.sh /app/cron/cron-bkp-1w.sh

RUN chmod +x /app/cron/cron-bkp-5m.sh
RUN chmod +x /app/cron/cron-bkp-1d.sh
RUN chmod +x /app/cron/cron-bkp-1w.sh

# Set up cron jobs for backups
RUN echo "*/5 * * * * /app/cron/cron-bkp-5m.sh" > /tmp/crontab && \
    echo "0 2 * * * /app/cron/cron-bkp-1d.sh" >> /tmp/crontab && \
    echo "0 3 * * 0 /app/cron/cron-bkp-1w.sh" >> /tmp/crontab && \
    crontab /tmp/crontab && \
    rm /tmp/crontab

WORKDIR /app/server

# Start cron service and run Minecraft server
CMD cp /app/config/server.properties /app/server/server.properties && \
    cp /app/config/eula.txt /app/server/eula.txt && \
    cp /app/config/paper-1.21.8-60.jar /app/server/paper-1.21.8-60.jar && \
    service cron start && java -jar /app/server/paper-1.21.8-60.jar --nogui