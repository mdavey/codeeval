
local function split(s, how)
    local t = {}
    for match in s:gmatch('(' .. how .. ')') do
        table.insert(t, match)
    end
    return t
end

local function map(t, f)
    local nt = {}
    for k,v in pairs(t) do
        nt[k] = f(t[k])
    end
    return nt
end

local function zip(t1, t2)
    local t = {}
    for k,_ in pairs(t1) do
        t[k] = {t1[k], t2[k]}
    end
    return t
end

local function maxt(t)
    local best = nil
    for _,v in pairs(t) do
        if best == nil or v > best then best = v end
    end
    return best
end

local function find_missing_entry_index(t, max_known_index)
    local fixed_missing_entry = false
    
    for i=1, max_known_index do        
        local found_match = false
        for k,v in pairs(t) do
            if v[2] == i then
                found_match = true
                break
            end
        end
        
        if found_match == false then
            return i
        end
    end
    
    -- missing index is last word
    return max_known_index + 1
end

local function fix_missing_entry(t, max_known_index)
    for k,v in pairs(t) do
        if v[2] == nil then
            v[2] = find_missing_entry_index(t, max_known_index)
        end
    end
end

local function data_recovery(line)
    local words, indexes = line:match('(.+);(.+)')
    words = split(words, '[^ ]+')
    indexes = map(split(indexes, '[^ ]+'), tonumber)
    
    local word_index_map = zip(words, indexes)
    
    fix_missing_entry(word_index_map, maxt(indexes))
    
    table.sort(word_index_map, function(a, b) return a[2] < b[2] end)
    
    local fixed_words = map(word_index_map, function(a) return a[1] end)
    
    return table.concat(fixed_words, ' ')
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

codeeval(data_recovery)