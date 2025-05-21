FROM python:3.10.17-alpine3.21 AS builder-test

WORKDIR /app
ENV PYTHONPATH=/app

RUN apk add --no-cache make
   
COPY pyproject.toml Makefile ./

RUN make install-dev

COPY . .

FROM python:3.10.17-alpine3.21 AS builder

WORKDIR /app

RUN apk add --no-cache make
   
COPY pyproject.toml Makefile ./

RUN make install

COPY . .

FROM python:3.10.17-alpine3.21

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /app /app

RUN apk add --no-cache make

CMD ["uvicorn", "src.main:app", "--reload", "--host", "0.0.0.0", "--port", "8050"]
