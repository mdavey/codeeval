
-- So this doesn't work
--
-- I'm bruteforcing the solution while keeping an array of all the states I've
-- seen before.  If I encounter an previously seen state, I know that I've 
-- made a loop and to stop recursing.
--
-- Problem is that the function solves the puzzle in a horrible way (thousads
-- of steps) and because all of it's states have been recorded no other branch
-- can reuse those states.  i.e. if we find a solution that toggles 3,3 as
-- the final change, no other solver can re-use that state and do it quicker.
--
-- No idea how to detect an unsolvable puzzle either...
--
-- Maybe if I use the state array to record if that serious of states managed to
-- find a solution, and if so allow the loop to re-occur?  That doesn't sound
-- right...



local Board = {}
Board.__index = Board

function Board.new()
    return setmetatable({steps=0, width=0, height=0, cells={}}, Board)
end

function Board:set(width, height, string, steps)
    self.width = width
    self.height = height
    
    for char in string:gmatch('.') do
        table.insert(self.cells, char)
    end
    
    if steps ~= nil then
        self.steps = steps
    end
end

function Board:toggle_single(x, y)
    if x > self.width then error('x out of range') end
    if y > self.height then error('y out of range') end
    
    local offset = ((y-1) * self.width) + x
    
    if self.cells[offset] == '1' then
        self.cells[offset] = '0'
    else
        self.cells[offset] = '1'
    end
end

function Board:toggle(x, y)
    self.steps = self.steps + 1
    self:toggle_single(x, y)
    
    print(self.steps)
    
    if x > 1           then self:toggle_single(x-1, y)   end
    if x < self.width  then self:toggle_single(x+1, y)   end
    if y > 1           then self:toggle_single(x,   y-1) end
    if y < self.height then self:toggle_single(x,   y+1) end
end

function Board:show()
    print(string.format('%dx%d (step %d)', self.width, self.height, self.steps))
    local x = 1
    for _,v in ipairs(self.cells) do
        io.stdout:write(v)
        x = x + 1
        if x > self.width then 
            print() 
            x = 1
        end
    end
end

function Board:hash()
    return table.concat(self.cells)
end

function Board:solved()
    for _,v in ipairs(self.cells) do
        if v == '1' then
            return false
        end
    end
    return true
end

function Board:copy()
    local new_board = Board.new()
    new_board:set(self.width, self.height, self:hash(), self.steps)
    return new_board
end




local states = {}


function solve(b)
    
    if(b:solved()) then
        print('Already solved')
        b:show()
    end
   
    for x=1, b.width do
        for y=1, b.height do
       
            local new_board = b:copy()
            new_board:toggle(x, y)
           
            if new_board:solved() then
                print('Solved')
                new_board:show()
            elseif states[new_board:hash()] == nil then
                states[new_board:hash()] = true
                solve(new_board)
            else
                -- print('Loop detected')
            end
        end
    end
end


local b = Board.new()
b:set(4, 3, '000001000000')
solve(b)





