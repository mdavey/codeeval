
local function roller_coaster_case(s)
    local new = ''
    local state = false
    
    for i=1, s:len() do
        local c = s:sub(i,i)
        
        if (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') then
            if state then
                new = new .. c:lower()
            else
                new = new .. c:upper()
            end
            state = not state
        else
            new = new .. c
        end
    end
    
    return new
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

codeeval(roller_coaster_case)