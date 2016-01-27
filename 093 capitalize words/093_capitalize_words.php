<?php

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        // Haha, kinda cheating again
        echo ucwords($line);
    }
