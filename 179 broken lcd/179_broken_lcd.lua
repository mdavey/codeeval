-- One day I'll start my own stdlibrary (or just find one I like)

-- slice a table, same convention as string.sub
-- table_slice({1,2,3}, 1, 1) => {1}
-- table_slice({1,2,3}, 1, 3) => {1, 2, 3}
local function table_slice(t, from, to)
    local slice = {}
    for i=from, to do
        table.insert(slice, t[i])
    end
    return slice
end

assert(table.concat(table_slice({1, 2, 3}, 1, 1)) == '1')
assert(table.concat(table_slice({1, 2, 3}, 1, 3)) == '123')
assert(table.concat(table_slice({1, 2, 3}, 3, 3)) == '3')


-- returns all slices of a table of a size
-- table_slices({1,2,3}, 1) => {{1}, {2}, {3}}
-- table_slices({1,2,3}, 2) => {{1, 2}, {2, 3}}
-- table_slices({1,2,3}, 3) => {{1,2,3}}
local function table_slices(t, size)
    local slices = {}
    for i=1, #t - size + 1 do
        table.insert(slices, table_slice(t, i, i + size - 1))
    end
    return slices
end

assert(table.concat(table_slices({1,2,3}, 2)[1]) == '12')
assert(table.concat(table_slices({1,2,3}, 2)[2]) == '23')
assert(table_slices({1,2,3}, 2)[3] == nil)




-- Not using bitwise operations because I'd spend as long
-- converting the strings, than just doing string comparisons

local parse_digit_map = {
    ['0']= '1111110',
    ['1']= '0110000',
    ['2']= '1101101',
    ['3']= '1111001',
    ['4']= '0110011',
    ['5']= '1011011',
    ['6']= '1011111',
    ['7']= '1110000',
    ['8']= '1111111',
    ['9']= '1111011'
}

local function parse_digit(digit)
    if digit:len() == 1 then
        return parse_digit_map[digit] .. '0'
    else
        return parse_digit_map[digit:sub(1, 1)] .. '1'
    end
end

local function parse_line(line)
    local left, right = line:match('^(.*);(.*)$')
    
    local segments = {}
    for segment in left:gmatch('([01]+)') do
        table.insert(segments, segment)
    end
    
    local digits = {}
    for digit in right:gmatch('(%d%.?)') do
        table.insert(digits, parse_digit(digit))
    end
    
    return segments, digits
end


-- base & x == x
local function cmp_binary(base, x)
    for i=1, 8 do
        if base:sub(i,i) ~= '1' and x:sub(i,i) == '1'  then
            -- print('    CMP', base, x, 'false')
            return false
        end
    end
    -- print('    CMP', base, x, 'true')
    return true
end


local function check_segment(segment, digits)
    assert(#segment == #digits)
    for i=1, #segment do            
        if not cmp_binary(segment[i], digits[i]) then
            return false
        end
    end    
    return true
end
    

local function broken_lcd(line)
    local segments, digits = parse_line(line)
    
    for _,segment in ipairs(table_slices(segments, #digits)) do
        if check_segment(segment, digits) then
            return '1'
        end
    end
    
    return '0'
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


codeeval(broken_lcd)