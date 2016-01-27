<?php

    function swap_case($s)
    {
        $l = 'abcdefghijklmnopqrstuvwxyz';
        $u = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        return strtr($s, $l . $u, $u . $l);
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        echo swap_case($line);
    }
