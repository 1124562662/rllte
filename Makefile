SHELL=/bin/bash
LINT_PATHS=hsuanwu/

pytest: 
	sh ./scripts/run_tests.sh

pytype:
	pytype -j auto ${LINT_PATHS}

type: pytype

lint:
	# stop the build if there are Python syntax errors or undefined names
	# see https://www.flake8rules.com/
	ruff ${LINT_PATHS} --select=E9,F63,F7,F82 --show-source
	# exit-zero treats all errors as warnings.
	ruff ${LINT_PATHS} --exit-zero

format:
	# Sort imports
	isort ${LINT_PATHS}
	# Reformat using black
	black ${LINT_PATHS}

check-codestyle:
	# Sort imports
	isort --check ${LINT_PATHS}
	# Reformat using black
	black --check ${LINT_PATHS}

commit-checks: format type lint

build:
	python3 -m build

twine:
	python3 -m twine upload --repository pypi dist/*

gendocs:
	gendocs --config mkgendocs.yml
