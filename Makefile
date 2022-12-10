THEME=even

define BUILD
npx resume export -r $< $@ -t $(THEME)
endef

FILES=resume.fr.html resume.en.html resume.fr.pdf resume.en.pdf

all: $(FILES)

web: $(filter %.html,$(FILES))

pdf: $(filter %.pdf,$(FILES))

%.html: %.json
	$(BUILD)

%.pdf: %.json
	$(BUILD)

clear:
	$(RM) resume.*.pdf resume.*.html