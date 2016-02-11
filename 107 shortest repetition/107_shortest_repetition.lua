
local function iter_to_table(iter)
    local t = {}
    for v in iter do
        t[#t+1] = v
    end
    return t
end

local function shortest_rep(s)
    
    for current_rep = 1, s:len() do
        
        -- Oh god, what have I done
        local rep_string = s:sub(1, current_rep)        
        local matches = iter_to_table(s:gmatch(rep_string))
        
        if s:len() == #matches * rep_string:len() then
            return tostring(current_rep)
        end
    end
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

codeeval(shortest_rep)