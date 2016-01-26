    <?php

        // The following is a transcript of all rights to the files:
        // 0 - total ban;
        // 1 - grant;
        // 2 - write;
        // 3 - write, grant;
        // 4 - read;
        // 5 - read, grant;
        // 6 - read, write;
        // 7 - full access (read, write, grant);
        //
        //          file_1   file_2   file_3
        // user_1     7        3        0
        // user_2     6        2        4
        // user_3     5        1        5
        // user_4     3        7        1
        // user_5     6        0        2
        // user_6     4        2        6


        // So...
        // Level is actually useless, the instructions in the file don't care about level, just the raw permissions
        // So all those nice definitions are gone, replace with strings and arrays...

        $initial_state = [
            'user_1' => ['file_1' => ['read', 'write', 'grant'], 'file_2' => ['write', 'grant'],         'file_3' => []],
            'user_2' => ['file_1' => ['read', 'write'],          'file_2' => ['write'],                  'file_3' => ['read']],
            'user_3' => ['file_1' => ['read', 'grant'],          'file_2' => ['grant'],                  'file_3' => ['read', 'grant']],
            'user_4' => ['file_1' => ['write'],                  'file_2' => ['read', 'write', 'grant'], 'file_3' => ['grant']],
            'user_5' => ['file_1' => ['read', 'write'],          'file_2' => [],                         'file_3' => ['write']],
            'user_6' => ['file_1' => ['read'],                   'file_2' => ['write'],                  'file_3' => ['read', 'write']],
        ];

        function run_line($state, $line)
        {
            $instructions = explode(' ', trim($line));

            foreach($instructions as $instruction)
            {
                // state passed by reference
                if(!run_instruction($state, $instruction))
                {
                    return false;
                }
            }

            return true;
        }

        function run_instruction(&$state, $instruction)
        {
            $tokens = explode('=>', $instruction);

            $user = $tokens[0];
            $file = $tokens[1];
            $op   = $tokens[2];

            // no access
            if(!in_array($op, $state[$user][$file]))
            {
                return false;
            }

            // read and write are find.  now just check if we need to update the permissions as well
            if($op == 'grant')
            {
                $grant_op = $tokens[3];
                $grant_user = $tokens[4];

                // I think we append the op... I mean that's was grant means?  But how do you remove or set?
                $state[$grant_user][$file][] = $grant_op;
            }

            return true;
        }


        $filename = (strpos($argv[0], 'Matthew\Dropbox') !== false) ? 'data.txt' : $argv[1];

        foreach(file($filename) as $line)
        {
            echo (run_line($initial_state, $line) ? 'True' : 'False') . PHP_EOL;
        }
