<?php

    function juggling_zeros($s)
    {
        $words = explode(' ', $s);
        $binaryDigits = '';

        for($i = 0; $i < count($words); $i += 2)
        {
            if($words[$i] === '0')
            {
                $binaryDigits .= $words[$i+1];
            }
            elseif($words[$i] === '00')
            {
                $binaryDigits .= str_repeat('1', strlen($words[$i+1]));
            }
        }

        return base_convert($binaryDigits, 2, 10);
    }

    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        echo juggling_zeros(trim($line)) . PHP_EOL;
    }
