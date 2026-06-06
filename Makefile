.PHONY: help install lint test build clean

help:
	@echo "Available targets:"
	@echo "  install  - install package and dependencies"
	@echo "  lint     - run flake8 and black check"
	@echo "  test     - run tests with coverage"
	@echo "  build    - build distribution package"
	@echo "  clean    - remove build artifacts"
	@echo "  all      - clean, lint, test, build"

install:
	pip install -e .
	pip install -r requirements.txt

lint:
	flake8 src/ tests/
	black --check src/ tests/

test:
	pytest tests/ -v --cov=src --cov-report=term-missing --cov-report=xml --cov-fail-under=80

build: clean install lint test
	python -m build

clean:
	rm -rf build/ dist/ *.egg-info .pytest_cache .coverage coverage.xml
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true

all: clean lint test build