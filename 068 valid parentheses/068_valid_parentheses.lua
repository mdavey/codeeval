
local function push(t,v)
    t[#t+1] = v
end

local function pop(t, v) -- code golf
    v, t[#t] = t[#t], nil
    return v
end

local close_to_open_paren = {
    [')'] = '(',
    [']'] = '[',
    ['}'] = '{',
}

local function valid_parentheses(line)
    local stack = {}
    
    for char in line:gmatch('(.)') do
        if char == '(' or char == '[' or char == '{' then
            push(stack, char)
        elseif close_to_open_paren[char] ~= pop(stack) then
            return 'False'
        end
    end
    
    if #stack ~= 0 then
        return 'False'
    end
    
    return 'True'
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


codeeval(valid_parentheses)