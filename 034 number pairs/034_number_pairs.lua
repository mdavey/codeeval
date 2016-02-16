
local function in_table(t, needle)
    for i,v in ipairs(t) do
        if v == needle then 
            return true
        end
    end
    return false
end

local function number_pairs(line)
    local numbers_string, target_sum = line:match('(.*);(.*)')
    
    target_sum = tonumber(target_sum)
    
    local numbers = {}
    for number in numbers_string:gmatch('(%d+)') do
        table.insert(numbers, number)
    end
    
    local results = {}
    
    for i=1, #numbers-1 do
        for j=i+1, #numbers do
            local sum = tonumber(numbers[i]) + tonumber(numbers[j])
            local sum_string = numbers[i] .. ',' .. numbers[j]
            if sum == target_sum and not in_table(results, sum_string) then
                table.insert(results, sum_string)
            end
        end
    end
    
    if #results == 0 then
        return 'NULL'
    else
        return table.concat(results, ';')
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

codeeval(number_pairs)