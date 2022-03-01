# TODO make more general to use the local matlab version
MATLAB = /usr/local/MATLAB/R2017a/bin/matlab
ARG    = -nodisplay -nosplash -nodesktop

lint:
	mh_style --fix && mh_metric --ci && mh_lint

test:
	$(MATLAB) $(ARG) -r "runTests; exit()"

version.txt: CITATION.cff
	grep -w "^version" CITATION.cff | sed "s/version: /v/g" > version.txt

validate_cff: CITATION.cff
	cffconvert --validate

manual:
	cd docs && sh create_manual.sh
