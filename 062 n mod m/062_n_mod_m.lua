
local function n_mod_m(line)
    local n,m = line:match('(.*),(.*)')
    
    return tostring(n - (math.floor(n/m) * m))
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


codeeval(n_mod_m)