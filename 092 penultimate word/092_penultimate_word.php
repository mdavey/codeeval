<?php

    function penultimate_word($s)
    {
        $words = explode(' ', $s);

        return $words[count($words) - 2];
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        echo penultimate_word(trim($line)) . PHP_EOL;
    }
