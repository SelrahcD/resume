THEME=actual

define BUILD
npx resume export -r $< $@ -t $(THEME)
endef

all: resume.fr.html resume.en.html resume.fr.pdf resume.en.pdf

%.html: %.json
	$(BUILD)

%.pdf: %.json
	$(BUILD)

clear:
	$(RM) resume.*.pdf resume.*.html