
local function matrix_rotation(s)
    
    local matrix = {}
    for letter in s:gmatch('%a') do
        matrix[#matrix+1] = letter
    end
    
    local size = math.sqrt(#matrix)
    
    local rotated = {}
    
    for x=1, size do
        for y=1, size do
            local offset = x + ((y-1)*size)
            local newoffset = (size-y+1) + ((x-1)*size)
            rotated[newoffset] = matrix[offset]
        end
    end
    
    return table.concat(rotated, ' ')
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


codeeval(matrix_rotation)