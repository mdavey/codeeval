local function unique_elements(line)
    
    local set = {}
    
    for num in string.gmatch(line, '%d+') do       
        set[tonumber(num)] = true        
    end
    
    local elements = {}
    
    for k,v in pairs(set) do
        table.insert(elements, k)
    end
    
    table.sort(elements)
    
    return table.concat(elements, ',')
end


-- local current_dir = arg[0]:match('(.*\\).*')
-- local filename = current_dir .. 'data.txt'
local filename = arg[1]

for line in io.lines(filename) do
    if line ~= '' then
        print(unique_elements(line))
    end
end