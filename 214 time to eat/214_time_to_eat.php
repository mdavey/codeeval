<?php

    function cmp($a, $b)
    {
        list($ah, $am, $as) = explode(':', $a);
        list($bh, $bm, $bs) = explode(':', $b);

        if($ah < $bh) return 1;
        if($ah > $bh) return -1;

        if($am < $bm) return 1;
        if($am > $bm) return -1;

        if($as < $bs) return 1;
        if($as > $bs) return -1;

        return 0;
    }

    function time_to_eat($line)
    {
        $times = array_map('trim', explode(' ', $line));
        usort($times, 'cmp');

        echo implode(' ', $times) . PHP_EOL;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        time_to_eat($line);
    }
