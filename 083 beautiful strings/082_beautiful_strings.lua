
local function character_frequency(s)
    local a_byte = string.byte('a')
    local z_byte = string.byte('z')
    
    local freq = {}
    
    for c in s:lower():gmatch('.') do
        if c:byte() >= a_byte and c:byte() <= z_byte then
            if not freq[c] then
                freq[c] = 1 
            else 
                freq[c] = freq[c] + 1 
            end
        end
    end
    
    return freq
end


local function sort_freq(freq)
    local flat = {}
    
    for char, char_freq in pairs(freq) do
        table.insert(flat, char_freq)
    end
    
    table.sort(flat, function(a, b)
        return a > b
    end)
    
    return flat
end


local function score(line)
    
    local freq = character_frequency(line)
    local sorted_freq = sort_freq(freq)
    
    local total = 0
    local beauty_multipler = 26
    
    for _, char_freq in ipairs(sorted_freq) do
        total = total + (char_freq * beauty_multipler)
        beauty_multipler = beauty_multipler - 1
    end
    
    return tostring(total)
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


codeeval(score)