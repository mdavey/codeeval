<?php

    function parse($line)
    {
        list($length, $part2) = explode(';', trim($line));
        return [(int)$length, array_map('intval', explode(',', $part2))];
    }

    function array_absurdity($line)
    {
        list($length, $numbers) = parse($line);

        // I think this is O(n)?  (at least if the language uses int indexes, no idea about PHP)
        $seen = array_fill(0, $length, false);

        foreach($numbers as $number)
        {
            if($seen[$number] === false)
            {
                $seen[$number] = true;
            }
            else
            {
                return $number;
            }
        }

        // rules state this won't happen
        return -1;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        if(trim($line) !== '')
        {
            echo array_absurdity($line) . PHP_EOL;
        }
    }
