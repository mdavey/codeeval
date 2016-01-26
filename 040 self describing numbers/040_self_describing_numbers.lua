
local function self_describing_numbers(line)
    local count = {
        [0]= 0,
        [1]= 0,
        [2]= 0,
        [3]= 0,
        [4]= 0,
        [5]= 0,
        [6]= 0,
        [7]= 0,
        [8]= 0,
        [9]= 0,
    }
    
    -- A number is a self-describing number when (assuming digit positions are
    -- labeled 0 to N-1), the digit in each position is equal to the number of
    -- times that that digit appears in the number.
    --
    -- 2020 is a self-describing number
    --   Position '0' has value 2 and there is two 0 in the number.
    --   Position '1' has value 0 because there are not 1's in the number.
    --   Position '2' has value 2 and there is two 2.
    --   And the position '3' has value 0 and there are zero 3's.
    for i=1, line:len() do
        local n = tonumber(line:sub(i, i))
        count[i-1] = count[i-1] + n
        count[n] = count[n] -1
    end
    
    for _,v in pairs(count) do
        if v ~= 0 then
            return "0" 
        end
    end
    
    return "1"
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


codeeval(self_describing_numbers)