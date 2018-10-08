.DEFAULT_GOAL := compile

cc = gcc;
CFLAGS = -w -pedant

compile: main.o inputReader.o quadSolver.o inputValidation.o
	$(cc) $(CFLAGS) quadSolver -lm main.o inputReader.o quadSolver.o inputValidation.o -o quadSolver

main.o: main.c inputReader.h quadSolver.h inputValidation.h
	$(cc) $(CFLAGS) -c main.c
inputReader.o: inputReader.c 
	$(cc) $(CFLAGS) -c inputReader.c
quadSolver.o: quadSolver.c
	$(cc) $(CFLAGS) -lm -c quadSolver.c
inputValidation.o: inputValidation.c
	$(cc) $(CFLAGS) -c inputValidation.c

inputReaderTest.o: inputReader.c tests/inputReader.c
	$(cc) $(CFLAGS) -lcunit -c inputReader.c tests/inputReader.c

mainTest.o: main.c tests/main.c
	$(cc) $(CFLAGS)  -lcunit -c main.c tests/main.c

inputValidationTest.o: inputValidation.c tests/inputValidation.c
	$(cc) $(CFLAGS)  -lcunit -c inputValidation.c tests/inputValidation.c

quadSolverTest.o: quadSolver.c tests/quadSolver.c
	$(cc) $(CFLAGS)  -lcunit -lm -c quadSolver.c tests/quadSolver.c

inputReaderTest: inputReader.o inputReaderTest.o
	$(cc) $(CFLAGS) -lcunit -c inputReader.o inputReaderTest.o

mainTest: main.o inputReader.o inputValidation.o quadSolver.o mainTest.o
	$(cc) $(CFLAGS) -lcunit -lm -c main.o inputReader.o inputValidation.o quadSolver.o mainTest.o

inputValidationTest: inputValidation.o inputValidationTest.o
	$(cc) $(CFLAGS) -lcunit -c inputValidation.o inputValidationTest.o

quadSolverTest: quadSolver.o quadSolverTest.o
	$(cc) $(CFLAGS) -lcunit -lm -c quadSolver.o quadSolverTest.o

clean:
	rm *.o quadSolver mainTest inputReaderTest 