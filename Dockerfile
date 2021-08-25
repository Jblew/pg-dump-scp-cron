# Source: https://github.com/Ekito/docker-cron
FROM postgres:13-buster

RUN apt-get update
RUN apt-get -y install cron sshpass openssh-client gettext-base

ADD crontab.template /crontab.template
RUN touch /var/log/cron.log

ADD backup_pg.sh /backup_pg.sh
RUN chmod +x /backup_pg.sh

STOPSIGNAL SIGKILL

# Printenv hack: https://stackoverflow.com/questions/27771781/how-can-i-access-docker-set-environment-variables-from-a-cron-job
# Also cron requires an empty line at the end of crontab
CMD bash -c "envsubst < /crontab.template > /etc/cron.d/hello-cron && \
    printf \"\n\n\" >> /etc/cron.d/hello-cron && \
    cat /etc/cron.d/hello-cron && \
    chmod 0644 /etc/cron.d/hello-cron && \
    printenv | grep -v \"no_proxy\" >> /etc/environment" && cron && tail -f /var/log/cron.log
