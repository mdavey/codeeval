
local function roman_numerals(s)
    local map = {
        {'M',  1000},
        {'CM', 900},
        {'D',  500},
        {'CD', 400},
        {'C',  100},
        {'XC', 90},
        {'L',  50},
        {'XL', 40},        
        {'X',  10},
        {'IX', 9},
        {'V',  5},
        {'IV', 4},
        {'I',  1}
    }
    
    local start = tonumber(s)
    local result = ''
    
    while start > 0 do
        for _,v in ipairs(map) do
            if start >= v[2] then
                start = start - v[2]
                result = result .. v[1]
                break
            end
        end
    end
    
    return result
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

codeeval(roman_numerals)