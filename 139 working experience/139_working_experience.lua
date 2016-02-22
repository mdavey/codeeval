
local Experience = {}
Experience.__index = Experience

function Experience.new()
    return setmetatable({dates={}}, Experience)
end

function Experience:__tostring()
    return table.concat(self.dates, ',')
end

function Experience:add_range(sm, sy, em, ey)
    while true do
        self.dates[sm .. sy] = true
        
        if sm == em and sy == ey then
            return
        end
        
        sm = sm + 1
        if sm > 12 then
            sm = 1
            sy = sy + 1
        end
    end
end

function Experience:num_months()
    local m = 0
    for _,_ in pairs(self.dates) do
        m = m + 1
    end
    return m
end


local function working_experience(line)
    
    local month_map = {Jan=1, Feb=2, Mar=3, Apr=4, May=5, Jun=6, Jul=7, Aug=8, Sep=9, Oct=10, Nov=11, Dec=12}
    
    local experience = Experience.new()
    
    for sm, sy, em, ey in line:gmatch('(%a%a%a) (%d%d%d%d)%-(%a%a%a) (%d%d%d%d)') do
        sm, sy = tonumber(month_map[sm]), tonumber(sy)
        em, ey = tonumber(month_map[em]), tonumber(ey)
        experience:add_range(sm, sy, em, ey)
    end
    
    return tostring(math.floor(experience:num_months() / 12))
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

codeeval(working_experience)