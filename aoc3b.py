dirs4 = [1, -1j, -1, 1j]

dirs8 = [
    1, -1j, -1, 1j,
    1+1j, 1-1j, -1+1j, -1-1j
]


def coordg():
    r = 0
    side = 1
    dirno = 0

    yield 0

    while True:
        for j in range(side):
            r = r + dirs4[dirno]
            yield r

        dirno = (dirno + 1) % 4

        for j in range(side):
            r = r + dirs4[dirno]
            yield r

        dirno = (dirno + 1) % 4

        side += 1

    return r


def coord(n):
    g = coordg()
    for i in range(n):
        r = next(g)
    return r


def answer(target):
    memory = {}
    memory[0] = 1
    i = 2

    while True:
        co = coord(i)

        v = 0
        for dir in dirs8:
            v += memory.get(co + dir, 0)

        memory[co] = v
        if v > target:
            return v

        i += 1


print(answer(277678))
