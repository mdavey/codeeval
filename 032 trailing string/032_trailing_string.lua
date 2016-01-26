local function trailing_string(haystack, neddle)    
    return haystack:find(neddle, -1 * neddle:len()) ~= nil
end

-- local current_dir = arg[0]:match('(.*\\).*')
-- local filename = current_dir .. 'data.txt'
local filename = arg[1]

for line in io.lines(filename) do
    if line ~= '' then
        local haystack, neddle = line:match('(.*),(.*)')
        if trailing_string(haystack, neddle) then
            print(1)
        else
            print(0)
        end
    end
end