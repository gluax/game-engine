all: clean main

main:
	sbcl \
		--eval '(require :quicklisp)' \
		--eval '(require :asdf)' \
		--eval '(push "./" asdf:*central-registry*)' \
		--eval '(asdf:make :salvage)' \
		--eval '(quit)'

clean:
	-rm -f main
