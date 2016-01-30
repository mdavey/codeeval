

-- I promise this was from memory 
-- (from the last 10 times I've implemented a sieve for a prime problem)
local function prime_numbers(s)
    local limit = tonumber(s)    
    
    local sieve = {}
    local primes = {}
    
    for num = 2, limit-1 do
        if not sieve[num] then
            table.insert(primes, num)
            
            for i=num, limit, num do
                sieve[i] = true
            end
        end
    end
    
    return table.concat(primes, ',')
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


codeeval(prime_numbers)