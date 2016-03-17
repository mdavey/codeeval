
local function nice_angles(line)
    local decimal, fractional = line:match('^(%d+)(%.%d+)$')
    decimal, fractional = tonumber(decimal), tonumber(fractional)
    local minutes = math.floor(fractional * 0.60 * 100)
    fractional = fractional - ((minutes / 100) / 0.60)
    local seconds = math.floor((fractional * 0.60) * 0.60 * 100 * 100)  -- WAT!?
    return string.format('%0d.%02d\'%02d"', decimal, minutes, seconds)
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


codeeval(nice_angles)