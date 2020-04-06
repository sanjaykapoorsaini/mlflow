FROM conda/miniconda3:latest
LABEL Sanjay kumar "sanjaykapoorsaini@gmail.com"

RUN mkdir -p /mlflow/mlruns

WORKDIR /mlflow

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo "export LC_ALL=$LC_ALL" >> /etc/profile.d/locale.sh
RUN echo "export LANG=$LANG" >> /etc/profile.d/locale.sh

RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libpq-dev

RUN pip install -U pip && \
    pip install --ignore-installed google-cloud-storage && \
    pip install psycopg2 mlflow
RUN apt-get install -y default-libmysqlclient-dev
RUN pip install mysqlclient && pip install azure-storage && \
	pip install boto3

COPY ./start.sh ./start.sh
RUN chmod +x ./start.sh

EXPOSE 80
EXPOSE 443

CMD ["./start.sh"]