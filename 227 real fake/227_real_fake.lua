
-- To determine which credit cards are real, double every third number 
-- starting from the first one, add them together, and then add them to those
-- figures that were not doubled. If the total sum of all numbers is 
-- divisible by 10 without remainder, then this credit card is real. 
--
-- That is wrong, fuck you question.  It's the first number, and then every 2nd
-- after that.  But you have to look at the image (and ignore the text)
local function real_fake(line)

    local a = 0
    local b = 0
    
    local count = 0
    
    for i=1, line:len() do
        local char = line:sub(i, i)
        if char ~= ' ' then
            local n = tonumber(char)
            if count % 2 == 0 then
                a = a + (n * 2)
                -- print('a', char)
            else
                b = b + n
                -- print('b', char)
            end
            
            count = count + 1
        end
    end
    
    if (a+b) % 10 == 0 then
        return "Real"
    else
        return "Fake"
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


codeeval(real_fake)