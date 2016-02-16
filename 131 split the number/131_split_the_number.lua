
local function split_the_number(line)
    local number, left_string, operation, right_string = line:match('(%d+) ([a-z]+)([%-%+])([a-z]+)')
    
    local left_number = tonumber(number:sub(1, left_string:len()))
    local right_number = tonumber(number:sub(left_string:len()+1))
    
    if operation == '-' then
        return tostring(left_number - right_number)
    else
        return tostring(left_number + right_number)
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

codeeval(split_the_number)