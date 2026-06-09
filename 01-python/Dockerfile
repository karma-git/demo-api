FROM python:3.10-alpine3.18

RUN pip install --no-cache-dir uv

RUN addgroup --gid 10001 app \
  && adduser \
    --uid 10001 \
    --home /home/app \
    --shell /bin/ash \
    --ingroup app \
    --disabled-password \
    app

WORKDIR /home/app

COPY --chown=app:app . /home/app/

RUN uv sync --frozen --no-dev

USER app

EXPOSE 8080

ENTRYPOINT ["uv", "run"]
CMD ["python", "main.py"]
