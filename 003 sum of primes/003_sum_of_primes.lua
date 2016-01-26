function primes(sievesize)
    local soe = {}
    local position = 2
    
    return function() 
        
        if position > sievesize then 
            return nil 
        end
        
        -- Silly hack.  2 is prime, but we are 
        -- only checking odd numbers below
        if position == 2 then
            position = 3
            return 2
        end
        
        while true do
            if soe[position] ~= false then              
                local prime = position
              
                for i=position*2, sievesize, position do
                    soe[i] = false
                end        
               
                position = position + 2
               
                return prime
            else
                position = position + 2
            end
        end
    end
end

local counter = 0
local sum = 0

for prime in primes(10000) do
    sum = sum + prime
    counter = counter + 1
    
    if counter == 1000 then
        print(sum)
        break
    end
end