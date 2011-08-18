
# Location of website files
SITE_DIR=site

# Location of website images
SITE_IMAGES_DIR=$(SITE_DIR)/images

SITE_CHAP_IMAGES_DIR=$(SITE_IMAGES_DIR)/chaps

SITE_STYLE_DIR=$(SITE_DIR)/style

# List of targets that are not files
.PHONY: all quick clean web print pdf screen quickpdf cleantmp cleanpdf cleanimages html htmlimages cleansite

all: pdf cleantmp
quick: quickpdf cleantmp
clean: cleantmp cleanpdf
web: images html

# Generate a print version PDF (for lulu.com)
print:
	xelatex '\def\mediaformat{print}\input{gitt}'
	makeindex gitt
	xelatex '\def\mediaformat{print}\input{gitt}'
	xelatex '\def\mediaformat{print}\input{gitt}'

# Generate the PDF (on-screen version)
pdf:
	xelatex '\def\mediaformat{screen}\input{gitt}'
	makeindex gitt
	xelatex '\def\mediaformat{screen}\input{gitt}'
	xelatex '\def\mediaformat{screen}\input{gitt}'

# An alias for generated the PDF
screen: pdf

# Quickly update the PDF. Will not update the index or cross-references
quickpdf:
	xelatex gitt

# Remove the temporary files generated by LaTeX
cleantmp:
	rm -f *.aux *.log *.out *.toc *.idx *.ind *.ilg

# Remove the generated PDF
cleanpdf:
	rm -f gitt.pdf

# Remove the generated website images
cleanimages:
	@rm -f $(SITE_IMAGES_DIR)/*.png

# Clean up generated site files
cleansite:
	@rm -fr $(SITE_DIR)

site: html htmlimages

# Convert TeX to HTML
html: $(SITE_IMAGES_DIR)
	@cp html/stylesheet.css $(SITE_DIR)/
	@cp html/read.html $(SITE_DIR)/
	@cp html/index.html $(SITE_DIR)/
	@python scripts/htmlbuild.py allchaps
	@python scripts/htmlbuild.py allafterhours
	@python scripts/htmlbuild.py intro
	@python scripts/htmlbuild.py setup

# Get a list of all SVG images
IMAGES=$(shell ls images/source/*.svg)

# Generate list of images required for the website
SITEIMAGES=$(shell for IMAGE in $(IMAGES); do echo "$$(basename $${IMAGE} .svg).png"; done)

# Generate PNG file from SVG file
%.png: images/source/%.svg $(SITE_IMAGES_DIR) $(SITE_CHAP_IMAGES_DIR)
	inkscape -f $< -D -w 400 -e $(SITE_CHAP_IMAGES_DIR)/f-$(shell basename $< .svg).png >/dev/null

# Convert all images
htmlimages: $(SITEIMAGES) $(SITE_CHAP_IMAGES_DIR)
	@cp images/f-w5-d1.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d1.png
	@cp images/f-w5-d2.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d2.png
	@cp images/f-w5-d3.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d3.png
	@cp images/f-w5-d4.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d4.png
	@cp images/f-w5-d5.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d5.png
	@cp images/f-w5-d6.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d6.png
	@cp images/f-w5-d7.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d7.png
	@cp images/f-w5-d8.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d8.png
	@cp images/f-w5-d9.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d9.png
	@cp images/f-w5-d10.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d10.png
	@cp images/f-w5-d11.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d11.png
	@cp images/f-w5-d12.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d12.png
	@cp images/f-w5-d13.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d13.png
	@cp images/f-w5-d14.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d14.png
	@cp images/f-w5-d15.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d15.png
	@cp images/f-w5-d16.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d16.png
	@cp images/f-w5-d17.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d17.png
	@cp images/f-w5-d18.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d18.png
	@cp images/f-w5-d19.png $(SITE_CHAP_IMAGES_DIR)/f-w5-d19.png
	@cp html/images/* $(SITE_IMAGES_DIR)/
	
# Make directories
$(SITE_DIR):
	@mkdir -p $(SITE_DIR)

$(SITE_STYLE_DIR):
	@mkdir -p $(SITE_STYLE_DIR)

$(SITE_IMAGES_DIR):
	@mkdir -p $(SITE_IMAGES_DIR)

$(SITE_CHAP_IMAGES_DIR):
	@mkdir -p $(SITE_CHAP_IMAGES_DIR)
