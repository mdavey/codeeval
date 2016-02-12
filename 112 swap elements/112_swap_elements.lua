
local function swap_elements(line)
    local array_string, operations_string = line:match('(.*) : (.*)')
    
    local array = {}
    for number in array_string:gmatch('(%d+)') do
        table.insert(array, number)
    end
    
    for i, j in operations_string:gmatch('(%d+)%-(%d+)') do
        array[i+1], array[j+1] = array[j+1], array[i+1]
    end
    
    return table.concat(array, ' ')
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

codeeval(swap_elements)