CC = mxmlc
MFLAGS = -library-path+=libs -static-link-runtime-shared-libraries=true
SWF = bin/Kazuate.swf
SRC = src/Main.mxml
LNK = bin/report.xml

all: $(SWF)

.PHONY: clean
clean:
	$(RM) $(SWF)

run:
	open -a "Firefox" $(SWF)

$(SWF):
	$(CC) $(MFLAGS) -o $(SWF) $(SRC) -optimize=true -link-report=$(LNK)

debug: $(SWF)
	@ echo "Compiling $<, DEBUG MODE"
	$(CC) $(MFLAGS) -o $(SWF) $(SRC) -debug

