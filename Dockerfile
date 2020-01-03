FROM python:3-alpine


ENV APP_DIR /usr/src/app

RUN mkdir -p ${APP_DIR}

COPY requirements.txt ${APP_DIR}

RUN chown -R 1000 ${APP_DIR}

WORKDIR ${APP_DIR}

RUN apk update && \
    apk add --no-cache bash git && \
    apk add python python3 python3-dev && \
    pip3 install --upgrade pip && \
	pip3 install flask gunicorn && \
    rm -rf /var/cache/apk/* 



RUN pip3 install --no-cache-dir -r requirements.txt

# Expose the Flask port
EXPOSE 5000
USER 1000

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
