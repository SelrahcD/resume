all: resume.fr.html resume.en.html resume.fr.pdf

%.html: %.json
	npx resumed render $< -o $@ -t even

%.pdf: %.json
	npx resumed render $< -o $@ -t even

clear:
	$(RM) resume.*.pdf resume.*.html