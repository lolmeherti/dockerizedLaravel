FROM nginx:latest

RUN rm /etc/nginx/conf.d/default.conf

RUN addgroup --gid 1001 wwwgroup \
    && adduser --system --uid 1000 --ingroup wwwgroup appuser \
    && adduser nginx wwwgroup

COPY nginx/default.conf /etc/nginx/conf.d/
