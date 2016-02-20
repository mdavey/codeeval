
local function is_prime(n)
    if n ~= 2 and n%2 == 0 then return false end
    for i=3, n/2, 2 do
        if n % i == 0 then return false end
    end
    return true
end

local function primes_between(start_value, end_value)
    local i = start_value-1
    return function()
        while true do
            i = i + 1
            if i > end_value then return nil end
            if is_prime(i) then return i end
        end
    end
end

local function counting_primes(line)
    local start_value, end_value = line:match('(%d+),(%d+)')
    start_value, end_value = tonumber(start_value), tonumber(end_value)
    
    local count = 0
    for prime in primes_between(start_value, end_value) do
        count = count + 1
    end

    return tostring(count)
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

codeeval(counting_primes)