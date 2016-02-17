
local function intable(t, v)
    for _,this in ipairs(t) do
        if this == v then
            return true
        end
    end
    return false
end

local function jolly_jumpers(line)

    -- First number is 'n' everything else is part of our set
    local n = nil
    local numbers = {}
    for number in line:gmatch('([%-]?%d+)') do
        number = tonumber(number)
        if n == nil then
            n = number
        else
            numbers[#numbers+1] = number
        end
        
        -- if #numbers >= n then break end
    end

    local differences = {}
    for i=1, #numbers-1 do
        differences[#differences+1] = math.abs(numbers[i] - numbers[i+1])
    end

    for i=1, n-1 do
        if not intable(differences, i) then
            return 'Not jolly'
        end
    end
    
    return 'Jolly'
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

codeeval(jolly_jumpers)