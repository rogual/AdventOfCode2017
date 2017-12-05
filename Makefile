all: aoc1a aoc1b aoc2a aoc2b


# Day 1

aoc1a: aoc1a.c
	cc -std=c99 -o $@ $<

aoc1b: aoc1b.c
	cc -std=c99 -o $@ $<

run-aoc1a: aoc1a
	./aoc1a

run-aoc1b: aoc1b
	./aoc1b


# Day 2
# I'm lazy, so these give you your output in hex.
# Example output:
#   00000000 00f4 0000 0000 0000
#   000000008
# Answer = 244

aoc2a: aoc2a.s aoc2.in
	as -o aoc2a.o aoc2a.s && ld -s -o aoc2a aoc2a.o

aoc2b: aoc2b.s aoc2.in
	as -o aoc2b.o aoc2b.s && ld -s -o aoc2b aoc2b.o

run-aoc2a: aoc2a
	./aoc2a | hexdump

run-aoc2b: aoc2b
	./aoc2b | hexdump


# Day 3

run-aoc3a:
	python3 aoc3a.py

run-aoc3b:
	python3 aoc3b.py


# Day 4

run-aoc4a:
	bash aoc4a.bash

run-aoc4b:
	bash aoc4b.bash


# Day 5

run-aoc5a:
	cat aoc5.in | lua aoc5a.lua

run-aoc5b:
	cat aoc5.in | lua aoc5b.lua
