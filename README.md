To build the webpage locally, call:

The prerequisites for building the website can be installed by running:
```bash
apt-get install -y ruby-bundler ruby-dev
apt-get install -y build-essential gcc make
bundle install
```
The website can then be built by running:
```bash
bundle exec jekyll build
```
The website can be served locally (so it can then be opened in a browser) by running:
```bash
bundle exec jekyll serve
```

To update the Python/Notebooks, update either file, and call
```bash
jupytext --sync src/name_of_file.ext
```
to update the others