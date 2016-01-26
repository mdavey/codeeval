local function run_local(f)
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
                print(string.format('Got  "%s"  Expected  "%s"  Input  "%s"', computed, output, input))
            end
        end
    end
end


return { run_local=run_local }