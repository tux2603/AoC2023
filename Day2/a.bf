Main loop to read data in one game at a time
Memory cell 0 will be the character most recently read
Memory cell 1 and 2 will be used to store the result
Memory cell 3 will be used for store the current game number
Memory cell 4 will be used to store the maximum number of red cubes in this game
Memory cell 5 will be used to store the maximum number of green cubes in this game
Memory cell 6 will be used to store the maximum number of blue cubes in this game

clear all the memory cells used for non scrap data
+                                                       MC0

,
game loop
starts with the pointer at memory cell 0
[                                                       MC0
    read in the next four characters
    ,,,,

    Move to the first scrap cell
    >>>> >>>[-]+                                        MC7
    
    Parse the number with the result in cell 8
    [[-]                                                MC7
        Read in the next digit
        >>,                                             MC9

        Subtract 48 from the digit to get the actual number
        >>-[<+>-----]<---                               MC10
        [-<->]<                                         MC9

        Add the value if it is between zero and nine
        Break out of the number parsing logic if it isn't
        [->+>+<<]                                       MC9
        ++++++++++                                      MC9
        
        [-                                              MC9
            <<[-]>>>                                    MC10
            [->>+>+<<<]                                 MC10
            +                                           MC10
            >>>[[-]<<<[-]>>>]                           MC13
            <<<                                         MC10

            This block only runs when the character is a digit
            [-                                          MC10

                Clear 9 and 10 for use in the multiplication
                [-]                                     MC10
                <[-]                                    MC9

                Multiply the current number by ten
                <                                       MC8
                [->+>+<<]                               MC8
                >>>>++++++++++                          MC12
                [-                                      MC12
                    <<<[-<+>]                           MC9
                    >[-<+>>>>+<<<]                      MC10
                    >>>[-<<<+>>>]                       MC13              
                <]                                      MC12
                <<[-]                                   MC10
                <[-]                                    MC9

                Add the new number
                >>[-<<<+>>>]                            MC11

                Do clean up
                <<<<+>>                                 MC9
                >>>+                                    MC12
            <<]                                         MC10 

            >>-[-<<+>>]                                 MC12
        <<<]                                            MC9
    <<]                                                 MC7

    If the character was not a number then 10 and 11 will be dirty
    >>>[-]                                              MC10
    >[-]                                                MC11

    Move the result from 8 to 3
    <<<[-<<<< <+>>>> >]                                 MC8

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%                   READ IN THE COLOR NUMBERS                    %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    <[-]+                                               MC7

    Read in the color numbers until none are left
    [                                                   MC7    
        The first character will be a space and should be ignored
        [-]>,[-]+                                       MC8
        
        Parse the number with the result in cell 9
        [[-]                                            MC8
            Read in the next digit
            >>,                                         MC10

            Subtract 48 from the digit to get the actual number
            >>-[<+>-----]<---                           MC11
            [-<->]<                                     MC10

            Add the value if it is between zero and nine
            Break out of the number parsing logic if it isn't
            >>[-]                                       MC12
            <<[->+>+<<]                                 MC10
            ++++++++++                                  MC10

            [-                                          MC10
                <<[-]>>>                                MC11
                [->>+>+<<<]                             MC11
                +                                       MC11
                >>>[[-]<<<[-]>>>]                       MC14
                <<<                                     MC11
                
                This block only runs when the character is a digit
                [-                                      MC11
                    Clear 10 and 11 for use in the multiplication
                    [-]                                 MC11
                    <[-]                                MC10
                    

                    Multiply the current number by ten
                    <                                   MC9
                    [->+>+<<]                           MC9
                    >>>>++++++++++                      MC13
                    
                    [-                                  MC13
                        <<<[-<+>]                       MC10
                        >[-<+>>>>+<<<]                  MC11
                        >>>[-<<<+>>>]                   MC14              
                    <]                                  MC13
                    <<[-]                               MC11
                    <[-]                                MC10

                    Add the new number
                    >>[-<<<+>>>]                        MC12

                    Do clean up
                    <<<<+>>                             MC10
                    >>>+                                MC13
                <<]                                     MC11 

                >>-[-<<+>>]                             MC13
            <<<]                                        MC10
        <<]                                             MC8

        If the character was not a number then 11 and 12 will be dirty
        >>>[-]                                          MC11
        >[-]                                            MC12

        9 now holds the number of some color of block
        Copy that to 7 and get the color of block that we need
        to check
        <<<[-<<+>>]                                      MC9

        Read in the next character to see if it is an r a b or a g
        <,                                              MC8

        Subtract 98 from the character to see if it is a b
        >+[-[---<]>>-]<                                 MC11
        [-<<<->>>]<<<                                   MC8
        [->>+>+<<<]                                     MC8
        >+                                              MC9
        >>[[-]<<[-]>>]                                  MC11
        <[-<<+>>]                                       MC10

        If the character was a b then cell 9 will be a one
        <[-                                             MC9
            Move cells 6 and 7 to 10 and 11 to compare
            <<<[->>>>+<<<<]                             MC6
            >[->>>>+<<<<]                               MC7

            Populate cells 12 and 13
            >>>[->>+>+<<<]                              MC10
            >>>[-<<<+>>>]                               MC13
            <<[->>+>+<<<]                               MC11
            >>>[-<<<+>>>]                               MC14

            Gradually decrease the two values until a maximum is found
            <<<[                                        MC11
                Check if cell 12 has reached zero
                >>>+                                    MC14
                <<[->>>+>+<<<<]                         MC12
                >>>>[[-]<<[-]>>]                        MC16
                <[-<<<+>>>]                             MC15

                If cell 14 has a one that means that cell 11 is greater
                <[-                                     MC14
                    Move the value from 11 to 17
                    >>>[-]                              MC17
                    <<<< <<[->>>> >>+<<<< <<]           MC11
                    >+                                  MC12
                >>]                                     MC14

                Check if cell 13 has reached zero
                +                                       MC14
                <[->>+>+<<<]                            MC13
                >>>[[-]<<[-]>>]                         MC16
                <[-<<+>>]                               MC15

                If cell 15 has a one that means that cell 10 is greater
                <[-                                     MC14
                    Move the value from 10 to 17
                    >>>[-]                              MC17
                    <<<< <<<[->>>> >>>+<<<< <<<]        MC10
                    >>>+                                MC13
                >]                                      MC14

                Decrement cells 12 and 13
                <-                                      MC13
                <-                                      MC12

                Move the value from 17 to 16 and 15
                >>>> >[-<+<+>>]                         MC17

                If there is a value in 16 a max was found
                Clear cells 10 11 12 and 13
                <[[-]                                   MC16
                    <<<[-]                              MC13
                    <[-]                                MC12
                    <[-]                                MC11
                    <[-]                                MC10
                >>>> >>]                                MC16
                
                Store the maximum value found
                <[-<<<< <+>>>> >]                       MC15
            <<<<]                                       MC11

            Skip the rest of the characters in the word blue
            ,,,[-]                                      MC11
            
            Copy the new max from cell 10 to cell 6
            <[-<<<<+>>>>]                               MC10
        <]                                              MC9

        Subtract 5 from the character to see if it is a g
        <-----                                          MC8
        [->>+>+<<<]                                     MC8
        >+                                              MC9
        >>[[-]<<[-]>>]                                  MC11
        <[-<<+>>]                                       MC10

        If the character was a g then cell 9 will be a one
        <[-                                             MC9
            Move cells 5 and 7 to 10 and 11 to compare
            <<<<[->>>> >+<<<< <]                        MC5
            >>[->>>>+<<<<]                              MC7

            Populate cells 12 and 13
            >>>[->>+>+<<<]                              MC10
            >>>[-<<<+>>>]                               MC13
            <<[->>+>+<<<]                               MC11
            >>>[-<<<+>>>]                               MC14

            Gradually decrease the two values until a maximum is found
            <<<[                                        MC11
                Check if cell 12 has reached zero
                >>>+                                    MC14
                <<[->>>+>+<<<<]                         MC12
                >>>>[[-]<<[-]>>]                        MC16
                <[-<<<+>>>]                             MC15

                If cell 14 has a one that means that cell 11 is greater
                <[-                                     MC14
                    Move the value from 11 to 17
                    >>>[-]                              MC17
                    <<<< <<[->>>> >>+<<<< <<]           MC11
                    >+                                  MC12
                >>]                                     MC14

                Check if cell 13 has reached zero
                +                                       MC14
                <[->>+>+<<<]                            MC13
                >>>[[-]<<[-]>>]                         MC16
                <[-<<+>>]                               MC15

                If cell 15 has a one that means that cell 10 is greater
                <[-                                     MC14
                    Move the value from 10 to 17
                    >>>[-]                              MC17
                    <<<< <<<[->>>> >>>+<<<< <<<]        MC10
                    >>>+                                MC13
                >]                                      MC14

                Decrement cells 12 and 13
                <-                                      MC13
                <-                                      MC12

                Move the value from 17 to 16 and 15
                >>>> >[-<+<+>>]                         MC17

                If there is a value in 16 a max was found
                Clear cells 10 11 12 and 13
                <[[-]                                   MC16
                    <<<[-]                              MC13
                    <[-]                                MC12
                    <[-]                                MC11
                    <[-]                                MC10
                >>>> >>]                                MC16

                Store the maximum value found
                <[-<<<< <+>>>> >]                       MC15
            <<<<]                                       MC11

            Skip the rest of the characters in the word green
            ,,,,[-]                                     MC11

            Copy the new max from cell 10 to cell 5
            <[-<<<< <+>>>> >]                           MC10
        <]                                              MC9                                             

        Subtract 11 from the character to see if it is an r
        Note that this should be the only option but I want
        to make sure the code is consistent
        <-----------                                    MC8
        [->>+>+<<<]                                     MC8
        >+                                              MC9
        >>[[-]<<[-]>>]                                  MC11
        <[-<<+>>]                                       MC10

        If the character was an r then cell 9 will be a one
        <[-                                             MC9
            Move cells 4 and 7 to 10 and 11 to compare
            <<<< <[->>>> >>+<<<< <<]                    MC4
            >>>[->>>>+<<<<]                             MC7

            Populate cells 12 and 13
            >>>[->>+>+<<<]                              MC10
            >>>[-<<<+>>>]                               MC13
            <<[->>+>+<<<]                               MC11
            >>>[-<<<+>>>]                               MC14

            Gradually decrease the two values until a maximum is found
            <<<[                                        MC11
                Check if cell 12 has reached zero
                >>>+                                    MC14
                <<[->>>+>+<<<<]                         MC12
                >>>>[[-]<<[-]>>]                        MC16
                <[-<<<+>>>]                             MC15

                If cell 14 has a one that means that cell 11 is greater
                <[-                                     MC14
                    Move the value from 11 to 17
                    >>>[-]                              MC17
                    <<<< <<[->>>> >>+<<<< <<]           MC11
                    >+                                  MC12
                >>]                                     MC14

                Check if cell 13 has reached zero
                +                                       MC14
                <[->>+>+<<<]                            MC13
                >>>[[-]<<[-]>>]                         MC16
                <[-<<+>>]                               MC15

                If cell 15 has a one that means that cell 10 is greater
                <[-                                     MC14
                    Move the value from 10 to 17
                    >>>[-]                              MC17
                    <<<< <<<[->>>> >>>+<<<< <<<]        MC10
                    >>>+                                MC13
                >]                                      MC14

                Decrement cells 12 and 13
                <-                                      MC13
                <-                                      MC12

                Move the value from 17 to 16 and 15
                >>>> >[-<+<+>>]                         MC17

                If there is a value in 16 a max was found
                Clear cells 10 11 12 and 13
                <[[-]                                   MC16
                    <<<[-]                              MC13
                    <[-]                                MC12
                    <[-]                                MC11
                    <[-]                                MC10
                >>>> >>]                                MC16

                Store the maximum value found
                <[-<<<< <+>>>> >]                       MC15
            <<<<]                                       MC11

            Skip the rest of the characters in the word red
            ,,[-]                                       MC11

            Copy the new max from cell 10 to cell 4
            <[-<<<< <<+>>>> >>]                         MC10
        <]                                              MC9

        All the colors are handled now
        <[-]                                            MC8
        

        We want to continue if the nexr character is not a new line
        ,----------                                     MC8
        
        [[-]<+>]                                        MC8
    <]                                                  MC7

    Check to see if any of the colors are over the maximum value

    The maximum value for blue is 14
    [-]++++ ++++ ++++ ++                                MC7

    >+                                                  MC8
    <+<+                                                MC6

    >>[                                                 MC8
        <<->->                                          MC8
        [-]                                             MC8
        <<[->>>+>+<<<<]                                 MC6
        >>>>[-<<<<+>>>>]                                MC10
        <[[-]<+>]                                       MC9
        <<[->>+>+<<<]                                   MC7
        >>>[-<<<+>>>]                                   MC10
        <[[-]<+>]                                       MC9
        <[->+>+<<]                                      MC8
        >[[-]>-<]                                       MC9
        >[-<<+>>]                                       MC10
    <<]                                                 MC8
    <[-]                                                MC7
    
    
    
    The maximum value for green is 13
    ++++ ++++ ++++ +                                    MC7

    >+                                                  MC8
    <+<<+                                               MC5

    >>>[                                                MC8
        <<<->>->                                        MC8
        [-]                                             MC8
        <<<[->>>>+>+<<<< <]                             MC5
        >>>> >[-<<<< <+>>>> >]                          MC10
        <[[-]<+>]                                       MC9
        <<[->>+>+<<<]                                   MC7
        >>>[-<<<+>>>]                                   MC10
        <[[-]<+>]                                       MC9
        <[->+>+<<]                                      MC8
        >[[-]>-<]                                       MC9
        >[-<<+>>]                                       MC10
    <<]                                                 MC8
    <[-]                                                MC7
    
    

    The maximum value for red is 12
    ++++ ++++ ++++                                      MC7

    >+                                                  MC8
    <+<<<+                                              MC4

    >>>>[                                               MC8
        <<<<->>>->                                      MC8
        [-]                                             MC8
        <<<<[->>>> >+>+<<<< <<]                         MC4
        >>>> >>[-<<<< <<+>>>> >>]                       MC10
        <[[-]<+>]                                       MC9
        <<[->>+>+<<<]                                   MC7
        >>>[-<<<+>>>]                                   MC10
        <[[-]<+>]                                       MC9
        <[->+>+<<]                                      MC8
        >[[-]>-<]                                       MC9
        >[-<<+>>]                                       MC10
    <<]                                                 MC8
    <[-]                                                MC7

    Accumulate cell 6 and 5 into cell 4
    <[-<+>]                                             MC6
    <[-<+>]                                             MC5
    
    
    If MC4 has a value of zero then we don't add to the total
    <[[-]>+<]+                                          MC4
    >[[-]<[-]>]                                         MC5

    <[[-]                                               MC4
        Print the hex of the game number
        
        Add with carry
        <[-                                             MC3
            <+                                          MC2
            [->>>+>+<<<<]                               MC2
            +                                           MC2
            >>>>[[-]<<<<->>>>]                          MC6
            <<<<[-<+>]                                  MC2
            >>>[-<<<+>>>]                               MC5
        <<]                                             MC3
    >]                                                  MC4
    

    Clear cells 3 to 6
    <[-]                                                MC3
    >[-]                                                MC4
    >[-]                                                MC5
    >[-]                                                MC6
<<<< <<,]                                              MC0

>.>.