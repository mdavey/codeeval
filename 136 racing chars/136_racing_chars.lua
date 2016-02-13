
local function get_replace_char(lines, line_number, last_pos, this_pos)
    -- first direction is always straight
    if (line_number == 1) then
        return '|'
    end
    
    if last_pos < this_pos then
        return '\\'
    elseif last_pos > this_pos then
        return '/'
    else
        return '|'
    end
end


-- just assuming that we won't need to backtrack...
local function racing_chars(lines)
    
    local last_pos = nil
    
    for line_number,line in ipairs(lines) do
        local checkpoint_pos = line:find('C')
        local gate_pos = line:find('_')
        
        if checkpoint_pos then
            local replace_char = get_replace_char(lines, line_number, last_pos, checkpoint_pos)
            print((line:gsub('C', replace_char)))
            last_pos = checkpoint_pos
        else
            local replace_char = get_replace_char(lines, line_number, last_pos, gate_pos)
            print((line:gsub('_', replace_char)))
            last_pos = gate_pos
        end
    end
end


local data_filename = arg[1]

if arg[0]:find('Users\\Matthew') ~= nil then
    data_filename = arg[0]:match('(.*\\).*') .. '/data.txt'
end
    
local lines = {}
for line in io.lines(data_filename) do
    table.insert(lines, line)
end

racing_chars(lines)