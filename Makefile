THIS = jsdokken

.PHONY: all website

all: website

website:
	bundle exec jekyll build
