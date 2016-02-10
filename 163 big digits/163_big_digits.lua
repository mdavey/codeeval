
local font = '-**----*--***--***---*---****--**--****--**---**--' ..
             '*--*--**-----*----*-*--*-*----*-------*-*--*-*--*-' ..
             '*--*---*---**---**--****-***--***----*---**---***-' ..
             '*--*---*--*-------*----*----*-*--*--*---*--*----*-' ..
             '-**---***-****-***-----*-***---**---*----**---**--' ..
             '--------------------------------------------------' 

local function print_digit(number, row)    
    local offset = (50 * (row-1)) + 1
    local pos = offset + (number * 5)
    io.stdout:write(font:sub(pos, pos+4))
end

local function big_digits(line)
    local digits = {}
    for digit in line:gmatch('(%d)') do
        table.insert(digits, digit)
    end
    
    for row=1, 6 do
        for _, digit in ipairs(digits) do
            print_digit(digit, row)
        end
        print()
    end
end


local filename = arg[1]

if arg[0]:find('Users\\Matthew') ~= nil then
    filename = arg[0]:match('(.*\\).*') .. 'data.txt'
end

for line in io.lines(filename) do
    if line ~= '' then
        big_digits(line)
    end
end
