amd64:
	docker build -t zi-build -f Dockerfile .

arm32:
	env DOCKER_HOST=ssh://pi@raspberrypi docker build -t zi-build -f Dockerfile .
