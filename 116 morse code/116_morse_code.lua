
local morse_code_map = {
    ['.-']   = 'A',
    ['-...'] = 'B',
    ['-.-.'] = 'C',
    ['-..']  = 'D',
    ['.']    = 'E',
    ['..-.'] = 'F',
    ['--.']  = 'G',
    ['....'] = 'H',
    ['..']   = 'I',
    ['.---'] = 'J',
    ['-.-']  = 'K',
    ['.-..'] = 'L',
    ['--']   = 'M',
    ['-.']   = 'N',
    ['---']  = 'O',
    ['.--.'] = 'P',
    ['--.-'] = 'Q',
    ['.-.']  = 'R',
    ['...']  = 'S',
    ['-']    = 'T',
    ['..-']  = 'U',
    ['...-'] = 'V',
    ['.--']  = 'W',
    ['-..-'] = 'X',
    ['-.--'] = 'Y',
    ['--..'] = 'Z',
    
    ['-----'] = '0',
    ['.----'] = '1',
    ['..---'] = '2',
    ['...--'] = '3',
    ['....-'] = '4',
    ['.....'] = '5',
    ['-....'] = '6',
    ['--...'] = '7',
    ['---..'] = '8',
    ['----.'] = '9'
}

local function morse_code(s)
    -- '()' to only return first value.  gsub returns (string, substitution_count).
    return (s:gsub('([%.%-]+)%s?', morse_code_map)) 
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

codeeval(morse_code)