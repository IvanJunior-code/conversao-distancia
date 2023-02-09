FROM python:3.8 as build
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY app.py .
COPY templates ./templates

FROM alpine:3.14 as final
WORKDIR /app
RUN apk add --update --no-cache python3 && \
    ln -sf python3 /usr/bin/python && \
    python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools && \
    pip3 install flask
COPY --from=build /app/app.py .
COPY --from=build /app/templates ./templates
EXPOSE 5000
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]