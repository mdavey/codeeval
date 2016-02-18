
-- Overlapping rectangles for some defintion of overlapping
--
--  (1,-2),(4,-3)  (2,-1),(3,-4)  are two overlapping rectangles
--                                but their corners don't overlap

local Rect = {}

function Rect.new(x1, y1, x2, y2)
    return setmetatable({x1=x1, y1=y1, x2=x2, y2=y2}, Rect)
end

function Rect:__tostring()
    return table.concat({self.x1, self.y1, self.x2, self.y2}, ',')
end

function Rect:__pow(other)
    local check_point = function(x, y)
        if x >= math.min(self.x1, self.x2) and 
           x <= math.max(self.x1, self.x2) and
           y >= math.min(self.y1, self.y2) and 
           y <= math.max(self.y1, self.y2) then
            return true
        else
            return false
        end
    end
    
    return check_point(other.x1, other.y1) or check_point(other.x2, other.y1) or
           check_point(other.x1, other.y2) or check_point(other.x2, other.y2)
end


local function overlapping_rectangles(line)
    local a_x1, a_y1, a_x2, a_y2, b_x1, b_y1, b_x2, b_y2 = 
        line:match('(%-?%d+),(%-?%d+),(%-?%d+),(%-?%d+),(%-?%d+),(%-?%d+),(%-?%d+),(%-?%d+)')
   
    local r1 = Rect.new(tonumber(a_x1), tonumber(a_y1), tonumber(a_x2), tonumber(a_y2))
    local r2 = Rect.new(tonumber(b_x1), tonumber(b_y1), tonumber(b_x2), tonumber(b_y2))
   
    if r1 ^ r2 or r2 ^ r1 then
        return 'True'
    else
        return 'False'
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

codeeval(overlapping_rectangles)