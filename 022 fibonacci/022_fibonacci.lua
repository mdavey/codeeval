local function fibn(n)
    if n == 0 then return 0 end
    if n == 1 then return 1 end
    return fibn(n-1) + fibn(n-2)
end


local function fib(line)
    return tostring(fibn(tonumber(line)))
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
        local current_dir = arg[0]:match('(.*\\).*')
        
        local data = io.lines(current_dir .. 'data.txt')
        local result = io.lines(current_dir .. 'results.txt')
        
        local count_pass = 0
        local count_fail = 0
        
        while true do
            local input = data()
            local output = result()
            
            -- check files are same length
            if input == nil and output ~= nil then
                print('Error:  No input for output:', output)
                break
            end
            
            if input ~= nil and output == nil then
                print('Error:  No output for input:', input)
                break
            end
            
            -- end of data, print results
            if input == nil and output == nil then
                print()
                if count_fail == 0 then
                    print(string.format('Passed:  %d/%d', count_pass, count_pass+count_fail))
                else
                    print(string.format('Failed:  %d/%d', count_pass, count_pass+count_fail))
                end
                break
            end
            
            -- compute results and check output
            if input ~= nil and output ~= nil then
                local computed = f(input)
                
                if computed == output then
                    count_pass = count_pass + 1
                    print(computed)
                else
                    count_fail = count_fail + 1
                    print(string.format('Got  "%s"  Expected  "%s"  For input  "%s"', computed, output, input))
                end
            end
        end
    end
end


codeeval(fib)