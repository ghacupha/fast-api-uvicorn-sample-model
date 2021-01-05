FROM python:3.6-stretch

# Make directories suited to your application
RUN mkdir -p /app
WORKDIR /app

# install build utilities
RUN apt-get update && \
	apt-get install -y gcc make apt-transport-https ca-certificates build-essential

# install openblas
RUN wget https://github.com/xianyi/OpenBLAS/archive/v0.3.6.tar.gz \
	&& tar -xf v0.3.6.tar.gz \
	&& cd OpenBLAS-0.3.6/ \
	&& make BINARY=64 FC=$(which gfortran) USE_THREAD=1 \
	&& make PREFIX=/usr/lib/openblas install

# Copy and install requirements
COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt

# Copy contents from your local to your docker container
COPY ./app /app

EXPOSE 8000

# ENTRYPOINT ["uvicorn"]
# CMD ["api.main:app", "--host", "0.0.0.0"]
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]