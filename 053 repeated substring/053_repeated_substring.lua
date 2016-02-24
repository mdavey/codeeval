
local function all_substrings(s)
    local substrings = {}
    for length=1, s:len() - 1 do -- -1 so we don't include the actual string
        for i=1, s:len() - length + 1 do
            local substring = s:sub(i, i + length - 1)
            if not substring:match('^(%s+)$') then -- skip substrings that are all spaces
                table.insert(substrings, substring)
            end
        end
    end
    return substrings
end

local function number_matches(s, substring)
    local count = 0
    for _ in s:gmatch(substring) do
        count = count + 1
    end
    return count
end

local function all_repeated_substrings(s)
    local substrings = {}
    
    for _,substring in ipairs(all_substrings(s)) do
        if number_matches(s, substring) > 1 then
            table.insert(substrings, substring)
        end
    end
    
    return substrings
end
    

local function repeated_substrings(s)
    
    local longest_repeated_substring = nil
    local longest_repeated_substring_length = -1
    
    for _,substring in ipairs(all_repeated_substrings(s)) do
        if substring:len() > longest_repeated_substring_length then
            longest_repeated_substring = substring
            longest_repeated_substring_length = substring:len()
        end
    end
    
    if longest_repeated_substring_length >= 1 then
        return longest_repeated_substring
    end
    
    return 'NONE'
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

codeeval(repeated_substrings)