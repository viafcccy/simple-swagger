FROM swaggerapi/swagger-ui
ENV TZ=Asia/Shanghai
ENV LANG=zh_CN.utf8
ENV FAKETIME=-0
ENV BASE_URL=/
ENV CONFIG_URL=swagger-config.json
COPY swagger-config.json /usr/share/nginx/html/
COPY docs/*.json /usr/share/nginx/html/docs/

