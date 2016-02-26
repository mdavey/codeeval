
local function is_palindrom(num)
    local s = tostring(num)
    return s:reverse() == s
end

assert(is_palindrom('1') == true)
assert(is_palindrom('12') == false)
assert(is_palindrom('11') == true)
assert(is_palindrom('121') == true)
assert(is_palindrom('55445') == false)
assert(is_palindrom('54445') == true)


local function range(l, h)
    local t = {}
    for i=l, h do
        table.insert(t, i)
    end
    return t
end

assert(table.concat(range(1,1)) == '1')
assert(table.concat(range(1,2)) == '12')
assert(table.concat(range(3,5)) == '345')


local function filter(t, f)
    local nt = {}
    for _,v in ipairs(t) do
        if f(v) then table.insert(nt, v) end
    end
    return nt
end

assert(table.concat(filter({1,2,3,4,5}, function(x) return x%2==0 end)), '24')


local function is_interesting_range(t)
    return #filter(t, function(n) return is_palindrom(n) end) % 2 == 0
end

assert(is_interesting_range({1}) == false)
assert(is_interesting_range({1,2}) == true)


local function all_subranges(l, h)
    for i=l, h do
        for j=i, h do
            coroutine.yield(range(i,j))
        end
    end
end


local function palindromic_ranges(s)
    local l, h = s:match('(%d+) (%d+)')
    l, h = tonumber(l), tonumber(h)
    
    local count = 0
    
    local co = coroutine.create(all_subranges)
    local running, subrange = coroutine.resume(co, l, h)
    
    while running and subrange ~= nil do
        if is_interesting_range(subrange) then
            count = count + 1
        end
        running, subrange = coroutine.resume(co)
    end
    
    return tostring(count)
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

codeeval(palindromic_ranges)