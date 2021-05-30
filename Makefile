clean:
	rm -rf build

init:
	docker build --target init -o build  .

pdf:
	docker build --target build-pdf --build-arg THEME=$(THEME) -o build .

server:
	docker build --target serve --build-arg THEME=$(THEME) -t resume-server .
	docker run --rm -p 4000:4000 -it resume-server