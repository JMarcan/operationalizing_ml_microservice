#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build -file Dockerfile . --tag sklearn_app --label name=sklearn_app

# Step 2: 
# List docker images
docker image ls --filter label=name=sklearn_app

# Step 3: 
# Run flask app
docker run -it -p 8000:80 sklearn_app
