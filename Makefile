THEME=even

all: resume.fr.html resume.en.html resume.fr.pdf resume.en.pdf

%.html: %.json
	npx resume export -r $< $@ -t $(THEME)

%.pdf: %.json
	npx resume export -r $< $@ -t $(THEME)

clear:
	$(RM) resume.*.pdf resume.*.html