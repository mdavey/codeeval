<?php

    // An Armstrong number is an n-digit number that is equal to the sum of the n'th powers of its digits.
    // e.g. 153
    // 3 digits = raise each number to power of 3
    // 1^3 + 5^3 + 3^3  =>  153
    // True
    function armstrong_number($s)
    {
        $val = (int)$s;
        $power = strlen($s);
        $digits = array_map('intval', str_split($s));
        $raised = array_map(function($i) use ($power)
        {
            return pow($i, $power);
        }, $digits);

        return array_sum($raised) === $val;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        echo (armstrong_number(trim($line)) ? 'True' : 'False') . PHP_EOL;
    }
