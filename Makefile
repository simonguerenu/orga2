CC = gcc
CFLAGS = -Wall -Wextra -pedantic -MMD -MP -std=c99
TARGET = binario

all: $(TARGET)


SRCS = hola.c main.c
OBJS = $(SRCS:.c=.o)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

-include $(OBJS:.o=.d)

clean:
	rm *.o $(TARGET) *.d

.PHONY: all clean