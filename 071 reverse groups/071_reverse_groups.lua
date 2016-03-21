local function table_reverse(t)
    local nt = {}
    for i=#t, 1, -1 do
        nt[#nt+1] = t[i]
    end
    return nt
end

assert(table.concat(table_reverse({1,2,3})) == '321')
assert(table.concat(table_reverse({})) == '')
assert(table.concat(table_reverse({3,3,3})) == '333')
assert(table.concat(table_reverse({'a',2,'b'})) == 'b2a')


local function parse_inputs(line)
    local left, right = line:match('^(.*);(.*)$')
    
    local slice_size = tonumber(right)
    local numbers = {}
    
    for number in left:gmatch('(%-?%d+)') do
        table.insert(numbers, tonumber(number))
    end
    
    return numbers, slice_size
end

-- asserts with multiple return values are tricky
-- assert(parse_inputs('1,2,3;2') == {1,2,3}, 2); ha!


local function table_slice(t, from, to)
    local nt = {}
    for i=from, to do
        nt[#nt+1] = t[i]
    end
    return nt
end

assert(table.concat(table_slice({1,2,3}, 1, 1)) == '1')
assert(table.concat(table_slice({1,2,3}, 1, 2)) == '12')
assert(table.concat(table_slice({1,2,3}, 2, 3)) == '23')
assert(table.concat(table_slice({1,2,3}, 3, 4)) == '3')


local function reverse_groups(line)
    local numbers, size = parse_inputs(line)
    local reversed = {}
    
    for i=1, #numbers, size do
        local slice = table_slice(numbers, i, i+size-1) -- hmmmmmmm
        
        -- check for end of array with a partial slice
        if #slice == size then
            slice = table_reverse(slice)
        end
        
        for j=1, #slice do
            reversed[#reversed+1] = slice[j]
        end
    end
    
    return table.concat(reversed, ',')
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


codeeval(reverse_groups)