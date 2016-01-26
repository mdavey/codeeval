<?php

    // pack the number 1 as unsigned short little endian
    $a = pack('v', 1);

    // unpack the value as unsigned short machine byte order
    $b = unpack('s', $a);
    $b = $b[1];

    if($b === 1)
    {
        echo 'LittleEndian';
    }
    else
    {
        echo 'BigEndian';
    }
