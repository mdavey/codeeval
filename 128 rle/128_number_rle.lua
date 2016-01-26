
local rle_encode = function(line)    
    local last_value = nil
    local last_count = nil    
    local rle = {}
    
    for part in line:gmatch('%d+') do
        
        if part ~= last_value then
            -- guard for first value
            if last_value ~= nil then
                table.insert(rle, last_count)
                table.insert(rle, last_value)
            end
            
            last_value = part
            last_count = 1
        else
            last_count = last_count + 1
        end        
    end
    
    table.insert(rle, last_count)
    table.insert(rle, last_value)
    
    return table.concat(rle, ' ')
end

for line in io.lines(arg[1]) do
    if line ~= '' then
        print(rle_encode(line))
    end
end