<?php

    error_reporting(E_ALL);

    function longest_lines($filename)
    {
        $lines = file($filename);

        $lines_to_print = (int)$lines[0];
        $line_length_map = map_line_length(array_slice($lines, 1));

        for($i = 0; $i < $lines_to_print; $i++)
        {
            echo $line_length_map[$i][1] . PHP_EOL;
        }
    }

    function map_line_length($lines)
    {
        $map = [];

        foreach($lines as $line)
        {
            $map[] = [strlen($line), trim($line)];
        }

        usort($map, function($a, $b)
        {
            if($a[0] < $b[0]) return 1;
            else return 0;
        });

        return $map;
    }

    // longest_lines(dirname(__FILE__) . '/data.txt');
    longest_lines($argv[1]);

