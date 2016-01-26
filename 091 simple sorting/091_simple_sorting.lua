
local function split(line)
    local numbers = {}
    
    for num in line:gmatch('[%d-\\.]*') do
        table.insert(numbers, tonumber(num))
    end
    
    return numbers
end

local function format_floats(numbers)
    local formatted = {}
    
    for _, num in ipairs(numbers) do
        table.insert(formatted, string.format('%.03f', num))
    end
    
    return formatted
end

local function simple_sort(line)
    local numbers = split(line)
    table.sort(numbers)
    
    return table.concat(format_floats(numbers), ' ')
end

local function codeeval(f)
    local filename = arg[1]
    
    if arg[0]:find('Users\\Matthew') ~= nil then
        local current_dir = arg[0]:match('(.*\\).*')
        filename = current_dir .. 'data.txt'
    end

    for line in io.lines(filename) do
        if line ~= '' then
            print(f(line))
        end
    end
end


codeeval(simple_sort)