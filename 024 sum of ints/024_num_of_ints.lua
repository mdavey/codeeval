local current_dir = arg[0]:match('(.*\\).*')
local filename = arg[1]

if arg[0]:find('Users\\Matthew') ~= nil then        
    filename = current_dir .. 'data.txt'
end

local sum = 0

for line in io.lines(filename) do
    if line ~= '' then
        sum = sum + tonumber(line)
    end
end

print(sum)