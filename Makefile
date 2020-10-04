THIS = jsdokken

.PHONY: all website

all: convert website

website:
	bundle exec jekyll build


start-notebook:
	docker run -v $(pwd):/root/shared -w "/root/shared" --rm -p 8888:8888 pygmsh-lab:latest


start-container:
	docker run -v $(pwd):/root/shared -ti -w "/root/shared" --rm pygmsh-env:latest

convert:
	jupyter nbconvert --to python notebooks/tutorial_pygmsh.ipynb --output=../converted_files/tutorial_pygmsh.py
	jupyter nbconvert --to markdown notebooks/tutorial_pygmsh.ipynb --output=../converted_files/tutorial_pygmsh.md

build-docker:
	docker build . -t pygmsh-env --target pygmsh-env
	cd lab
	docker build . -t pygmsh-lab --target pygmsh-lab
	cd ..
