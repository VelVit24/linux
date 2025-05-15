FROM python:3.10-slim AS builder

WORKDIR /app

COPY pyproject.toml Makefile ./

RUN apt-get update && apt-get install -y make gcc
RUN make install

COPY . .

FROM python:3.10-slim

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /app .

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "58529"]
