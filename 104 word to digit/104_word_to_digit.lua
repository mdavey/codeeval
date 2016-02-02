
-- I wonder if I could have used a forward reference in a regex?
local function split(s, split_on)
    local words = {}
    local current_word = ''
    
    if #split_on ~= 1 then error('split_on must be a single character') end
    
    for i=1, #s do
        if s:sub(i,i) == split_on then
            table.insert(words, current_word)
            current_word = ''
        else
            current_word = current_word .. s:sub(i, i)
        end
    end
    
    if current_word ~= '' then
        table.insert(words, current_word)
    end
    
    return words
end

local function word_to_digit(s)
    local map = {
        zero=0,
        one=1,
        two=2,
        three=3,
        four=4,
        five=5,
        six=6,
        seven=7,
        eight=8,
        nine=9
    }
    
    local digits = {}
    
    for _, word in ipairs(split(s, ';')) do
        table.insert(digits, map[word])
    end
    
    return table.concat(digits)
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

codeeval(word_to_digit)