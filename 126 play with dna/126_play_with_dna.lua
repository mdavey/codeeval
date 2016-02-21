
-- Stolen from https://gist.github.com/Badgerati/3261142
--  * Is this cheating?
--  * What about using PHP and just calling the inbuilt levenshtein()?
--  * Am I expected to be able to write this without looking up wikipedia
--    and implementing the algorithm from there?

function levenshtein(str1, str2)
    local len1 = string.len(str1)
    local len2 = string.len(str2)
    local matrix = {}
    local cost = 0

    -- quick cut-offs to save time
    if (len1 == 0) then
        return len2
    elseif (len2 == 0) then
        return len1
    elseif (str1 == str2) then
        return 0
    end

    -- initialise the base matrix values
    for i = 0, len1, 1 do
        matrix[i] = {}
        matrix[i][0] = i
    end
    for j = 0, len2, 1 do
        matrix[0][j] = j
    end

    -- actual Levenshtein algorithm
    for i = 1, len1, 1 do
        for j = 1, len2, 1 do
            if (str1:byte(i) == str2:byte(j)) then
                cost = 0
            else
                cost = 1
            end

            matrix[i][j] = math.min(matrix[i-1][j] + 1, matrix[i][j-1] + 1, matrix[i-1][j-1] + cost)
        end
    end

    -- return the last value - this is the Levenshtein distance
    return matrix[len1][len2]
end


local function play_with_dna(line)
    local segment, max_mismatch, dna_string = line:match('(%a+) (%d+) (%a+)')
    max_mismatch = tonumber(max_mismatch)
    
    -- look at all substrings in the dna_string and store the differences in
    -- a map (so we can print the matches with the lowest differences first)
    local priority_map = {}
    
    -- make sure this is in order...
    for i=0, max_mismatch do
        priority_map[i] = {}
    end
    
    for i=1, string.len(dna_string) - string.len(segment) + 1 do
        local dna_slice = string.sub(dna_string, i, i + string.len(segment) - 1)
        local differences = levenshtein(segment, dna_slice)
        
        if differences <= max_mismatch then
            table.insert(priority_map[differences], dna_slice)
        end
    end
    
    -- flattern and sort  (by num differences, then alphabetical)
    local results = {}
    
    -- remember, cannot use ipairs, first key is zero
    for i=0, max_mismatch do        
        table.sort(priority_map[i])
        for _,v in ipairs(priority_map[i]) do
            table.insert(results, v)
        end
    end
    
    if #results == 0 then
        return 'No match'
    else
        return table.concat(results, ' ')
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

codeeval(play_with_dna)