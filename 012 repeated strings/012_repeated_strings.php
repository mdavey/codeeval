<?php

    /**
     * Converts a string to lowercase
     * @param string $s
     * @return string
     */
    function toLowerCase($s)
    {
        $ord_A  = ord('A');
        $ord_Z  = ord('Z');
        $offset = ord('a') - ord('A');

        for($i = 0, $l = strlen($s); $i < $l; $i++)
        {
            $val = ord($s[$i]);
            if(($val >= $ord_A) && ($val <= $ord_Z))
            {
                $s[$i] = chr($val + $offset);
            }
        }

        return $s;
    }

    $filename = $_SERVER['argv'][1];

    foreach(file($filename) as $line)
    {
        echo toLowerCase($line);
    }

