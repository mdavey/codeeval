

local function string_mask(line)
    local word, mask = line:match('(.+) (.+)')
    local new_word = ''

    for i=1, word:len() do        
        if mask:sub(i,i) == '1' then
            new_word = new_word .. word:sub(i,i):upper()
        else
            new_word = new_word .. word:sub(i,i)
        end
    end
    
    return new_word
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


codeeval(string_mask)