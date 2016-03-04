<?php

    $filename = (count($_SERVER['argv']) === 2) ? $_SERVER['argv'][1] : 'data.txt';

    foreach(file($filename) as $line)
    {
        $line = trim($line);

        if(strlen($line) <= 55)
        {
            echo $line . PHP_EOL;
        }
        else
        {
            $line = substr($line, 0, 40);
            $last_space = strrpos($line, ' ');

            if($last_space !== false)
            {
                $line = trim(substr($line, 0, $last_space));
            }

            echo $line . '... <Read More>' . PHP_EOL;
        }
    }

