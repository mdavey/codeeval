local function sum_digits(s)
    local sum = 0
    for i=1, s:len() do
        sum = sum + tonumber(s:sub(i, i))
    end
    return sum
end

-- local current_dir = arg[0]:match('(.*\\).*')
-- local filename = current_dir .. 'data.txt'
local filename = arg[1]

for line in io.lines(filename) do
    if line ~= '' then
        print(sum_digits(line))
    end
end