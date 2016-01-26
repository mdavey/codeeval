local function to_number_set(s)
    local set = {}
    
    for num in s:gmatch('%d+') do       
        set[tonumber(num)] = true        
    end
        
    return set
end

-- variable naming is top notch here
local function set_intersection(line)
    
    local left_string, right_string = line:match('(.*);(.*)')
    local left_set, right_set = to_number_set(left_string), to_number_set(right_string)
    
    local intersection_set = {}
    
    for left_value,_ in pairs(left_set) do
        if right_set[left_value] ~= nil then
            intersection_set[left_value] = true
        end
    end
    
    
    local intersection = {}
    
    for value,_ in pairs(intersection_set) do
        table.insert(intersection, value)
    end
    
    table.sort(intersection)
    
    return table.concat(intersection, ',')
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


codeeval(set_intersection)


-- for line in file($_SERVER['argv'][1]) {
--   list($r, $l) = explode(';', line)
--   $r = explode(',', $r)
--   $l = explode(',', $l)
--   echo implode(',', array_intersect($r, $l))
-- }