FROM n8nio/n8n

USER root

COPY ./init.sh /init.sh
COPY ./*.json /workflows/

RUN chmod +x /init.sh

USER node

ENTRYPOINT ["/bin/sh", "/init.sh"]