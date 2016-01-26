
local function in_table(table, value)
    for _,this in ipairs(table) do
        if this == value then
            return true
        end
    end
    return false
end

local function print_grid(grid)
    for row=1, #grid do
        print(table.concat(grid[row], ' '))
    end
end

local function search(grid, what, row, col, seen)

    -- Grab the first letter
    local char = what:sub(1, 1)
    
    -- Is it here.  If not, then stop and backtrack
    if grid[row][col] ~= char then
        return false
    end
    
    -- Record that we've visited this row/col 
    -- print(string.format('Found %s at %d/%d', char, row, col))
    table.insert(seen, row .. ':' .. col)
   
    -- Check if this was the last step
    if what:len() == 1 then
        -- print('Done, end of the line.  Path was: ' .. table.concat(seen, '->'))
        return true
    end
    
    -- Places to look next
    local possible_positions = {{row, col+1}, {row, col-1}, {row+1, col}, {row-1, col}}
        
    for _, next_pair in ipairs(possible_positions) do
        next_row, next_col =  unpack(next_pair)
        
        -- Check in range, and that we haven't visited it before
        if next_row >= 1 and next_row <= #grid and
           next_col >= 1 and next_col <= #grid[1] and
           not in_table(seen, next_row .. ':' .. next_col) then
       
            local next_what = what:sub(2)
            -- print(string.format('Starting new search for %s at %d/%d', next_what, next_row, next_col))    
            
            if search(grid, next_what, next_row, next_col, seen) then
                return true
            end
        end
    end
    
    -- We've tried everything, and gotten no where :(
    return false
end

local function start_search(grid, what)
    for row=1, #grid do
        for col=1, #grid[row] do
            if search(grid, what, row, col, {}) then
                -- print('Found ' .. what .. '!')
                return true 
            end
        end
    end
    
    return false
end


local grid = {
    {'A', 'B', 'C', 'E'},
    {'S', 'F', 'C', 'S'},
    {'A', 'D', 'E', 'E'}
}

--for _,what in pairs({'ASADB', 'ABCCED', 'ABCF'}) do   
--    if start_search(grid, what) then
--        print('True')
--    else
--        print('False')
--    end
--end

for line in io.lines(arg[1]) do
    if line ~= '' then
        if start_search(grid, line) then
            print('True')
        else
            print('False')
        end
    end
end
