REGISTRY ?= "tutum.co/jonasfj"

all:
	docker build -t "$REGISTRY/taskcluster-worker-bind9" --no-cache .

test:
	docker run -ti --name dns-server "$REGISTRY/taskcluster-worker-bind9"

clean:
	-docker rm dns-server


