<?php

    /*

    message: "012222 1114142503 0313012513 03141418192102 0113 2419182119021713 06131715070119",
    keyed_alphabet: "BHISOECRTMGWYVALUZDNFJKPQX"
                     ABCDEFGHIJKLMNOPQRSTUVWXYZ

    No space in key, so space = space
    message is even
    25 is highest num
    26 letters in key
    num 0 doesn't appear

     */


    $message = '012222 1114142503 0313012513 03141418192102 0113 2419182119021713 06131715070119';
    $key   = 'BHISOECRTMGWYVALUZDNFJKPQX';
    $alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    foreach(explode(' ', $message) as $word)
    {
        foreach(array_map('intval', str_split($word, 2)) as $enc)
        {
            echo $alpha[strpos($key, chr(ord('A') + $enc))];
        }
        echo ' ';
    }



