
build: dist

dist: dist/index.html dist/style.css dist/img dist/robots.txt

dist/index.html: src/template.html README.md
	pandoc -f markdown -t html --template src/template.html --section-divs README.md --metadata="title:GNU/Lag" -o dist/index.html
	perl -i -p0e 's/<header>.*?<\/header>//gs' dist/index.html
	perl -i -p0e 's/<section id="[A-Za-z0-9\-]*?" class="level3">(.*?)<\/section>/\1/gs' dist/index.html
	perl -i -p0e 's/<section id="[A-Za-z0-9\-]*?" class="level2">(.*?)<h2>(.*?)<\/h2>(.*?)<\/section>/<div class="row"><div class="col"><div class="card bg-dark"><div class="card-header">\2<\/div><div class="card-body">\3<\/div><\/div><\/div><\/div>/gs' dist/index.html
	perl -i -p0e 's/<section id="[A-Za-z0-9\-]*?" class="level1">\n<h1>(.*?)<\/h1>\n<p>(.*?)<\/p>(.*?)<\/section>/<div class="container py-5"><div class="jumbotron"><h1>\1<\/h1><p>\2<\/p><\/div>\3<\/div>/gs' dist/index.html
	perl -i -p0e 's/<p><img src="(.*?)" alt="(.*?)" \/><\/p>/<img class="mx-auto d-block img-fluid" src="\1" alt="\2" \/>/gs' dist/index.html
	perl -i -p0e 's/(<hr \/>\n<p>© 2019 browndawg et al<\/p>\n)(<\/div><\/div><\/div><\/div>)/\2\1/gs' dist/index.html

dist/index.html: src/template.html tuxiee-in-remembrance.md
	pandoc -f markdown -t html --template src/template.html --section-divs tuxiee-in-remembrance.md --metadata="title:GNU/Lag" -o dist/tuxiee-in-remembrance.html
	perl -i -p0e 's/<header>.*?<\/header>//gs' dist/tuxiee-in-remembrance.html
	perl -i -p0e 's/<section id="[A-Za-z0-9\-]*?" class="level3">(.*?)<\/section>/\1/gs' dist/tuxiee-in-remembrance.html
	perl -i -p0e 's/<section id="[A-Za-z0-9\-]*?" class="level2">(.*?)<h2>(.*?)<\/h2>(.*?)<\/section>/<div class="row"><div class="col"><div class="card bg-dark"><div class="card-header">\2<\/div><div class="card-body">\3<\/div><\/div><\/div><\/div>/gs' dist/tuxiee-in-remembrance.html
	perl -i -p0e 's/<section id="[A-Za-z0-9\-]*?" class="level1">\n<h1>(.*?)<\/h1>\n<p>(.*?)<\/p>(.*?)<\/section>/<div class="container py-5"><div class="jumbotron"><h1>\1<\/h1><p>\2<\/p><\/div>\3<\/div>/gs' dist/tuxiee-in-remembrance.html
	perl -i -p0e 's/<p><img src="(.*?)" alt="(.*?)" \/><\/p>/<img class="mx-auto d-block img-fluid" src="\1" alt="\2" \/>/gs' dist/tuxiee-in-remembrance.html
	perl -i -p0e 's/(<hr \/>\n<p>© 2019 browndawg et al<\/p>\n)(<\/div><\/div><\/div><\/div>)/\2\1/gs' dist/tuxiee-in-remembrance.html


dist/style.css: vendor/bootstrap/scss
	sassc -t compressed -I vendor/bootstrap/scss -a src/style.scss dist/style.css

dist/robots.txt:
	cp src/robots.txt dist/robots.txt

dist/img:
	cp -r src/img dist/

vendor/bootstrap/scss:
	git submodule init
	git submodule update

clean:
	rm -rf dist/*
