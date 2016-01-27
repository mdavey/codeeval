<?php

    // This bothers me.  Why isn't there a better interface for regular
    // expressions there are 4 line of code, with no error or type checking.
    // I should be able to write something to auto fill in a 'record' with
    // correct types or raise an error...
    //
    // record Point (x:int, y:int)
    // match $s on '\(([-]?\d+), ([-]?\d+)\)' into { 0 -> Point.x, 1 -> Point.y }
    //
    // Well... That doesn't make any sense
    //
    // class Point() { public $x; public $y }
    // $p = new Point();
    // match('\(([-]?\d+), ([-]?\d+)\)', ($x, $y) -> new Point($x, $y) )
    //
    // Nope, still don't know what that means
    //
    // These VerbalRegex libraries seem good.
    // https://github.com/VerbalExpressions
    //
    // But, they are too limited to do even really basic stuff like this...
    // They look and read great, but you just cannot do anything non-trivial
    // (at least in the PHP/JS version, the Ruby version seemed powerful)
    //
    // $r = new R()->anchorStart()
    //             ->then('(')
    //             ->captureStart('ax')
    //             ->maybe('-')
    //             ->thenRegex('\d+')
    //             ->captureEnd()
    //             ->then(',')
    //             ->maybeWhitespace()  --  Ummm?  What do.
    //
    // Sigh...
    //
    // At least Lua has lpeg
    //
    //
    // Well, I wrote a lpeg version... Spoilers, it's not really better for
    // this simple problem.
    //
    // local integer = lpeg.P('-')^0 * lpeg.R('09')^1 / tonumber
    // local pair = '(' * integer * ', ' * integer * ')'
    // local points = pair * ' ' * pair
    //
    // local ax, ay, bx, by = points:match(s)
    //
    //
    // Not that different for just breaking up the regex:
    //
    // $integer = '([-]?\d+)';
    // $point = "\($integer, $integer\)";
    // $regex = "#$point $point#";
    //
    // (I'd say better, but still has wrong types)
    function distance($s)
    {
        preg_match('#\(([-]?\d+), ([-]?\d+)\) \(([-]?\d+), ([-]?\d+)\)#', $s, $matches);

        $ax = (int)$matches[1];
        $ay = (int)$matches[2];
        $bx = (int)$matches[3];
        $by = (int)$matches[4];

        $dx = max($ax, $bx) - min($ax, $bx);
        $dy = max($ay, $by) - min($ay, $by);

        echo sqrt(($dx*$dx) + ($dy*$dy)) . PHP_EOL;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        if(trim($line) !== '')
        {
            distance($line);
        }
    }
