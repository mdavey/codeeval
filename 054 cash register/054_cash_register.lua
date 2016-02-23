
local register = {
    {what = 'ONE HUNDRED', value = 100.00},
    {what = 'FIFTY',       value =  50.00},
    {what = 'TWENTY',      value =  20.00},
    {what = 'TEN',         value =  10.00},
    {what = 'FIVE',        value =   5.00},
    {what = 'TWO',         value =   2.00},
    {what = 'ONE',         value =   1.00},
    {what = 'HALF DOLLAR', value =   0.50},
    {what = 'QUARTER',     value =   0.25},
    {what = 'DIME',        value =   0.10},
    {what = 'NICKEL',      value =   0.05},
    {what = 'PENNY',       value =   0.01}
}

local function cash_register(s)
    local cost, cash = s:match('(%d+%.?%d*);(%d+%.?%d*)')
    cost = tonumber(cost) -- ugh
    cash = tonumber(cash) -- ugh
    
    if cost > cash then return 'ERROR' end
    if cost == cash then return 'ZERO' end
    
    local change = {}
    
    for _,current in ipairs(register) do
        while cost + current.value <= cash do
            table.insert(change, current.what)
            cost = cost + current.value
        end
    end
    
    return table.concat(change, ',')
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

codeeval(cash_register)