
local function road_trip(line)
    
    local distances = {}
    
    for city, distance in line:gmatch('([^,]+),(%d+);') do
        table.insert(distances, tonumber(distance))
    end
    
    table.sort(distances, function(a,b) return a<b end)
    
    local trip = {}
    
    local current_location = 0
    for _,v in ipairs(distances) do
        table.insert(trip, v-current_location)        
        current_location = v
    end
    
    return table.concat(trip, ',')
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

codeeval(road_trip)