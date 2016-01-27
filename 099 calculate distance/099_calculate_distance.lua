
local distance_lpeg = function(s)
    local lpeg = require('lpeg')    

    local integer = lpeg.P('-')^0 * lpeg.R('09')^1 / tonumber
    local pair = '(' * integer * ', ' * integer * ')'
    local points = pair * ' ' * pair

    local ax, ay, bx, by = points:match(s)

    local dx = math.max(ax, bx) - math.min(ax, bx)
    local dy = math.max(ay, by) - math.min(ay, by)
    
    return math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))
end


local distance = function(s)
    local ax, ay, bx, by = s:match('%((-?%d+), (-?%d+)%) %((-?%d+), (-?%d+)%)')
    local dx = math.max(ax, bx) - math.min(ax, bx)
    local dy = math.max(ay, by) - math.min(ay, by)
    
    return math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))
end


local filename = arg[1]
if arg[0]:find('Users\\Matthew') ~= nil then
    filename = arg[0]:match('(.*\\).*') .. 'data.txt'
end


for line in io.lines(filename) do
    if line ~= '' then
        print(distance(line))
    end
end
