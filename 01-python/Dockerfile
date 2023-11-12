FROM python:3.10.0-alpine3.14

RUN addgroup --gid 10001 app \
  && adduser \
    --uid 10001 \
    --home /home/app \
    --shell /bin/ash \
    --ingroup app \
    --disabled-password \
    app

COPY ./ /home/app

WORKDIR /home/app

RUN pip install --no-cache-dir -r requirements.txt

USER app

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/python"]
CMD ["main.py"]

# ENTRYPOINT ["/usr/local/bin/uvicorn"]
# CMD ["main:app", "--reload", "--host=0.0.0.0", "--port=8080"]
