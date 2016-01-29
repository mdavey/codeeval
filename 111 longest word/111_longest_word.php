<?php

    function longest_word($s)
    {
        $words = explode(' ', $s);
        $longestWord = '';

        // Not map'ing/sorting because order is important
        foreach($words as $word)
        {
            if(strlen($word) > strlen($longestWord))
            {
                $longestWord = $word;
            }
        }

        return $longestWord;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        echo longest_word(trim($line)) . PHP_EOL;
    }
