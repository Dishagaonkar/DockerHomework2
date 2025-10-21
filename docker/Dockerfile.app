# FROM python:3.11-alpine
# WORKDIR /app
# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0
# RUN apk add --no-cache gcc musl-dev
# COPY app/requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
# EXPOSE 5000
# COPY . .
# CMD ["flask", "run", "--debug", "python", "app.py"]



FROM python:3.11-alpine


RUN apk add --no-cache gcc musl-dev


WORKDIR /app

COPY src/requirements.txt ./requirements.txt


RUN pip install --no-cache-dir -r requirements.txt


COPY . .


ENV FLASK_APP=app.py \
    FLASK_RUN_HOST=0.0.0.0 \
    FLASK_RUN_PORT=5000 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

EXPOSE 5000

CMD ["flask", "run"]


