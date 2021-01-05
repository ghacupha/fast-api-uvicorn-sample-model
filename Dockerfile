FROM tiangolo/uvicorn-gunicorn:python3.6-alpine3.8

COPY . /api
COPY requirements.txt /requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONPATH=/api
WORKDIR /api

EXPOSE 8000

ENTRYPOINT ["uvicorn"]
CMD ["api.main:app", "--host", "0.0.0.0"]