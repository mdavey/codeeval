
local fizzbuzz = function(d1, d2, count)
    
    local fb = function(i)
        if (i % d1 == 0) and (i % d2 == 0) then
            return 'FB'
        elseif (i % d1 == 0) then
            return 'F'
        elseif (i % d2 == 0) then
            return 'B'
        else
            return '' .. i
        end
    end
    
    local answers = {}

    for i=1, count do
        table.insert(answers, fb(i))
    end
    
    return table.concat(answers, ' ')
end


for line in io.lines(arg[1]) do
    print(fizzbuzz(line:match('(%d+) (%d+) (%d+)')))
end