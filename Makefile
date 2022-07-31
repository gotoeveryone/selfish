build:
	docker build -t selfish -f Dockerfile .

run:
	docker run -it selfish bash
