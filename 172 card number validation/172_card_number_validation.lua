

local function luhn_double(v)
    local x = v*2
    
    if x >= 10 then
        return x-9
    end
    
    return x
end


local function card_number_validation(s)
    s = s:gsub('[^%d]', '')
    
    local sum = 0
    local odd = false
    
    for i=s:len(), 1, -1 do
        local v = tonumber(s:sub(i, i))
        
        if odd then
            sum = sum + luhn_double(v)
        else
            sum = sum + v
        end
        
        odd = not odd
    end
    
    if (sum % 10) == 0 then return '1' else return '0' end
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


codeeval(card_number_validation)