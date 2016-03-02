
local function get_daily_change(s)
    local t = {}
    for change in s:gmatch('(%-?%d+)') do
        table.insert(t, tonumber(change))
    end
    return t
end

local function table_slice(t, from, to)
    local range = {}
    for i=from, to do
        table.insert(range, t[i])
    end
    return range
end

local function table_sum(t)
    local sum = 0
    for _,v in ipairs(t) do
        sum = sum + v
    end
    return sum
end

local function max_range_sum(line)
    local num_days, rest = line:match('^(%d+);(.*)$')
    local daily_change = get_daily_change(rest)
    
    local best_sum = nil
    
    -- one based tables... yay  <_<
    -- (table_slice uses same rules as string.sub)
    for day=1, #daily_change-num_days+1 do
        local slice = table_slice(daily_change, day, day+num_days-1)
        local sum = table_sum(slice)
        if best_sum == nil or sum > best_sum then
            best_sum = sum
        end
    end
    
    if best_sum == nil or best_sum < 0 then 
        return '0'
    else
        return tostring(best_sum)
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


codeeval(max_range_sum)