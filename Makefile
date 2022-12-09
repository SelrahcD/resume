all: resume.fr.html resume.en.html

%.html: %.json
	npx resumed render $< -o $@