build:
	docker build -t sosedoff/codescout .

build_clean:
	docker build --no-cache=true --rm=true -t sosedoff/codescout .

test:
	docker run -i -t sosedoff/codescout /bin/bash

tag:
	docker tag codescout sosedoff/codescout

release:
	docker push sosedoff/codescout

clean:
	docker stop $(docker ps -a -q) ; echo
	docker rm $(docker ps -a -q) ; echo
	docker rmi sosedoff/codescout