THEME=even

all: resume.fr.html resume.en.html resume.fr.pdf

%.html: %.json
	npx resume export -r $< $@ -t $(THEME)
# 	npx resumed render $< -o $@ -t $(THEME)

%.pdf: %.json
	npx resume export -r $< $@ -t $(THEME)

clear:
	$(RM) resume.*.pdf resume.*.html