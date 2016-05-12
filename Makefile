VERSION = 1.0.0
BIN = bin
RELEASE = release
SRC = addons

$(BIN)/tacs_%.pbo: $(SRC)/%
	@mkdir -p $(BIN)
	@echo "  PBO  $@"
	@armake build ${FLAGS} -f $< $@

all: $(patsubst $(SRC)/%, $(BIN)/tacs_%.pbo, $(wildcard $(SRC)/*))

release: all
	@mkdir $(RELEASE) 2> /dev/null || rm -rf $(RELEASE)/*
	@mkdir -p $(RELEASE)/@theseus_services/addons
	@cp $(BIN)/* $(RELEASE)/@theseus_services/addons/
	@cp *.cpp $(RELEASE)/@theseus_services/
	@cp AUTHORS.txt LICENSE logo_tacs_ca.paa logo_tacs_small_ca.paa README.md $(RELEASE)/@theseus_services/
	@echo "  ZIP  $(RELEASE)/TheseusServices_$(VERSION).zip"
	@cd $(RELEASE); zip -r TheseusServices_$(VERSION).zip @theseus_services &> /dev/null; cd ..
