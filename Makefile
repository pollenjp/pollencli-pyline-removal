PYTHON_PACKAGE_NAME := pollencli-pyline-removal

.PHONY: develop-install
develop-install:
	poetry install

.PHONY: develop-uninstall
develop-uninstall:
	python setup.py develop --uninstall

.PHONY: build-dist
build-dist:
	poetry build

.PHONY: testpypi-upload
testpypi-upload:
	${MAKE} clean
	${MAKE} build-dist
	poetry publish -r testpypi

.PHONY: testpypi-install
testpypi-install:
	${MAKE} clean
	pip install \
		--no-cache-dir \
		--upgrade \
		--index-url https://test.pypi.org/simple/ \
		${PYTHON_PACKAGE_NAME}

.PHONY: pypi-upload
pypi-upload:
	${MAKE} clean
	${MAKE} build-dist
	poetry publish -r pypi

.PHONY: pypi-install
pypi-install:
	${MAKE} clean
	pip install \
		--no-cache-dir \
		--upgrade \
		${PYTHON_PACKAGE_NAME}

.PHONY: clean
clean:
	-rm -rf \
		dist \
		build \
		src/*.egg-info
	-pip uninstall -y ${PYTHON_PACKAGE_NAME}
