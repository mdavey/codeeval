
local function multiply_lists(s)
    local left, right = s:match('(.*) | (.*)')
    local left_match = left:gmatch('(%d+)')
    local right_match = right:gmatch('(%d+)')
    
    local products = {}
    
    while true do
        local left_next = left_match()
        local right_next = right_match()
        
        if left_next == nil or right_next == nil then 
            break 
        end
        
        products[#products+1] = tonumber(left_next) * tonumber(right_next);
    end
    
    return table.concat(products, ' ')
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

codeeval(multiply_lists)