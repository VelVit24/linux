FROM python:3

WORKDIR /usr/src/app

COPY pyproject.toml Makefile ./

RUN make install

COPY . .

EXPOSE 58529

CMD [ "uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000" ]
