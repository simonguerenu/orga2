CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = hola

all: hola

hola: hola.o
		$(CC) $(CFLAGS) -c hola.o -o hola

hola.o: hola.c
		$(CC) $(CFLAGS) -c hola.c -o hola.o

clean:
		rm *.o $(TARGET)

.PHONY: all clean		