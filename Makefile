img:=do_rancher

build:
	docker build -t $(img) .

run-test:
	docker run --rm -it -e DIGITALOCEAN_TOKEN=${DIGITALOCEAN_TOKEN} $(img) sh