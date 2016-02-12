
local function mixed_content(line)
    local numbers = {}
    local words = {}
    
    for item in line:gmatch('([^,]+)') do
        if item:match('^%d+$') then
            table.insert(numbers, item)
        else
            table.insert(words, item)
        end
    end
    
    local words_string = table.concat(words, ',')
    local numbers_string = table.concat(numbers, ',')
    
    if words_string:len() > 0 and numbers_string:len() > 0 then
        return words_string .. '|' .. numbers_string
    elseif words_string:len() > 0 then
        return words_string
    else
        return numbers_string
    end
    
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

codeeval(mixed_content)