<?php

    // This is wrong, just happens to get the right answer
    //
    // But I'm given a finite string, so can't actually use the fact there is
    // a loop because, well, there isn't, it's a string.

    function parse($line)
    {
        return array_map('intval', explode(' ', $line));
    }

    function remove_non_loop($numbers)
    {
        // Remove numbers from array that only appear once (not part of the cycle)
        for($i = 0, $c = count($numbers); $i < $c; $i++)
        {
            if(!in_array($numbers[$i], array_slice($numbers, $i + 1)))
            {
                // Set to false, rather than unset() so we don't have to worry about sparse indexing
                $numbers[$i] = false;
            }
        }

        // array_values to reindex the array
        return array_values(array_filter($numbers, function($x)
        {
            return $x !== false;
        }));
    }

    function cycle($line)
    {
        $numbers = remove_non_loop(parse($line));

        for($i = 1; $i < count($numbers); $i++)
        {
            if($numbers[0] == $numbers[$i])
            {
                return implode(' ', array_slice($numbers, 0, $i));
            }
        }

        return '';
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        echo cycle($line) . PHP_EOL;
    }
