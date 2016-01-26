
-- There is a board (matrix). Every cell of the board contains one integer, 
-- which is 0 initially. 
--
-- The next operations can be applied to the Query Board: 
-- SetRow i x: it means that all values in the cells on row "i" have been 
--             changed to value "x" after this operation. 
-- SetCol j x: it means that all values in the cells on column "j" have been 
--             changed to value "x" after this operation. 
-- QueryRow i: it means that you should output the sum of values on row "i". 
-- QueryCol j: it means that you should output the sum of values on column "j".
--
-- The board's dimensions are 256x256 
-- "i" and "j" are integers from 0 to 255 
-- "x" is an integer from 0 to 31 


local Board = {}
Board.__index = Board

Board.new = function()
    local cells = {}
    
    for i=0, 255 do
        cells[i] = {}
        for j=0, 255 do
            cells[i][j] = 0
        end
    end
    
    return setmetatable({cells=cells}, Board)
end

function Board:setRow(i, value)
    for j=0, 255 do
        self.cells[i][j] = value
    end
end

function Board:setCol(j, value)
    for i=0, 255 do
        self.cells[i][j] = value
    end
end

function Board:queryRow(i)
    local sum = 0
    for j=0, 255 do
        sum = sum + self.cells[i][j]
    end
    return sum
end

function Board:queryCol(j)
    local sum = 0
    for i=0, 255 do
        sum = sum + self.cells[i][j]
    end
    return sum
end


local function parse_cmd(cmd)
    local cmd_args = {}
    for word in cmd:gmatch('([^%s]+)') do
        table.insert(cmd_args, word)
    end
    return cmd_args
end


local function query_board()
    
    local b = Board.new()
    
    -- swtich data file for testing/live
    local filename = arg[1]
    if arg[0]:find('Users\\Matthew') ~= nil then
        filename = arg[0]:match('(.*\\).*') .. 'data.txt'
    end
    
    for line in io.lines(filename) do
        if line ~= '' then
            local cmd_args = parse_cmd(line)
            
            if     cmd_args[1] == 'SetRow'   then b:setRow(tonumber(cmd_args[2]), tonumber(cmd_args[3]))
            elseif cmd_args[1] == 'SetCol'   then b:setCol(tonumber(cmd_args[2]), tonumber(cmd_args[3]))
            elseif cmd_args[1] == 'QueryRow' then print(b:queryRow(tonumber(cmd_args[2])))
            elseif cmd_args[1] == 'QueryCol' then print(b:queryCol(tonumber(cmd_args[2])))
            else error('Unknown command', cmd) end
        end
    end
end



query_board()

-- print('mem', collectgarbage('count'))
