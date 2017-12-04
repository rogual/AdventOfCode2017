
dirs = [1, -1j, -1, 1j]


def coordg():
    r = 0
    side = 1
    dirno = 0

    yield 0

    while True:
        for j in range(side):
            r = r + dirs[dirno]
            yield r

        dirno = (dirno + 1) % 4

        for j in range(side):
            r = r + dirs[dirno]
            yield r

        dirno = (dirno + 1) % 4

        side += 1

    return r


def coord(n):
    g = coordg()
    for i in range(n):
        r = next(g)
    return r


def answer(n):
    co = coord(n)
    return abs(co.real) + abs(co.imag)


print(answer(277678))
