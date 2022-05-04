#!make
include .env
export $(shell sed 's/=.*//' .env)

build: style

style:
	R -e "styler::style_dir('.')"

ddown:
	docker-compose down

dup:
	docker-compose up -d

logs:
	docker-compose logs -f

clean:
	rm -rf *.tar.gz
	rm -rf *.Rcheck

push:
	git add --all
	git commit -m '$m'
	git push origin $$(git rev-parse --abbrev-ref HEAD)


killassh:
	sudo killall autossh

ports:
	lsof -i -P -n | grep LISTEN

db:
	docker build -t ${IMAGE_TAG_SHINY} --file ./Dockerfile .

restart: ddown dup
drestart: db restart

fix_b:
	git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch $f" -- --all


as:
	autossh -f -nNT -R  5000:localhost:5000 -i /home/freddy/Projects/current/redpul/redpul-main.pem ubuntu@ndexr.com -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes
