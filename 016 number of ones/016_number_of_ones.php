<?php

    foreach(file($argv[1]) as $line)
    {
        echo strlen(str_replace('0', '', base_convert(trim($line), 10, 2))) . PHP_EOL;
    }
