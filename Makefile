THIS = jsdokken

.PHONY: all website

all: convert website

website:
	bundle exec jekyll build


start-notebook:
	docker run -v $(pwd):/root/shared -w "/root/shared" --rm -p 8888:8888 ghcr.io/jorgensd/jorgensd.github.io

start-lab:
	docker run -v $(PWD):/root/shared -w "/root/shared" --rm -p 8888:8888 dolfinx/lab:nightly


start-container:
	docker run -v $(pwd):/root/shared -ti -w "/root/shared" --rm ghcr.io/jorgensd/jorgensd.github.io

build-docker:
	docker build . -t pygmsh-env --target pygmsh-env