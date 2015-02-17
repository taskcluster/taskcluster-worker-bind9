REGISTRY ?= tutum.co/taskcluster

all:
	docker build -t "$(REGISTRY)/taskcluster-worker-bind9" --no-cache .

push:
	docker push "$(REGISTRY)/taskcluster-worker-bind9"

test:
	docker run -ti --name dns-server "${REGISTRY}/taskcluster-worker-bind9"

clean:
	-docker rm dns-server


