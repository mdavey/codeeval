
local function pangrams(s)
    -- table that contains map of  char -> found_in_string
    local chars = {}
    
    -- init table for a-z and set all to false
    for i=string.byte('a'), string.byte('z') do
        chars[string.char(i)] = false
    end
    
    -- for each alpha character  update the map
    for c in s:gmatch('%a') do
        chars[c:lower()] = true
    end
    
    -- need sort the missing characters, so take the keys 
    -- that are still unset and add them to another table
    local sorted_chars = {}
    
    for c,v in pairs(chars) do
        if v == false then
            table.insert(sorted_chars, c)
        end
    end
    
    if #sorted_chars == 0 then
        return 'NULL'
    end
    
    table.sort(sorted_chars)
    
    return table.concat(sorted_chars, '')
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

codeeval(pangrams)