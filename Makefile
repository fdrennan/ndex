#!make
include .env
export $(shell sed 's/=.*//' .env)

build: style

sass:
	/home/freddy/.node/node-v17.4.0-linux-x64/bin/sass ./www/styles.scss ./www/styles.css
style: sass
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
	docker-compose build

restart: ddown dup

dr: db restart

drl: db restart logs

rl: restart logs

fix_b:
	git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch $f" -- --all


asf:
	autossh -f -nNT -R  5000:localhost:5000 -i /home/freddy/Projects/current/redpul/redpul-main.pem ubuntu@ndexr.com -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes


as:
	autossh -f -nNT -R 5000:localhost:5000 -i ~/redpul-main.pem ubuntu@ndexr.com -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes
	autossh -f -nNT -R 8443:localhost:8443 -i ~/redpul-main.pem ubuntu@ndexr.com -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes
	autossh -f -nNT -R 8321:localhost:8321 -i ~/redpul-main.pem ubuntu@ndexr.com -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes
	autossh -f -nNT -R 8385:localhost:8385 -i ~/redpul-main.pem ubuntu@ndexr.com -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes