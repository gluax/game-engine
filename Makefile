all: clean deps lib

lib:
	sbcl \
		--eval '(require :quicklisp)' \
		--eval '(require :asdf)' \
		--eval '(push "./" asdf:*central-registry*)' \
		--eval '(asdf:make :game-engine)' \
		--eval '(quit)'

deps:
	sbcl \
		--eval '(quit)'

test:
	sbcl \
		--eval '(require :quicklisp)' \
		--eval '(ql:quickload :prove)' \
		--eval '(require :asdf)' \
		--eval '(push "./" asdf:*central-registry*)' \
		--eval '(asdf:test-system :game-engine-test)' \
		--eval '(quit)'

clean:
	-rm -f main
