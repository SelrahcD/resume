all: resume.fr.html

resume.fr.html: resume.fr.json
	npx resumed render $< -o $@