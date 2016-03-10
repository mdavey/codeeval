
local Stack = {}

function Stack.new()
    return setmetatable({items={}}, {__index = Stack, __tostring = Stack.tostring})
end

function Stack:tostring()
    return table.concat(self.items, ' ')
end

function Stack:push(item)
    table.insert(self.items, item)
    return self
end

function Stack:pop()
    local item  = self.items[#self.items]
    self.items[#self.items] = nil
    return item
end
    

local function read_tokens(line)
    local tokens = {}
    for token in line:gmatch('([^%s]+)') do
        table.insert(tokens, token)
    end
    return tokens
end

local function table_reverse(t)
    local nt = {}
    for i=#t, 1, -1 do
        nt[#nt+1] = t[i]
    end
    return nt
end

local function prefix_expressions(line)
    local stack = Stack.new()
    
    for _,token in ipairs(table_reverse(read_tokens(line))) do
        if token == '+' then
            stack:push(stack:pop() + stack:pop())
        elseif token == '*' then
            stack:push(stack:pop() * stack:pop())
        elseif token == '/' then
            stack:push(stack:pop() / stack:pop())
        else
            stack:push(token)
        end
    end
    
    return '' .. stack:pop()
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


codeeval(prefix_expressions)