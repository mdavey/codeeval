for x=1, 12 do
    
    local line = ''
    for y=1, 12 do
        line = line .. string.format("%4d", x*y)
    end
    
    print(line:match('%s*(.*)'))
end