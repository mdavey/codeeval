<?php

    function sum_of_integers($line)
    {
        $numbers = array_map('intval', explode(',', $line));

        $best = false;

        for($offset = 0; $offset < count($numbers); $offset++)
        {
            for($length = 1; $length <= count($numbers); $length++)
            {
                $sum = array_sum(array_slice($numbers, $offset, $length));

                if(($best === false) || ($sum > $best))
                {
                    $best = $sum;
                }
            }
        }

        return $best;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        echo sum_of_integers($line) . PHP_EOL;
    }
