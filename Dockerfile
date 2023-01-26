FROM python:3.8
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY app.py .
COPY templates ./templates
EXPOSE 5000
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]