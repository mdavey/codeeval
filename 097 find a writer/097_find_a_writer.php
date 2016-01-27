<?php

    function find_a_writer($s)
    {
        list($key, $raw_numbers) = explode('| ', $s);
        $numbers = array_map('intval', explode(' ', $raw_numbers));

        foreach($numbers as $number)
        {
            echo $key[$number-1];
        }

        echo PHP_EOL;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        if(trim($line) !== '')
        {
            find_a_writer($line);
        }
    }
