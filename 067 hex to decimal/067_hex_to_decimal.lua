
local function hex_to_decimal(line)
    local map = {}
    map[string.byte('0')] = 0
    map[string.byte('1')] = 1
    map[string.byte('2')] = 2
    map[string.byte('3')] = 3
    map[string.byte('4')] = 4
    map[string.byte('5')] = 5
    map[string.byte('6')] = 6
    map[string.byte('7')] = 7
    map[string.byte('8')] = 8
    map[string.byte('9')] = 9
    map[string.byte('a')] = 10
    map[string.byte('b')] = 11
    map[string.byte('c')] = 12
    map[string.byte('d')] = 13
    map[string.byte('e')] = 14
    map[string.byte('f')] = 15
    
    local place = 0
    local num = 0
    
    for char in line:reverse():gmatch('.') do
        num = num + (map[char:byte()] * math.pow(16, place))
        place = place + 1
    end
    
    return tostring(num)
end


local function codeeval(f)
    -- normal
    if arg[0]:find('Users\\Matthew') == nil then        
        for line in io.lines(arg[1]) do
            if line ~= '' then
                print(f(line))
            end
        end
        
    -- development
    else
        local dev_enviroment = require("../codeeval")
        dev_enviroment.run_local(f)
    end
end


codeeval(hex_to_decimal)