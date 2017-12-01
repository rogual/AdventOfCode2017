all: aoc1a aoc1b

aoc1a: aoc1a.c
	cc -std=c99 -o $@ $<

aoc1b: aoc1b.c
	cc -std=c99 -o $@ $<
