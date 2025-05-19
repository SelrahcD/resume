THEME=onepage-plus

define BUILD
npx resume export -r $< $@
endef

FILES=resume.fr.html resume.en.html

all: $(FILES)

web: $(filter %.html,$(FILES))

pdf: $(filter %.pdf,$(FILES))

%.html: %.json
	$(BUILD)
	./add_css.sh $@

%.pdf: %.json
	$(BUILD)

clear:
	$(RM) resume.*.pdf resume.*.html