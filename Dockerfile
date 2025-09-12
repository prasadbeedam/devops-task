FROM node:20.15.0-alpine3.20
EXPOSE 3000
RUN addgroup -S logoserver && adduser -S logoserver -G logoserver \
    && mkdir /opt/server \
    && chown logoserver:logoserver -R /opt/server
WORKDIR /opt/server
COPY package.json .
COPY *.js /opt/server/
RUN npm install
USER logoserver
CMD [ "node","app.js" ]