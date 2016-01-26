<?php

    function decimal_to_binary($line)
    {
        // Wow, this is really cheating
        echo base_convert(trim($line), 10, 2) . PHP_EOL;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        if(trim($line) !== '')
        {
            decimal_to_binary($line);
        }
    }
