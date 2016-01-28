<?php

    error_reporting(E_ALL | E_STRICT);

    function lowest_unique_number($s)
    {
        $seen = array();
        $numbers = explode(' ', $s);

        for($i = 0; $i < count($numbers); $i++)
        {
            $seen[$numbers[$i]] = isset($seen[$numbers[$i]]) ? false : $i;
        }

        $seen = array_filter($seen, function($a) { return is_numeric($a); });

        if(count($seen) === 0)
        {
            return 0;
        }

        ksort($seen);
        $offset = array_values($seen);
        return $offset[0] + 1;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        if(trim($line) !== '')
        {
            echo lowest_unique_number(trim($line)) . PHP_EOL;
        }
    }
