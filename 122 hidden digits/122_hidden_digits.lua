
local function hidden_digits(s)
    s = s:gsub('[a-j]', {a=0, b=1, c=2, d=3, e=4, f=5, g=6, h=7, i=8, j=9})
    s = s:gsub('[^0-9]', '')
    
    if s == '' then
        return 'NONE'
    else
        return s
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


codeeval(hidden_digits)