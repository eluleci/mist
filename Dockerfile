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
ENTRYPOINT ["/go/bin/mist", "--server"]

# HTTP Server listens on port 8080
EXPOSE 8080

# WS Server listens on port 8888
EXPOSE 8888

# TCP Server listens on port 1445
EXPOSE 1445
