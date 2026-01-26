
build-%:
	nim c $*.nim

build-run-%:
	nim c -r $*.nim $(ARGS)

run-%:
	./$* $(ARGS)