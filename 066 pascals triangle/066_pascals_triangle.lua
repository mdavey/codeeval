
local function pascals_triangle_row(row)
    local values = {1}
    
    for i=1, row-1 do
        table.insert(values, values[i] * ((row-i)/i))
    end
    
    return table.concat(values, ' ')
end

local function pascals_triangle(line)
    local total_rows = tonumber(line:match('(%d+)'))
    local rows = {}
    
    for i=1, total_rows do
        table.insert(rows, pascals_triangle_row(i))
    end
    
    return table.concat(rows, ' ')
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

codeeval(pascals_triangle)