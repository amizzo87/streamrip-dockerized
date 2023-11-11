FROM python:3.9-slim-buster

WORKDIR /app

# Install Poetry
RUN pip install poetry

# Copy only requirements to cache them in docker layer
COPY pyproject.toml poetry.lock* /app/

# Project initialization:
# RUN poetry config virtualenvs.create false \
#  && \
RUN poetry install --no-interaction --no-ansi

# Copying in our source code
COPY . /app

# CMD [ "python3", "-m" , "streamrip", "--config", "/config/config.yml"]
CMD ["python", "./rip/__main__.py"]

# Volume for downloads
VOLUME /downloads

# Volume for streamrip db
VOLUME /db

# Volume for streamrip config
# VOLUME /config
