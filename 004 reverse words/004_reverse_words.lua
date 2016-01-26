local reverse_words = function(str)
    local words = {}
    for word in str:gmatch("%S+") do
        table.insert(words, word)
    end
    
    local reversed = {}
    for i=#words, 1, -1 do
        table.insert(reversed, words[i])
    end
    
    return table.concat(reversed, ' ')
end

for line in io.lines(arg[1]) do
    if line ~= '' then
        print(reverse_words(line))
    end
end