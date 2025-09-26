FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY /ml_app/train.py .
RUN python train.py

COPY /ml_app/app.py .
ENV MODEL_PATH=/app/model.npz
ENV ERROR_RATE=0.1

EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]