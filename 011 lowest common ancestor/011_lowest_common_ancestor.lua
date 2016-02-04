
-- hard coded binary tree, v value, l left node, r right node
local tree = {
    v = 30, 
    l = {
        v = 8,
        l = {
            v = 3,
            l = nil,
            r = nil
        },
        r = {
            v = 20,
            l = {
                v = 10,
                l = nil,
                r = nil
            },
            r = {
                v = 29,
                l = nil,
                r = nil
            }
        }
    },    
    r = {
        v = 52, 
        l = nil, 
        right = nil
    }
}

-- make a copy of a table/array
local function table_copy(t)
    local c = {}
    for _, v in ipairs(t) do table.insert(c, v) end
    return c
end
    
-- return intersection of table tables/arrays  (unique elements common in both)
local function table_intersect(t1, t2)
    local intersection = {}
    for _, v1 in ipairs(t1) do
        for _, v2 in ipairs(t2) do
            if v1 == v2 then
                table.insert(intersection, v1)
                break
            end
        end
    end
    return intersection
end

-- just making sure I remembered how to recurse over a binary tree...
local function print_tree(node)
    print(node.v)
    if node.l then print_tree(node.l) end
    if node.r then print_tree(node.r) end
end

-- returns the ancestors of a given node value
local function ancestors(node, value_to_find, seen_ancestors)    
    table.insert(seen_ancestors, node.v)
    
    if node.v == value_to_find then
        return seen_ancestors
    else
        if node.l then
            local match = ancestors(node.l, value_to_find, table_copy(seen_ancestors))
            if match ~= false then return match end
        end
        
        if node.r then
            local match = ancestors(node.r, value_to_find, table_copy(seen_ancestors))
            if match ~= false then return match end
        end

        return false
    end
end

local function lowest_common_ancestor(s)    
    local v1, v2 = s:match('(%d+) (%d+)')
    
    local a1 = ancestors(tree, tonumber(v1), {})
    local a2 = ancestors(tree, tonumber(v2), {})
    
    local common = table_intersect(a1, a2)
    
    return tostring(common[#common])
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

codeeval(lowest_common_ancestor)