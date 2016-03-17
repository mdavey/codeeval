
local function read_matrix(line)
    local matrix = {}
    local row = {}
    for char in line:gmatch('([^ ])') do
        if char == '|' then
            table.insert(matrix, row)
            row = {}
        else
            table.insert(row, char)
        end
    end
    table.insert(matrix, row)
    return matrix
end


local function check_shape(matrix, px, py, sw, sh)
    local chars = {}
    
    for x = px, px + sw - 1 do
        for y = py, py + sh - 1 do
            table.insert(chars, matrix[x][y])
        end
    end
    
    table.sort(chars)
    return table.concat(chars) == 'cdeo'
end

local function iterate_shapes(matrix, sw, sh)
    local count = 0
    for x=1, #matrix - sw + 1 do
        for y=1, #matrix[x] - sh + 1 do
            if check_shape(matrix, x, y, sw, sh) then
                count = count + 1
            end
        end
    end
    return count
end


local function code_combinations(line)
    local matrix = read_matrix(line)
    
    -- I didn't read the description.
    -- Well, I have a general solution for (1,4) (4,1) and (2,2)
    -- local count = iterate_shapes(matrix, 4, 1) +
    --               iterate_shapes(matrix, 1, 4) +
    --               iterate_shapes(matrix, 2, 2)
    
    return '' .. iterate_shapes(matrix, 2, 2)
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


codeeval(code_combinations)