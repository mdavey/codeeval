
local function read_tokens(line)
    local arabic_value_map = {
        I=1,
        V=5, 
        X=10, 
        L=50, 
        C=100, 
        D=500, 
        M=1000 }
        
    local tokens = {}
    for roman, arabic in line:gmatch('(%d)([IVXLCDM])') do
        table.insert(tokens, {
                roman=tonumber(roman),
                arabic=arabic_value_map[arabic],
                value=tonumber(roman) * arabic_value_map[arabic]})
    end
    return tokens
end

local function roman_and_arabic(line)
    local total = 0
    
    local tokens = read_tokens(line)
    for i,token in ipairs(tokens) do
        -- wherever there are consecutive symbols ARA`R` with R` having a 
        -- strictly bigger base value than R, the value of pair AR must be 
        -- substracted from the total, instead of being added.
        if i < #tokens and tokens[i+1].arabic > token.arabic then
            total = total - token.value
        else
            total = total + token.value
        end
    end
    
    return '' .. total
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


codeeval(roman_and_arabic)