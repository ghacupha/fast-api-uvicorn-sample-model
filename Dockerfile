FROM tiangolo/uvicorn-gunicorn:python3.6-alpine3.8

# Make directories suited to your application
RUN mkdir -p /home/project/app
WORKDIR /home/project/app


RUN apk add --update apt-get

# Copy and install requirements
COPY requirements.txt /home/project/app
# RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        make \
        gcc \
    && pip install -r requirements.txt \
    && apt-get remove -y --purge make gcc build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Copy contents from your local to your docker container
COPY . /home/project/app