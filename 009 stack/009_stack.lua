
local Stack = {}
Stack.__index = Stack

Stack.new = function()
    return setmetatable({}, Stack)
end

Stack.push = function(self, item)
    table.insert(self, item)
end

Stack.pop = function(self)
    if #self == 0 then 
        return nil 
    end
    
    local value = self[#self]
    table.remove(self, #self)
    return value
end

Stack.__tostring = function(self)
    return 'Stack(' .. #self .. '): ' .. table.concat(self, ' ')
end


function make_number_stack(line) 
    local stack = Stack.new()
    
    for num in line:gmatch('-?%d+') do
        stack:push(tonumber(num))
    end  
    
    return stack
end


-- Still can't name functions...
function every_second_value_from_end_of_stack(stack)
    local values = {}
    
    -- Are we allowed to get the size of a stack?
    -- Or should just check the value of the 2nd pop?
    while #stack > 0 do
        table.insert(values, stack:pop())
        stack:pop()
    end
    
    return values;
end


for line in io.lines(arg[1]) do
    if line ~= '' then
        local stack = make_number_stack(line)
        local values = every_second_value_from_end_of_stack(stack)
        
        print(table.concat(values, ' '))
    end
end