clean:
	@find . -name '*.pyc' -exec rm -f {} \; ||:
	@find . -name '*.cache' -exec rm -fr {} \; ||:
	@find . -name 'Thumbs.db' -exec rm -f {} \; ||:
	@find . -name '*~' -exec rm -f {} \; ||:
	@find . -name '*.pyc' -exec rm -f {} \; ||:
	@find . -name '__pycache__' -exec rm -fr {} \; ||:

requirements:
	@pip install -r requirements.txt

requirements.test:
	@pip install -r requirements.test.txt

requirements.pypi:
	@pip install -r requirements.pypi.txt

test:
	@rm -rf .coverage
	@rm -rf htmlcov/
	@pytest --cov=pickleclip --cov-report term --cov-report html \
				  --cov-config .coveragerc tests/

setup: clean requirements test

clean.build:
	@rm -rd build/ ||:
	@rm -rd dist/ ||:
	@rm -rd *.egg-info ||:

dist: clean.build
	@python setup.py sdist
	@python setup.py bdist_wheel --universal

upload:
	@twine upload dist/*

pypi: dist upload
