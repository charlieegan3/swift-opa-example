.PHONY: bundle_build docker_run run

bundle_build:
	opa build --target=plan --entrypoint=example/allow bundle/
	tar -xzf bundle.tar.gz -C bundle_extracted/

docker_run:
	docker run --rm -v $$(pwd):/workspace -w /workspace swift:6.0 swift run

run:
	swift run