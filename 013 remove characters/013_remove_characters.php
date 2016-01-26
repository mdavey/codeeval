<?php

    function remove_characters($line)
    {
        list($string, $characters) = explode(',', $line);

        $string = trim($string);
        $characters = str_split(trim($characters));

        echo str_replace($characters, '', $string) . PHP_EOL;
    }

    // $argv[1] = 'data.txt';
    foreach(file($argv[1]) as $line)
    {
        remove_characters($line);
    }
