.PHONY: install install-dev test run

install:
	pip install --no-cache-dir .

install-dev:
	pip install ".[test]"

test:
	pytest tests

run:
	uvicorn src.main:app --reload
