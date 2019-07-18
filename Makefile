
build: dist

dist: dist/index.html dist/style.css

dist/index.html:
	pandoc -f gfm -t html --template src/template.html --section-divs README.md -o dist/index.html
	perl -i -p0e 's/<section id="[A-Za-z\-]*?" class="level3">(.*?)<\/section>/\1/gs' dist/index.html
	perl -i -p0e 's/<section id="[A-Za-z\-]*?" class="level2">(.*?)<h2>(.*?)<\/h2>(.*?)<\/section>/<div class="row"><div class="col"><div class="card bg-dark"><div class="card-header">\2<\/div><div class="card-body">\3<\/div><\/div><\/div><\/div>/gs' dist/index.html
	perl -i -p0e 's/<section id="[A-Za-z\-]*?" class="level1">\n<h1>(.*?)<\/h1>\n<p>(.*?)<\/p>(.*?)<\/section>/<div class="container py-5 col-9"><div class="jumbotron"><h1>\1<\/h1><p>\2<\/p><\/div>\3<\/div>/gs' dist/index.html
	perl -i -p0e 's/(<hr \/>\n<p>© 2019 browndawg et al<\/p>\n)(<\/div><\/div><\/div><\/div>)/\2\1/gs' dist/index.html



dist/style.css: vendor/bootstrap/scss
	sassc -t compressed -I vendor/bootstrap/scss -a src/style.scss dist/style.css

vendor/bootstrap/scss:
	git submodule init
	git submodule update

clean:
	rm -rf dist/*
