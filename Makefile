FIND_JSON ?= find . -name '*.json' -type f
XARGS_CMD ?= xargs -I {}

.PHONY: json.lint
json.lint:
	$(FIND_JSON) | $(XARGS_CMD) bash -c 'cmp {} <(jq --indent 4 -S . {}) || (echo "[{}]: Failed JSON Lint Test"; exit 1)'

.PHONY: tf.lint
tf.lint:
	terraform fmt -check=true
