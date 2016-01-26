<?php

    function ascii_decryption($line)
    {
        list($known_length, $known_last_character, $raw_ascii) = explode(' | ', $line);
        $ascii = array_map('intval', explode(' ', $raw_ascii));

        $offset = guess_offset($known_length, $known_last_character, $ascii);

        foreach($ascii as $char)
        {
            echo chr($char-$offset);
        }
    }

    function guess_offset($known_length, $known_last_character, $ascii)
    {
        for($i = 0; $i < count($ascii) - $known_length; $i++)
        {
            $base_seq = array_slice($ascii, $i, $known_length);

            for($j = $i + $known_length; $j < count($ascii) - $known_length; $j++)
            {
                $test_seq = array_slice($ascii, $j, $known_length);

                if($base_seq === $test_seq)
                {
                    // Work out how to get out known last character from our sequence
                    $offset = $base_seq[$known_length-1] - ord($known_last_character);

                    // Now, we have a valid offset we need to test if the character before, or after out word is space
                    // (Because we might have matched a sequence like:  "e at b"
                    if((($ascii[$j-1]-$offset) == ord(' ')))
                    {
                        return $offset;
                    }
                    elseif(($ascii[$i+$known_length]-$offset) == ord(' '))
                    {
                        return $offset;
                    }
                }
            }
        }

        return false;
    }


    $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

    foreach(file($filename) as $line)
    {
        ascii_decryption(trim($line));
    }
