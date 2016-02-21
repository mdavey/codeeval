
local function lettercase_percentage_ratio(line)
    local l = 0
    local u = 0
    
    for c in line:gmatch('(%a)') do
        if c:lower() == c then
            l = l + 1
        else
            u = u + 1
        end
    end
    
    return string.format('lowercase: %0.2f uppercase: %0.2f', l/(l+u)*100, u/(l+u)*100)
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

codeeval(lettercase_percentage_ratio)