input = io.read('*all')
lines = string.gmatch(input, '%S+')
memory = {}
for line in lines do
  table.insert(memory, tonumber(line))
end

pc = 1
jumps = 0
while true do
  jump = memory[pc]

  if jump >= 3 then
    memory[pc] = memory[pc] - 1
  else
    memory[pc] = memory[pc] + 1
  end

  pc = pc + jump
  jumps = jumps + 1

  if memory[pc] == nil then
    break
  end

end

print(jumps)