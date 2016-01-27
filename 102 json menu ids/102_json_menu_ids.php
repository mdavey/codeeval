<?php

    function sum_json_menu_ids($s)
    {
        $sum = 0;

        $j = json_decode($s);

        foreach($j->menu->items as $item)
        {
            if(isset($item->label))
            {
                $sum += (int)$item->id;
            }
        }

        return $sum;
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        if(trim($line) !== '')
        {
            echo sum_json_menu_ids($line) . PHP_EOL;
        }
    }
