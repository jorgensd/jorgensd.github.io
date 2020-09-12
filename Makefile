THIS = jsdokken

.PHONY: all website

all: convert website

website:
	bundle exec jekyll build


start-notebook:
	docker run -v "$(CURDIR):/root/shared" --rm -p 8888:8888 dolfinx/lab


convert:
	jupyter nbconvert --to python notebooks/tutorial_pygmsh.ipynb --output=../converted_files/tutorial_pygmsh.py
	jupyter nbconvert --to markdown notebooks/tutorial_pygmsh.ipynb --output=../converted_files/tutorial_pygmsh.md
