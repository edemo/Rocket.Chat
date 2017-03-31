all: documentation

documentation: shippable/haz/index.html

shippable/haz/index.html: shippable haz.compiled
	cp -r haz shippable

shippable:
	mkdir -p shippable

include /usr/share/zenta-tools/model.rules

testenv:
	docker run --rm -p 5900:5900 -v $$(pwd):/rocketchat -w /rocketchat -it edemo/pdengine

clean:
	git clean -fdx

inputs/haz.issues.xml: zentaworkaround
	mkdir -p inputs
	getGithubIssues https://api.github.com "repo:edemo/Rocket.Chat&per_page=100" >inputs/haz.issues.xml

zentaworkaround:
	mkdir -p ~/.zenta/.metadata/.plugins/org.eclipse.e4.workbench/
	cp workbench.xmi ~/.zenta/.metadata/.plugins/org.eclipse.e4.workbench/
	touch zentaworkaround

