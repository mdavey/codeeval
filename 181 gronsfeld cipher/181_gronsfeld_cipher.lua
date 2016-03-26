
local function str_to_table(s)
    local t = {}
    for i=1, s:len() do
        t[i] = s:sub(i,i)
    end
    return t
end

local vocabulary_text = " !\"#$%&'()*+,-./0123456789:<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
local vocabulary = str_to_table(vocabulary_text)

local function decode_char(char, offset)
    for i,v in ipairs(vocabulary) do
        if v == char then
            if i-offset < 1 then
                return vocabulary[i-offset + #vocabulary]
            else
                return vocabulary[i-offset]
            end
        end
    end
    error('char', char, 'not in vocabulary')
end

assert(decode_char('H', 3) == 'E')

local function gronsfeld_cipher(line)
    local key, ciphertext = line:match('^(%d+);(.+)$')
    key, ciphertext = str_to_table(key), str_to_table(ciphertext)
    
    local text = ''
    local key_pos = 1
    for _,v in ipairs(ciphertext) do
        
        text = text .. decode_char(v, key[key_pos])
        
        key_pos = key_pos + 1
        if key_pos > #key then
            key_pos = 1
        end
    end
    
    return text
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


codeeval(gronsfeld_cipher)