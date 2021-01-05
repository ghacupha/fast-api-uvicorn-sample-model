FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-alpine3.10

# Make directories suited to your application
RUN mkdir -p /app
WORKDIR /app

RUN apk --no-cache add musl-dev linux-headers g++

RUN pip download scipy==1.3

RUN  echo -e '[DEFAULT]\n\
library_dirs = /usr/lib/openblas/lib\n\
include_dirs = /usr/lib/openblas/lib\n\n\
[atlas]\n\
atlas_libs = openblas\n\
libraries = openblas\n\n\
[openblas]\n\
libraries = openblas\n\
library_dirs = /usr/lib/openblas/lib\n\
include_dirs = /usr/lib/openblas/lib'  >> site.cfg 

# Copy and install requirements
COPY requirements.txt /app
RUN pip install --no-cache-dir -r requirements.txt

# Copy contents from your local to your docker container
COPY ./app /app

EXPOSE 8000

# ENTRYPOINT ["uvicorn"]
# CMD ["api.main:app", "--host", "0.0.0.0"]
# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]