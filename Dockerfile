# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Define environment variable
# ENV NAME foobar

# Run the command to start the app
CMD ["python", "./rip/__main__.py"]

# Volume for downloads
VOLUME /downloads

# Volume for streamrip db
VOLUME /db

# Volume for streamrip config
# VOLUME /config
