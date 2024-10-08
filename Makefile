default:  ## Build and serve the web site.
	python manage.py migrate
	python manage.py loaddata buttholes special-squares special-square-types rolls
	make scss
	python manage.py runserver

setup:  ## Install required environments and packages.
	pip install --requirement requirements.txt
	npm ci --production
	printf "SECRET_KEY=`pwgen --capitalize --numerals 50 1`\n" > .env

setup-dev:  ## Install required environments and packages for development.
	pip install --requirement requirements.txt
	npm ci
	printf "DEBUG=1\n" > .env

test: ## Run tests.
	pytest

check-django:  ## Check Django configuration. Will fail if DEBUG is set to true.
	python manage.py makemigrations --check
	python manage.py check --deploy --fail-level INFO

scss:  ## Build SCSS.
	python manage.py compilescss

help: ## Display this help screen.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: pyenv-virtualenv
pyenv-virtualenv:  ## Create a virtual environment managed by pyenv-virtualenv.
	pyenv install --skip-existing `cat runtime.txt | sed "s/python-//"`
	pyenv virtualenv `cat runtime.txt | sed "s/python-//"` will-of-the-prophets
	echo "will-of-the-prophets" > .python-version

.PHONY: pyenv-virtualenv-delete
pyenv-virtualenv-delete:  ## Delete a virtual environment managed by pyenv-virtualenv.
	pyenv virtualenv-delete --force `cat .python-version || echo will-of-the-prophets`
	rm -f .python-version

requirements.txt: requirements.in;
	pip-compile --allow-unsafe --generate-hashes --strip-extras

cypress.env.json:  ## Create Cypress environment file.
	echo "{\n  \"initCommand\": \"python manage.py loaddata full-stack\"\n}" > cypress.env.json

.PHONY: will_of_the_prophets/fixtures/buttholes.json
will_of_the_prophets/fixtures/buttholes.json:  ## Update buttholes fixture from production.
	heroku run --app will-of-the-prophets \
		-- python manage.py dumpdata will_of_the_prophets.Butthole \
		> will_of_the_prophets/fixtures/buttholes.json


.PHONY: will_of_the_prophets/fixtures/rolls.json
will_of_the_prophets/fixtures/rolls.json:  ## Update rolls fixture from production.
	heroku run --app will-of-the-prophets \
		-- python manage.py dumpdata will_of_the_prophets.Roll \
		> will_of_the_prophets/fixtures/rolls.json


.PHONY: will_of_the_prophets/fixtures/special-square-types.json
will_of_the_prophets/fixtures/special-square-types.json:  ## Update special square type fixture from production.
	heroku run --app will-of-the-prophets \
		-- python manage.py dumpdata will_of_the_prophets.SpecialSquareType \
		> will_of_the_prophets/fixtures/special-square-types.json


.PHONY: will_of_the_prophets/fixtures/special-squares.json
will_of_the_prophets/fixtures/special-squares.json:  ## Update special square fixture from production.
	heroku run --app will-of-the-prophets \
		-- python manage.py dumpdata will_of_the_prophets.SpecialSquare \
		> will_of_the_prophets/fixtures/special-squares.json

.PHONY: all clean test
