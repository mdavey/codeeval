
local function in_table(t, what)
    for _,v in ipairs(t) do
        if v == what then return true end
    end
    return false
end

local function check_values(t, to)
    for i=1, to do
        if not in_table(t, i) then return false end
    end
    return true
end

local function sodoku(s)
    local size = tonumber(s:sub(1, 1))
    s = s:sub(3)
    
    if size ~= 4 and size ~= 9 then error('Size must be 4 or 9') end
    
    local x = 1
    local y = 1
    local rows = {}
    local cols = {}
    local squares = {}
    
    for num in s:gmatch('(%d)') do
        num = tonumber(num)
        
        -- Rows
        if not rows[y] then rows[y] = {} end
        table.insert(rows[y], num)
        
        -- Cols
        if not cols[x] then cols[x] = {} end
        table.insert(cols[x], num)
        
        -- Squares
        -- TIL about latin squares
        local square_num_x = math.ceil(x/math.sqrt(size))
        local square_num_y = math.ceil(y/math.sqrt(size))
        local square_num = square_num_x .. square_num_y
        
        if not squares[square_num] then squares[square_num] = {} end
        table.insert(squares[square_num], num)
        
        --
        x = x + 1
        
        if x > size then
            x = 1
            y = y + 1
        end
    end
   
   -- Check rows and columns
    for i=1, size do
        if check_values(rows[i], size) == false or check_values(cols[i], size) == false then
            return 'False'
        end
    end
    
    -- Check the each square
    for square_num, square in pairs(squares) do
        if check_values(square, size) == false then
            return 'False'
        end
    end

    return 'True'
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

codeeval(sodoku)