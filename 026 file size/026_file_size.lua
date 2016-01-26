-- local filename = arg[0]
local filename = arg[1]

local f = io.open(filename, "r")
local file_size = f:seek('end')
f:close()

print(file_size)