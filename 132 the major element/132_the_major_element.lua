
local function the_major_element(line)
    local size = 0
    local value_to_count_map = {}
    
    for num in line:gmatch('(%d+)') do
        if not value_to_count_map[num] then
            value_to_count_map[num] = 0
        end
        
        value_to_count_map[num] = value_to_count_map[num] + 1
        size = size + 1
    end
    
    for value, count in pairs(value_to_count_map) do
        if count > (size/2) then
            return value
        end
    end
    
    return 'None'
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

codeeval(the_major_element)