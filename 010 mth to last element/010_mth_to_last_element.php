<?php

    function mth_to_last_element($line)
    {
        $elements = explode(' ', trim($line));

        $m = (int)$elements[count($elements)-1];
        $i = count($elements) - 1 - $m;

        if($i >= 0)
        {
            echo $elements[$i] . PHP_EOL;
        }
    }

    foreach(file($argv[1]) as $line)
    {
        mth_to_last_element($line);
    }
