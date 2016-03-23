
-- I don't understand these kind of problems
-- This is not a trivial problem, but it is well studied
-- Am I expected to implement my own version without reading other solutions?
-- Or just to implement a well know and tested algorithum? 

-- From: https://en.wikipedia.org/wiki/Longest_common_subsequence_problem

local function make_multi_table(x, y)
    local t = {}
    for i=0, x do
        t[i] = {}
        for j=0, y do
            t[i][j] = 0
        end
    end
    return t
end

--[[
function LCSLength(X[1..m], Y[1..n])
    C = array(0..m, 0..n)
    for i := 0..m
       C[i,0] = 0
    for j := 0..n
       C[0,j] = 0
    for i := 1..m
        for j := 1..n
            if X[i] = Y[j]
                C[i,j] := C[i-1,j-1] + 1
            else
                C[i,j] := max(C[i,j-1], C[i-1,j])
    return C[m,n]
]]

local function lcs_length(x, y)
    local c = make_multi_table(#x, #y)
    
    for i=0, #x do
        c[i][0] = 0
    end
    
    for j = 0, #y do
        c[0][j] = 0
    end
    
    for i=1, #x do
        for j=1, #y do
            if x[i] == y[j] then
                c[i][j] = c[i-1][j-1] + 1
            else
                c[i][j] = math.max(c[i][j-1], c[i-1][j])
            end
        end
    end
    
    return c, c[#x][#y]
end


--[[
function backtrack(C[0..m,0..n], X[1..m], Y[1..n], i, j)
    if i = 0 or j = 0
        return ""
    else if  X[i] = Y[j]
        return backtrack(C, X, Y, i-1, j-1) + X[i]
    else
        if C[i,j-1] > C[i-1,j]
            return backtrack(C, X, Y, i, j-1)
        else
            return backtrack(C, X, Y, i-1, j)
]]


local function backtrack(c, x, y, i, j)
    if i == 0 or j == 0 then
        return ''
    elseif x[i] == y[j] then
        return backtrack(c, x, y, i-1, j-1) .. x[i]
    else
        if c[i][j-1] > c[i-1][j] then
            return backtrack(c, x, y, i, j-1)
        else
            return backtrack(c, x, y, i-1, j)
        end
    end
end
    
    
local function string_to_table(s)
    local t = {}
    for i=1, s:len() do
        t[#t+1] = s:sub(i,i)
    end
    return t
end


local function lcs(line)
    local str1, str2 = line:match('^(.+);(.+)$')
    local x = string_to_table(str1)
    local y = string_to_table(str2)
    local c, lcs = lcs_length(x, y)

    return backtrack(c, x, y, #x, #y)
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


codeeval(lcs)