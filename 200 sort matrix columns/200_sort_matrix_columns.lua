-- You have a matrix of integers of N*N size. You should sort the columns in 
-- the matrix by first row in ascending order. If the numbers in the first 
-- line are equal - you should sort it by the lowest number of second line, 
-- if numbers in the second line are also equal you should sort it by the 
-- next row etc.

local function string_to_matrix(s)
    local matrix = {}
    local current_row = {}
    for match in s:gmatch('(-?[%d|]+)') do
        if match == '|' then
            table.insert(matrix, current_row)
            current_row = {}
        else
            table.insert(current_row, tonumber(match))
        end
    end
    table.insert(matrix, current_row)
    return matrix
end

local function matrix_to_string(matrix)
    local s = {}
    for row=1, #matrix do
        s[#s+1] = table.concat(matrix[row], ' ')
    end
    return table.concat(s, ' | ' )
end
    
local function transpose_matrix(original_matrix)
    local new_matrix = {}
    
    for row=1, #original_matrix do
        new_matrix[row] = {}
    end
    
    for col=1, #original_matrix do
        for row=1, #original_matrix do
            new_matrix[row][col] = original_matrix[col][row]
        end
    end
    
    return new_matrix
end

local function column_sort_cmp(a, b)
    for i=1, #a do
        if a[i] < b[i] then 
            return true
        elseif a[i] > b[i] then
            return false
        end
    end
    return false
end

local function sort_matrix_columns(s)
    local matrix = string_to_matrix(s)
    local matrix_t = transpose_matrix(matrix)
    table.sort(matrix_t, column_sort_cmp)
    local sorted_matrix = transpose_matrix(matrix_t)
    
    return matrix_to_string(sorted_matrix)
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

codeeval(sort_matrix_columns)