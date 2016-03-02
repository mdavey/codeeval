
local age_ranges = {
    {low=0,  high=2,   response="Still in Mama's arms"},
    {low=3,  high=4,   response="Preschool Maniac"},
    {low=5,  high=11,  response="Elementary school"},
    {low=12, high=14,  response="Middle school"},
    {low=15, high=18,  response="High school"},
    {low=19, high=22,  response="College"},
    {low=23, high=65,  response="Working for the man"},
    {low=66, high=100, response="The Golden Years"}
}

local function age_distribution(s)
    local age = tonumber(s:match('(%-?%d+)'))
    
    for _,age_range in ipairs(age_ranges) do        
        if age >= age_range.low and age <= age_range.high then
            return age_range.response
        end
    end
    
    return "This program is for humans"
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

codeeval(age_distribution)