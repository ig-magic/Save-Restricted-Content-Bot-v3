FROM python:3.10-bookworm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    ffmpeg \
    wget \
    bash \
    ca-certificates \
    && update-ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip wheel setuptools
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD sh -c "flask run -h 0.0.0.0 -p 5000 & python3 main.py"
