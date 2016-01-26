<?php

foreach(file($_SERVER['argv'][1]) as $line)
{
    list($num, $p1, $p2) = explode(',', trim($line));

    $num = (int)$num;
    $p1 = (int)$p1-1;
    $p2 = (int)$p2-1;
    
    $v1 = ($num & (1 << $p1)) >> $p1;
    $v2 = ($num & (1 << $p2)) >> $p2;
    
    // printf("%b %b %b %b %b\n", $num, 1 << $p1, 1 << $p2, $v1, $v2);
    
    if($v1 === $v2)
    {
        echo "true\n";
    }
    else
    {
        echo "false\n";
    }
}