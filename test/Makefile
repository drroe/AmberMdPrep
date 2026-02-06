test: test.all

test.simple:
	@-cd simple && ./RunTest.sh $(OPT)

test.modifiedres:
	@-cd modified.residues && ./RunTest.sh $(OPT)

# Every test target should go here
COMPLETETESTS= \
  test.simple \
  test.modifiedres

test.all:
	$(MAKE) test.complete

test.complete: MasterTest.sh $(COMPLETETESTS)

clean:
	@echo "Cleaning all test directories:"
	$(MAKE) test.complete OPT=clean
