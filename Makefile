
OBJS = chemderiv.o Grid.o CrankNicolson.o EmissionOperator.o Parameters.o DepositionOperator.o \
  SSOperator.o ChemOperator.o AdvectionOperator.o SSCChemOperator.o main.o

CC = g++ -std=c++11
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

prog : $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o CTTM

chemderiv.o : chemderiv.hpp chemderiv.cpp Parameters.hpp
	$(CC) $(CFLAGS) chemderiv.cpp

Parameters.o : Parameters.hpp Parameters.cpp
	$(CC) $(CFLAGS) Parameters.cpp

main.o : main.cpp Utils.hpp AdvectionOperator.hpp DepositionOperator.hpp EmissionOperator.hpp SSOperator.hpp SSCChemOperator.hpp Parameters.hpp
	$(CC) $(CFLAGS) main.cpp

AdvectionOperator.o : AdvectionOperator.hpp AdvectionOperator.cpp Parameters.hpp Utils.hpp Grid.hpp CrankNicolson.hpp
	$(CC) $(CFLAGS) AdvectionOperator.cpp

DepositionOperator.o : DepositionOperator.hpp DepositionOperator.cpp Utils.hpp Parameters.hpp Grid.hpp
	$(CC) $(CFLAGS) DepositionOperator.cpp

EmissionOperator.o : EmissionOperator.hpp EmissionOperator.cpp Utils.hpp Parameters.hpp Grid.hpp
	$(CC) $(CFLAGS) EmissionOperator.cpp

SSCChemOperator.o : SSCChemOperator.hpp SSCChemOperator.cpp Utils.hpp Parameters.hpp ChemOperator.hpp
	$(CC) $(CFLAGS) SSCChemOperator.cpp

ChemOperator.o : ChemOperator.hpp ChemOperator.cpp Parameters.hpp SSOperator.hpp chemderiv.hpp
	$(CC) $(CFLAGS) ChemOperator.cpp

SSOperator.o : SSOperator.hpp SSOperator.cpp Parameters.hpp
	$(CC) $(CFLAGS) SSOperator.cpp

CrankNicolson.o : CrankNicolson.hpp CrankNicolson.cpp Parameters.hpp
	$(CC) $(CFLAGS) CrankNicolson.cpp

Grid.o : Grid.hpp Grid.cpp Parameters.hpp
	$(CC) $(CFLAGS) Grid.cpp

clean:
	rm $(OBJS)
