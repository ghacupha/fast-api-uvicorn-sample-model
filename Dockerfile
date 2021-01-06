FROM python:3.6-stretch

# Make directories suited to your application
RUN mkdir -p /app
WORKDIR /app

# install build utilities
RUN apt-get update && \
	apt-get install -y gcc make apt-utils apt-transport-https ca-certificates build-essential

# Copy and install requirements
COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt

# Copy contents from your local to your docker container
COPY ./app /app

EXPOSE 8000

# ENTRYPOINT ["uvicorn"]
# CMD ["api.main:app", "--host", "0.0.0.0"]
# CMD ["uvicorn", "main:app", "--host", "127.0.0.1", "--port", "8000"]
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]