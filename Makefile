## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install:
	source ~/.devops/bin/activate
	pip install --upgrade pip &&\
	pip install -r requirements.txt

install-hadolint:
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64
	chmod +x /bin/hadolint

test:
	python -m unittest -v

lint:
	# Linter for Dockerfiles
	hadolint Dockerfile

	# Linter for Python code
	pylint app.py

all: install install-hadolint lint test
