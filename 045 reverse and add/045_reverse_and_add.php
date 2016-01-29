<?php

    function is_palindrome($s)
    {
        return $s === strrev($s);
    }

    function reverse_and_add($num)
    {
        $i = 0;

        while(true)
        {
            if(is_palindrome((string)$num))
            {
                return "$i $num";
            }

            $num = $num + (int)strrev($num);
            $i++;
        }
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        echo reverse_and_add((int)trim($line)) . PHP_EOL;
    }
