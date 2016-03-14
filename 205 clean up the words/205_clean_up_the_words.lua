
for line in io.lines(arg[1]) do
    local words = {}
    for match in line:gmatch('([a-zA-Z]+)') do
        words[#words+1] = match:lower()
    end
    print(table.concat(words, ' '))
end