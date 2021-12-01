THIS = jsdokken

.PHONY: all website

all: convert website

website:
	bundle exec jekyll build


start-notebook:
	docker run -v $(pwd):/root/shared -w "/root/shared" --rm -p 8888:8888 pygmsh-lab:latest

start-lab:
	docker run -v $(PWD):/root/shared -w "/root/shared" --rm -p 8888:8888 dolfinx/lab


start-container:
	docker run -v $(pwd):/root/shared -ti -w "/root/shared" --rm dokken92/pygmsh:latest

convert:
	cp notebooks/gmsh_helpers.py converted_files/gmsh_helpers.py
	jupyter nbconvert --to python notebooks/tutorial_pygmsh.ipynb --output=../converted_files/tutorial_pygmsh.py
	jupyter nbconvert --to markdown notebooks/tutorial_pygmsh.ipynb --output=../converted_files/tutorial_pygmsh.md
	jupyter nbconvert --to python notebooks/tutorial_gmsh.ipynb --output=../converted_files/tutorial_gmsh.py
	jupyter nbconvert --to markdown notebooks/tutorial_gmsh.ipynb --output=../converted_files/tutorial_gmsh.md

build-docker:
	docker build . -t pygmsh-env --target pygmsh-env
	cd lab
	docker build . -t pygmsh-lab --target pygmsh-lab
	cd ..
