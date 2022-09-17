FROM python:3.7.3-stretch

## Step 1:
# Create a working directory
WORKDIR /app

## Step 2:
# Copy source code to working directory
COPY app.py .
COPY model_data/boston_housing_prediction.joblib ./model_data/boston_housing_prediction.joblib

## Step 3:
# Install packages from requirements.txt
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir
# hadolint ignore=DL3013

## Step 4:
# Expose port 80
EXPOSE 80/tcp

## Step 5:
# Run app.py at container launch
CMD [ "python", "app.py"]