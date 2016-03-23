

local function minimum_coins(line)
    local target = tonumber(line:match('(%d+)'))
    local coins = 0
    
    local function make_change(value)
        while target >= value do
            coins = coins + 1
            target = target - value
        end
    end
    
    make_change(5)
    make_change(3)
    make_change(1)
    
    return '' .. coins
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


codeeval(minimum_coins)