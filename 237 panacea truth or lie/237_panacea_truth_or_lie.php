<?php

    foreach(file($_SERVER['argv'][1]) as $line)
    {
        list($hex_string, $binary_string) = explode(' | ', $line);
        
        $hex    = array_map(function($i) { return base_convert($i, 16, 10); }, explode(' ', $hex_string));
        $binary = array_map(function($i) { return base_convert($i, 2, 10);  }, explode(' ', $binary_string));

        echo (array_sum($binary) >= array_sum($hex)) ? "True\n" : "False\n";
    }