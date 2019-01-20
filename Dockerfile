########################
# INSTRUCTIONS
########################

# Build image:
# docker build -t mentornity/api .
# docker build -t gcr.io/mentornity-151313/api:v1 .

# gcloud docker -- push gcr.io/mentornity-151313/api:v1

# Run container
# docker run --publish 1707:1707 --name api mentornity/api
# kubectl run api --image=gcr.io/mentornity-151313/api:v1 --port=1707
# kubectl expose deployment api --type="LoadBalancer" --port=80 --target-port=1707

# After running the container there will be an output like 'No configuration file found.' and the container will exit.
# Copy configuration file
# docker cp api-config.json api:/go/api-config.json

# Start container again
# docker start api

########################

# Start from a Debian image with the latest version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/eluleci/mist

# Install all dependencies
RUN cd src/github.com/eluleci/mist; go get .

# Build the command inside the container.
RUN go install github.com/eluleci/mist

# Run the dock command by default when the container starts.
ENTRYPOINT /go/bin/mist

# WS Server listens on port 8888
EXPOSE 8888

# TCP Server listens on port 1445
EXPOSE 1445
