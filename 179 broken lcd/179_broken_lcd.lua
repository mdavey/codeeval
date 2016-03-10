
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
    

local function broken_lcd(line)
    local segments, digits = parse_line(line)
    
    -- this took 10mins to sort out.  So many off by one errors
    -- base 1 indexing is really easy, until you need to do
    -- something non trivial.  Then there are +1 and -1 everywhere
    for i=1, #segments-#digits+1 do
        local match = true
        for j=0, #digits-1 do
            -- print('  Comparing i+j', i, j, i+j)
            if not cmp_binary(segments[i+j], digits[j+1]) then
                match = false
                break
            end
        end
        
        if match then
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