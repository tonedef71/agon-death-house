10000 REM :::::::::::::::::::::::::::::::::::::::::::::::
10010 REM :: DEATH HOUSE FOR AgonLight (BBC BASIC v3)  ::
10020 REM :::::::::::::::::::::::::::::::::::::::::::::::
10030 REM :: 20230809: Version 1.0                     ::
10040 REM :::::::::::::::::::::::::::::::::::::::::::::::
10050 REM :: This game is a BBC BASIC v3 port of the   ::
10060 REM :: C<64 game coded in Commodore BASIC v2 by  ::
10070 REM :: Mark S. Boucher with some enhancements by ::
10080 REM :: Tony DeFusco                              ::
10090 REM :::::::::::::::::::::::::::::::::::::::::::::::
10100 REM :: It is best experienced in a 40+ column,   ::
10110 REM :: 64-color display mode.                    ::
10120 REM :::::::::::::::::::::::::::::::::::::::::::::::
10130 CLEAR
10140 REPEAT CLS:SY$=FN_TO_UPPER(FN_PROMPT(0,0,"TARGET (A)gon or (B)BC B-SDL:","A")):UNTIL SY$ = "A" OR SY$ = "B"
10150 IF SY$ = "B" THEN LEFT = 136:RIGHT = 137:DOWN = 138:UP = 139:DL% = 10:MO% = 9:ELSE LEFT = 8:RIGHT = 21:DOWN = 10:UP = 11:DL% = 14:MO% = 2
10160 MODE MO%
10170 PROC_SETUP:PROC_HIDE_CURSOR
10180 ON ERROR PROC_HANDLE_ERROR:REM Handle ESC key
10190 :
10200 PROC_WELCOME
10210 PROC_IDENTIFY_YOURSELF
10220 REPEAT
10230   PROC_NEW_GAME
10240   Resp$ = FN_SKIP_INTRO
10250   IF Resp$ <> "Y" THEN PROC_INTRO
10260   PROC_INITIAL_TEXT
10270   PROC_MAIN_LOOP:REM Invoke main loop
10280   GameOver% = Won% OR Lost%
10290   IF GameOver% THEN PROC_GAME_OVER:Resp% = FN_PLAY_AGAIN:GameOver% = (Resp% = 1)
10300   IF GameOver% THEN PROC_GOODBYE(GameName$)
10310 UNTIL GameOver%
10320 END:REM The official exit point of the game
10330 :
10340 REM :::::::::::::::
10350 REM :: Main loop ::
10360 REM :::::::::::::::
10370 DEF PROC_MAIN_LOOP
10380 REPEAT
10390   IF NOT (Won% OR Lost%) THEN PROC_CHECK_TIME(FALSE)
10400   IF NOT (Won% OR Lost%) THEN PROC_COMMON_CHOICES
10410   SkipEvents% = FALSE
10420 UNTIL Won% OR Lost%
10430 ENDPROC
10440 :
10450 REM :::::::::::::
10460 REM :: Welcome ::
10470 REM :::::::::::::
10480 DEF PROC_WELCOME
10490 CLS
10500 PRINT TAB(0, 4);:PROC_CENTER(CHR$(17)+CHR$(FG%)+"* "+CHR$(17)+CHR$(RED)+"DEATH HOUSE"+CHR$(17)+CHR$(FG%)+" *")
10510 PRINT TAB(0, 6);:PROC_CENTER("by ")
10520 PRINT TAB(0, 8);:PROC_CENTER("Mark S. Boucher")
10530 PROC_CLOCKWISE_BOX((CW% - 17) DIV 2, 3, 17, 7, CYAN, FALSE)
10540 PROC_ITHOTMK_THEME:PROC_SLEEP(120)
10550 PROC_DEFAULT_COLORS
10560 ENDPROC
10570 :
10580 REM ::::::::::::::
10590 REM :: New game ::
10600 REM ::::::::::::::
10610 DEF PROC_NEW_GAME
10620 Won% = FALSE:Lost% = FALSE:SkipEvents% = TRUE:SkipRandom% = FALSE:OneAM% = FALSE
10630 ENDPROC
10640 :
10650 REM ::::::::::::::::::
10660 REM :: Who are you? ::
10670 REM ::::::::::::::::::
10680 DEF PROC_IDENTIFY_YOURSELF
10690 CLS:PRINT TAB(0, 16)"What is your first name? ";
10700 Name$ = FN_RTRIM(FN_PROMPT_FOR_LETTERS(12)):REM Cap the length of name to be 12 characters
10710 ENDPROC
10720 :
10730 REM ::::::::::::::::::::::::::::::
10740 REM :: Skip Introduction Prompt ::
10750 REM ::::::::::::::::::::::::::::::
10760 DEF FN_SKIP_INTRO
10770 LOCAL message$, r$, y%
10780 message$ = "Skip introduction? (Y/N)":y% = VPOS + 1
10790 PROC_EMPTY_KEYBOARD_BUFFER
10800 REPEAT
10810   r$ = FN_PROMPT(0, y%, message$, "")
10820   IF "0" = r$ THEN SkipRandom% = (NOT SkipRandom%):PROC_SOUND(197 + SkipRandom% * 96, 12)
10830 UNTIL INSTR("YN", r$) <> 0
10840 = r$
10850 :
10860 REM ::::::::::::::::::
10870 REM :: Introduction ::
10880 REM ::::::::::::::::::
10890 DEF PROC_INTRO
10900 CLS:PROC_ERASE_TEXT_BUFFER
10910 PROC_WRITE_TEXT_BUFFER("Welcome to my house, "+Name$+".")
10920 PROC_WRITE_TEXT_BUFFER(" Well, let's see. Oh, it's only half past")
10930 PROC_WRITE_TEXT_BUFFER(" eleven. That gives me a few minutes to")
10940 PROC_WRITE_TEXT_BUFFER(" explain the situation to you. Are you")
10950 PROC_WRITE_TEXT_BUFFER(" quite comfortable in that chair?"+CHR$(NL))
10960 PROC_WRITE_TEXT_BUFFER("Good, then why don't I begin."+CHR$(NL))
10970 PROC_WRITE_TEXT_BUFFER("The proposition is actually quite a")
10980 PROC_WRITE_TEXT_BUFFER(" simple one. At midnight, I lock you in")
10990 PROC_WRITE_TEXT_BUFFER(" the east bedroom of this house. At precisely")
11000 PROC_WRITE_TEXT_BUFFER(" 1 AM, I will unlock the door. If")
11010 PROC_WRITE_TEXT_BUFFER(" you are still alive, I will give you, free and clear,")
11020 PROC_WRITE_TEXT_BUFFER(" the sum of $1,000,000."+CHR$(NL))
11030 PROC_WRITE_TEXT_BUFFER("I know that must sound terribly insane,")
11040 PROC_WRITE_TEXT_BUFFER(" but I trust you did enough research to")
11050 PROC_WRITE_TEXT_BUFFER(" understand the offer."+CHR$(NL))
11060 PROC_WRITE_TEXT_BUFFER("You did do some checking around, didn't you?"+CHR$(NL))
11070 PROC_WRITE_TEXT_BUFFER("Well, no matter; I can tell you about it."+CHR$(FF))
11080 PROC_WRITE_TEXT_BUFFER("The room you are about to enter was")
11090 PROC_WRITE_TEXT_BUFFER(" once my great-grandfather's. Some time")
11100 PROC_WRITE_TEXT_BUFFER(" after midnight one dreary night, the")
11110 PROC_WRITE_TEXT_BUFFER(" servants heard a terrible scream coming")
11120 PROC_WRITE_TEXT_BUFFER(" from his bed chamber. When they opened the")
11130 PROC_WRITE_TEXT_BUFFER(" door to his room, he was dead. The doctor")
11140 PROC_WRITE_TEXT_BUFFER(" said that he had died of a heart")
11150 PROC_WRITE_TEXT_BUFFER(" attack. The servants swore he looked as")
11160 PROC_WRITE_TEXT_BUFFER(" if he was scared into his grave. Ever")
11170 PROC_WRITE_TEXT_BUFFER(" since his death, anyone who slept in")
11180 PROC_WRITE_TEXT_BUFFER(" his room died, some time between midnight")
11190 PROC_WRITE_TEXT_BUFFER(" and one AM. When I took possession of this house,")
11200 PROC_WRITE_TEXT_BUFFER(" I made the offer I now propose to you. Four")
11210 PROC_WRITE_TEXT_BUFFER(" people took me up on it. All died. "+CHR$(FF))
11220 PROC_WRITE_TEXT_BUFFER("So that's the story, pure and simple."+CHR$(NL))
11230 PROC_WRITE_TEXT_BUFFER("..."+CHR$(NL))
11240 PROC_WRITE_TEXT_BUFFER("My, is it that time already? Well, why")
11250 PROC_WRITE_TEXT_BUFFER(" don't you follow me up these stairs......"+CHR$(NL))
11260 PROC_WRITE_TEXT_BUFFER("Ah, here we are. I see you have your")
11270 PROC_WRITE_TEXT_BUFFER(" flashlight. Good, you never know around")
11280 PROC_WRITE_TEXT_BUFFER(" here when the lights will go out."+CHR$(NL))
11290 PROC_WRITE_TEXT_BUFFER("Well, it's that time, "+Name$+"......"+CHR$(NL))
11300 PROC_WRITE_TEXT_BUFFER("Take care, and I hope to find you fine")
11310 PROC_WRITE_TEXT_BUFFER(" and well in an hour."+CHR$(NL))
11320 PROC_WRITE_TEXT_BUFFER("Good luck!!!"+CHR$(FF))
11330 PROC_ALL_TEXT
11340 ENDPROC
11350 :
11360 REM ::::::::::::::::::::::::::
11370 REM :: Initial text of game ::
11380 REM ::::::::::::::::::::::::::
11390 DEF PROC_INITIAL_TEXT
11400 TIME = FN_SET_TIME(12,0,0)
11410 CLS:PROC_ERASE_TEXT_BUFFER
11420 PROC_ANNOUNCE_TIME("")
11430 PROC_WRITE_TEXT_BUFFER("The turning of the key in the lock")
11440 PROC_WRITE_TEXT_BUFFER(" makes your skin crawl. However, as you")
11450 PROC_WRITE_TEXT_BUFFER(" look around the room, you slowly start")
11460 PROC_WRITE_TEXT_BUFFER(" to relax. Other than the fact that the")
11470 PROC_WRITE_TEXT_BUFFER(" furnishings are obviously quite old,")
11480 PROC_WRITE_TEXT_BUFFER(" the room appears quite normal. There is")
11490 PROC_WRITE_TEXT_BUFFER(" a window in the middle of the wall to")
11500 PROC_WRITE_TEXT_BUFFER(" your front, no doubt affording a breath-")
11510 PROC_WRITE_TEXT_BUFFER("taking view of the estate. To the left")
11520 PROC_WRITE_TEXT_BUFFER(" of the window is an ornate writing desk")
11530 PROC_WRITE_TEXT_BUFFER(" that must be at least two hundred years")
11540 PROC_WRITE_TEXT_BUFFER(" old. To the right of the window, on a richly")
11550 PROC_WRITE_TEXT_BUFFER(" inlaid table, is a gramophone, looking")
11560 PROC_WRITE_TEXT_BUFFER(" as if it was bought only yesterday."+CHR$(FF))
11570 PROC_WRITE_TEXT_BUFFER("The wall to your right is completely")
11580 PROC_WRITE_TEXT_BUFFER(" taken up with an immense bookcase built")
11590 PROC_WRITE_TEXT_BUFFER(" around an Italian marble fireplace. The")
11600 PROC_WRITE_TEXT_BUFFER(" shelves are packed tight with books,")
11610 PROC_WRITE_TEXT_BUFFER(" and from your viewpoint, most of them")
11620 PROC_WRITE_TEXT_BUFFER(" seem to be bound in leather. There are")
11630 PROC_WRITE_TEXT_BUFFER(" logs in the fireplace, but no fire. Of")
11640 PROC_WRITE_TEXT_BUFFER(" course, considering the summer heat,")
11650 PROC_WRITE_TEXT_BUFFER(" a fire would be out of the question,")
11660 PROC_WRITE_TEXT_BUFFER(" but somehow you kind of wish there was,")
11670 PROC_WRITE_TEXT_BUFFER(" as if the cheery glow from it would")
11680 PROC_WRITE_TEXT_BUFFER(" ward away all things evil."+CHR$(FF))
11690 PROC_WRITE_TEXT_BUFFER("In the center of the left wall is the")
11700 PROC_WRITE_TEXT_BUFFER(" bed, a massive four-poster with canopy.")
11710 PROC_WRITE_TEXT_BUFFER(" To its right, a nightstand. A rather")
11720 PROC_WRITE_TEXT_BUFFER(" time-worn rocking chair is to the left.")
11730 PROC_WRITE_TEXT_BUFFER(" Behind you is the door, and to its")
11740 PROC_WRITE_TEXT_BUFFER(" right, an old-fashioned washstand,")
11750 PROC_WRITE_TEXT_BUFFER(" with pitcher, bowl, and a rather oddly")
11760 PROC_WRITE_TEXT_BUFFER(" shaped mirror on the wall behind. All")
11770 PROC_WRITE_TEXT_BUFFER(" in all, a normal-looking room."+CHR$(FF))
11780 PROC_ALL_TEXT
11790 ENDPROC
11800 :
11810 REM ::::::::::::::::::::::::::::::::::
11820 REM :: Common avaiable game actions ::
11830 REM ::::::::::::::::::::::::::::::::::
11840 DEF PROC_COMMON_CHOICES
11850 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
11860 AC$(1)="Check the time"
11870 AC$(2)="Sleep"
11880 AC$(3)="Examine the room"
11890 BR = FN_MAKE_CHOICE("Well, "+Name$+", what will you do now?", 3)
11900 ON BR PROC_CHECK_TIME(TRUE), PROC_GET_IN_BED, PROC_EXPLORE_ROOM
11910 ENDPROC
11920 :
11930 REM ::::::::::::::::
11940 REM :: Get in bed ::
11950 REM ::::::::::::::::
11960 DEF PROC_GET_IN_BED
11980 CLS:PROC_ERASE_TEXT_BUFFER
11990 PROC_WRITE_TEXT_BUFFER("You slowly climb into the bed... The thick")
12000 PROC_WRITE_TEXT_BUFFER(" coverlets are quite comfortable, but the")
12010 PROC_WRITE_TEXT_BUFFER(" bed itself is rather hard. Slowly you")
12020 PROC_WRITE_TEXT_BUFFER(" lay your head on the pillow........")
12030 PROC_ALL_TEXT
12040 H = FN_RND_INT(1, 4)
12050 ON H PROC_HARD_PILLOW,PROC_STRANGLED,PROC_NOT_SLEEPY,PROC_GET_OUT_OF_MY_BED
12060 ENDPROC
12070 :
12080 REM :::::::::::::::::
12090 REM :: Hard pillow ::
12100 REM :::::::::::::::::
12110 DEF PROC_HARD_PILLOW
12120 CLS:PROC_ERASE_TEXT_BUFFER
12130 PROC_WRITE_TEXT_BUFFER("and it feels like you've just slammed")
12140 PROC_WRITE_TEXT_BUFFER(" it into a building. There's something")
12150 PROC_WRITE_TEXT_BUFFER(" under the pillow!"+CHR$(FF))
12160 PROC_ALL_TEXT
12170 AC$(1)="Grab item"
12180 AC$(2)="Ignore it"
12190 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
12200 ON BR PROC_ITEM_UNDER_PILLOW,PROC_GET_OUT_OF_MY_BED
12210 ENDPROC
12220 :
12230 REM :::::::::::::::::::::::
12240 REM :: Item under pillow ::
12250 REM :::::::::::::::::::::::
12260 DEF PROC_ITEM_UNDER_PILLOW
12270 H = FN_RND_INT(1, 2)
12280 ON H PROC_BRICK_UNDER_PILLOW,PROC_SNAKE_UNDER_PILLOW
12290 ENDPROC
12300 :
12310 REM ::::::::::::::::::::::::
12320 REM :: Brick under pillow ::
12330 REM ::::::::::::::::::::::::
12340 DEF PROC_BRICK_UNDER_PILLOW
12350 CLS:PROC_ERASE_TEXT_BUFFER
12360 PROC_WRITE_TEXT_BUFFER("No wonder it felt like you slammed your")
12370 PROC_WRITE_TEXT_BUFFER(" head into a building! Someone put a")
12380 PROC_WRITE_TEXT_BUFFER(" brick under the pillow. Disgusted, you")
12390 PROC_WRITE_TEXT_BUFFER(" throw the brick down and again lay on")
12400 PROC_WRITE_TEXT_BUFFER(" the pillow..."+CHR$(FF))
12410 PROC_ALL_TEXT
12420 PROC_NOT_SLEEPY
12430 ENDPROC
12440 :
12450 REM :::::::::::::::::::::::::::::
12460 REM :: Snake underneath pillow ::
12470 REM :::::::::::::::::::::::::::::
12480 DEF PROC_SNAKE_UNDER_PILLOW
12490 CLS:PROC_ERASE_TEXT_BUFFER
12500 PROC_WRITE_TEXT_BUFFER("As you reach under the pillow and withdraw")
12510 PROC_WRITE_TEXT_BUFFER(" the item, you suddenly realize it's")
12520 PROC_WRITE_TEXT_BUFFER(" moving. Startled, you find that you're")
12530 PROC_WRITE_TEXT_BUFFER(" holding a rattlesnake! You feel a sharp")
12540 PROC_WRITE_TEXT_BUFFER(" pain in your chest, and lapse into")
12550 PROC_WRITE_TEXT_BUFFER(" unconsciousness..."+CHR$(FF))
12560 PROC_ALL_TEXT
12570 PROC_DEATH
12580 ENDPROC
12590 :
12600 REM ::::::::::::::::::::::
12610 REM :: Strangled in bed ::
12620 REM ::::::::::::::::::::::
12630 DEF PROC_STRANGLED
12640 CLS:PROC_ERASE_TEXT_BUFFER
12650 PROC_WRITE_TEXT_BUFFER("Just as your getting all snuggled in,")
12660 PROC_WRITE_TEXT_BUFFER(" strong hands seize you roughly by the")
12670 PROC_WRITE_TEXT_BUFFER(" throat. Your eyes open wide, but you")
12680 PROC_WRITE_TEXT_BUFFER(" can't see who's strangling you. Slowly,")
12690 PROC_WRITE_TEXT_BUFFER(" you sink into oblivion..."+CHR$(FF))
12700 PROC_ALL_TEXT
12710 PROC_DEATH
12720 ENDPROC
12730 :
12740 REM ::::::::::::::::
12750 REM :: Not sleepy ::
12760 REM ::::::::::::::::
12770 DEF PROC_NOT_SLEEPY
12790 CLS:PROC_ERASE_TEXT_BUFFER
12800 PROC_WRITE_TEXT_BUFFER("After a moment or so of tossing and")
12810 PROC_WRITE_TEXT_BUFFER(" turning, you realize you'll never fall")
12820 PROC_WRITE_TEXT_BUFFER(" asleep. Cursing, you get out of bed."+CHR$(FF))
12830 PROC_ALL_TEXT
12850 ENDPROC
12860 :
12870 REM :::::::::::::::::::::::
12880 REM :: Get out of my bed ::
12890 REM :::::::::::::::::::::::
12900 DEF PROC_GET_OUT_OF_MY_BED
12920 CLS:PROC_ERASE_TEXT_BUFFER
12930 PROC_WRITE_TEXT_BUFFER("Suddenly, someone (or something) in an")
12940 PROC_WRITE_TEXT_BUFFER(" evil-sounding voice screams 'Get out of")
12950 PROC_WRITE_TEXT_BUFFER(" my damn bed' right in your ear. With")
12960 PROC_WRITE_TEXT_BUFFER(" speed that would please a military drill")
12970 PROC_WRITE_TEXT_BUFFER(" sergeant, you jump out of bed and start")
12980 PROC_WRITE_TEXT_BUFFER(" to stammer an apology, until you realize")
12990 PROC_WRITE_TEXT_BUFFER(" that you're alone!"+CHR$(FF))
13000 PROC_ALL_TEXT
13020 ENDPROC
13030 :
13040 REM :::::::::::::::::::::
13050 REM :: Explore bedroom ::
13060 REM :::::::::::::::::::::
13070 DEF PROC_EXPLORE_ROOM
13080 AC$(1)="North wall"
13090 AC$(2)="South wall"
13100 AC$(3)="East wall"
13110 AC$(4)="West wall"
13120 BR = FN_MAKE_CHOICE("Which part of the bedroom, "+Name$+"?", 4)
13130 ON BR PROC_NORTH_WALL, PROC_SOUTH_WALL, PROC_EAST_WALL, PROC_WEST_WALL
13140 ENDPROC
13150 :
13160 REM ::::::::::::::::::::::::
13170 REM :: Explore north wall ::
13180 REM ::::::::::::::::::::::::
13190 DEF PROC_NORTH_WALL
13220 CLS:PROC_ERASE_TEXT_BUFFER
13230 PROC_WRITE_TEXT_BUFFER("...moving to north wall...")
13240 PROC_ALL_TEXT
13250 H = FN_RND_INT(1, 3)
13260 ON H PROC_PIT,PROC_DISTRACTED,PROC_NORTH_WALL_CHOICES
13270 ENDPROC
13280 :
13290 REM :::::::::::::::::::
13300 REM :: Fall into pit ::
13310 REM :::::::::::::::::::
13320 DEF PROC_PIT
13330 CLS:PROC_ERASE_TEXT_BUFFER
13340 PROC_WRITE_TEXT_BUFFER("Funny, the floor in front of you just")
13350 PROC_WRITE_TEXT_BUFFER(" opened up."+CHR$(NL))
13360 PROC_WRITE_TEXT_BUFFER("You're falling into a pit!!!"+CHR$(NL))
13370 PROC_WRITE_TEXT_BUFFER("As you fall, seemingly forever, you look")
13380 PROC_WRITE_TEXT_BUFFER(" down. You're getting closer to a bedding")
13390 PROC_WRITE_TEXT_BUFFER(" of 30-foot spikes! You feel a")
13400 PROC_WRITE_TEXT_BUFFER(" sharp pain, then nothing..."+CHR$(FF))
13410 PROC_ALL_TEXT
13420 PROC_DEATH
13430 ENDPROC
13440 :
13450 REM ::::::::::::::::
13460 REM :: Distracted ::
13470 REM ::::::::::::::::
13480 DEF PROC_DISTRACTED
13500 CLS:PROC_ERASE_TEXT_BUFFER
13510 PROC_WRITE_TEXT_BUFFER("As you approach the north wall,")
13520 PROC_WRITE_TEXT_BUFFER(" something on the east wall catches your eye!!!"+CHR$(FF))
13530 PROC_ALL_TEXT
13540 PROC_EXPLORE_ROOM
13550 ENDPROC
13560 :
13570 REM :::::::::::::::::::::::::::::
13580 REM :: North wall game actions ::
13590 REM :::::::::::::::::::::::::::::
13600 DEF PROC_NORTH_WALL_CHOICES
13630 AC$(1)="Desk"
13640 AC$(2)="Window"
13650 AC$(3)="Gramophone"
13660 BR = FN_MAKE_CHOICE("Which area first, "+Name$+"?", 3)
13670 ON BR PROC_EXAMINE_DESK, PROC_INSPECT_WINDOW, PROC_GRAMOPHONE
13680 ENDPROC
13690 :
13700 REM ::::::::::::::::::::::::
13710 REM :: Explore south wall ::
13720 REM ::::::::::::::::::::::::
13730 DEF PROC_SOUTH_WALL
13760 CLS:PROC_ERASE_TEXT_BUFFER
13770 PROC_WRITE_TEXT_BUFFER("...moving to south wall...")
13780 PROC_ALL_TEXT
13790 H = FN_RND_INT(1, 4)
13800 ON H PROC_SOUTH_WALL_CHOICES, PROC_SOUTH_WALL_CHOICES, PROC_GRABBED_FROM_BEHIND, PROC_SOUTH_WALL_CHOICES
13810 ENDPROC
13820 :
13830 REM :::::::::::::::::::::::::
13840 REM :: Grabbed from behind ::
13850 REM :::::::::::::::::::::::::
13860 DEF PROC_GRABBED_FROM_BEHIND
13870 CLS:PROC_ERASE_TEXT_BUFFER
13880 PROC_WRITE_TEXT_BUFFER("Uh oh! As you move towards the south")
13890 PROC_WRITE_TEXT_BUFFER(" wall, something grabs you from behind!"+CHR$(NL))
13900 PROC_WRITE_TEXT_BUFFER("Almost in slow motion, it turns you around......")
13910 PROC_ALL_TEXT
13920 PROC_HIDEOUS_THING
13930 ENDPROC
13940 :
13950 REM :::::::::::::::::::::::::::::
13960 REM :: South wall game actions ::
13970 REM :::::::::::::::::::::::::::::
13980 DEF PROC_SOUTH_WALL_CHOICES
13990 AC$(1)="Door"
14000 AC$(2)="Washstand"
14010 BR = FN_MAKE_CHOICE("What will you search, "+Name$+"?", 2)
14020 ON BR PROC_EXAMINE_DOOR, PROC_EXAMINE_WASHSTAND
14030 ENDPROC
14040 :
14050 REM ::::::::::::::::::
14060 REM :: Examine Door ::
14070 REM ::::::::::::::::::
14080 DEF PROC_EXAMINE_DOOR
14100 CLS:PROC_ERASE_TEXT_BUFFER
14110 PROC_WRITE_TEXT_BUFFER("Yep, this is a door alright, and as")
14120 PROC_WRITE_TEXT_BUFFER(" you are quite aware, it's LOCKED!"+CHR$(NL))
14130 PROC_WRITE_TEXT_BUFFER("After all, it's only "+FN_FORMAT_TIME(TRUE)+"; you")
14140 PROC_WRITE_TEXT_BUFFER(" know you're NOT getting out of here")
14150 PROC_WRITE_TEXT_BUFFER(" until 1 AM!!!"+CHR$(FF))
14160 PROC_ALL_TEXT
14180 ENDPROC
14190 :
14200 REM :::::::::::::::::::::::
14210 REM :: Examine washstand ::
14220 REM :::::::::::::::::::::::
14230 DEF PROC_EXAMINE_WASHSTAND
14250 CLS:PROC_ERASE_TEXT_BUFFER
14260 PROC_WRITE_TEXT_BUFFER("As you turn to examine the washstand,")
14270 PROC_WRITE_TEXT_BUFFER(" you jump back in fright! The stand is")
14280 PROC_WRITE_TEXT_BUFFER(" gone! All that remains is the mirror,")
14290 PROC_WRITE_TEXT_BUFFER(" which is emanating a peculiar greenish")
14300 PROC_WRITE_TEXT_BUFFER(" glow."+CHR$(FF))
14310 PROC_ALL_TEXT
14320 AC$(1)="Look in mirror"
14330 AC$(2)="Check something else"
14340 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
14350 ON BR PROC_LOOK_IN_MIRROR, PROC_EXPLORE_ROOM
14360 ENDPROC
14370 :
14380 REM :::::::::::::::::::::::
14390 REM :: Explore east wall ::
14400 REM :::::::::::::::::::::::
14410 DEF PROC_EAST_WALL
14450 AC$(1)="Check bookcase"
14460 AC$(2)="Examine fireplace"
14470 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
14480 ON BR PROC_EXAMINE_BOOKCASE, PROC_EXAMINE_FIREPLACE
14490 ENDPROC
14500 :
14510 REM ::::::::::::::::::::::
14520 REM :: Examine bookcase ::
14530 REM ::::::::::::::::::::::
14540 DEF PROC_EXAMINE_BOOKCASE
14550 CLS:PROC_ERASE_TEXT_BUFFER
14560 PROC_WRITE_TEXT_BUFFER("The bookcase bespeaks of an owner with")
14570 PROC_WRITE_TEXT_BUFFER(" excellent taste. All of the major authors")
14580 PROC_WRITE_TEXT_BUFFER(" are represented here - Hardy, James,")
14590 PROC_WRITE_TEXT_BUFFER(" Twain, Shakespeare, etc. One large book")
14600 PROC_WRITE_TEXT_BUFFER(" has been pulled most of the way out of")
14610 PROC_WRITE_TEXT_BUFFER(" the bookcase, and seems to be dangerously")
14620 PROC_WRITE_TEXT_BUFFER(" close to falling."+CHR$(FF))
14630 PROC_ALL_TEXT
14640 AC$(1)="Take book"
14650 AC$(2)="Examine fireplace"
14660 AC$(3)="Examine another area"
14670 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 3)
14680 ON BR PROC_TAKE_BOOK, PROC_EXAMINE_FIREPLACE, PROC_EXPLORE_ROOM
14690 ENDPROC
14700 :
14710 REM :::::::::::::::::::
14720 REM :: Take the book ::
14730 REM :::::::::::::::::::
14740 DEF PROC_TAKE_BOOK
14760 H = FN_RND_INT(1, 2)
14770 ON H PROC_TAKE_BOOK_TRAP_DOOR, PROC_READ_BOOK
14780 ENDPROC
14790 :
14800 REM ::::::::::::::::::::::::::::::::
14810 REM :: Taking Book Activates Trap ::
14820 REM ::::::::::::::::::::::::::::::::
14830 DEF PROC_TAKE_BOOK_TRAP_DOOR
14840 CLS:PROC_ERASE_TEXT_BUFFER
14850 PROC_WRITE_TEXT_BUFFER("Gee, just like in the movies. You take")
14860 PROC_WRITE_TEXT_BUFFER(" the book, and a trap door opens up beneath you.")
14870 PROC_WRITE_TEXT_BUFFER(" Trap door?"+CHR$(NL))
14880 PROC_WRITE_TEXT_BUFFER("AAAAAIIIIGGGHH!!!!")
14890 PROC_ALL_TEXT
14900 PROC_DEATH
14910 ENDPROC
14920 :
14930 REM :::::::::::::::
14940 REM :: Read Book ::
14950 REM :::::::::::::::
14960 DEF PROC_READ_BOOK
14970 CLS:PROC_ERASE_TEXT_BUFFER
14980 PROC_WRITE_TEXT_BUFFER("Nice book. The title is *CANNABALISM*")
14990 PROC_WRITE_TEXT_BUFFER(" GUIDE FOR THE GOURMET."+CHR$(NL))
15000 PROC_WRITE_TEXT_BUFFER("Yuck, it's a cookbook! You open it to the table")
15010 PROC_WRITE_TEXT_BUFFER(" of contents..."+CHR$(FF))
15020 PROC_WRITE_TEXT_BUFFER("************* CHAPTER I *************"+CHR$(NL))
15030 PROC_WRITE_TEXT_BUFFER("HOW TO COOK "+CHR$(17)+CHR$(RED)+Name$+CHR$(17)+CHR$(FG%)+" ***"+CHR$(NL))
15040 PROC_WRITE_TEXT_BUFFER("Omigod!!!!!!"+CHR$(NL))
15050 PROC_WRITE_TEXT_BUFFER("You drop the book in fright")
15060 PROC_WRITE_TEXT_BUFFER(" and run over to the fireplace..."+CHR$(FF))
15070 PROC_ALL_TEXT
15080 PROC_EXAMINE_FIREPLACE
15090 ENDPROC
15100 :
15110 REM :::::::::::::::::::::::
15120 REM :: Examine Fireplace ::
15130 REM :::::::::::::::::::::::
15140 DEF PROC_EXAMINE_FIREPLACE
15160 CLS:PROC_ERASE_TEXT_BUFFER
15170 PROC_WRITE_TEXT_BUFFER("This fireplace is huge! It looks like")
15180 PROC_WRITE_TEXT_BUFFER(" you could park a VW bug in it. The")
15190 PROC_WRITE_TEXT_BUFFER(" marble has been meticulously scrubbed.")
15200 PROC_WRITE_TEXT_BUFFER(" Not one trace of soot remains. The logs")
15210 PROC_WRITE_TEXT_BUFFER(" give off a tantalizing pine odor."+CHR$(NL))
15220 PROC_WRITE_TEXT_BUFFER("Conspicuous by its absence is the screen.")
15230 PROC_WRITE_TEXT_BUFFER(" For such a large fireplace, it seems")
15240 PROC_WRITE_TEXT_BUFFER(" rather dangerous to leave the front")
15250 PROC_WRITE_TEXT_BUFFER(" opened up."+CHR$(FF))
15260 PROC_ALL_TEXT
15270 H = FN_RND_INT(1, 2)
15280 ON H PROC_DANGER_SENSE, PROC_IN_FIREPLACE
15290 ENDPROC
15300 :
15310 REM :::::::::::::::::::::
15320 REM :: Sense of danger ::
15330 REM :::::::::::::::::::::
15340 DEF PROC_DANGER_SENSE
15350 CLS:PROC_ERASE_TEXT_BUFFER
15360 PROC_WRITE_TEXT_BUFFER("Sensing danger, you move back to the center of the room......")
15370 PROC_ALL_TEXT
15390 ENDPROC
15400 :
15410 REM :::::::::::::::::::::::::::
15420 REM :: Roasting in fireplace ::
15430 REM :::::::::::::::::::::::::::
15440 DEF PROC_IN_FIREPLACE
15450 CLS:PROC_ERASE_TEXT_BUFFER
15460 PROC_WRITE_TEXT_BUFFER("You seem rather warm. Of course, you")
15470 PROC_WRITE_TEXT_BUFFER(" SHOULD feel warm. Somehow, you're IN")
15480 PROC_WRITE_TEXT_BUFFER(" the fireplace, with a roaring fire")
15490 PROC_WRITE_TEXT_BUFFER(" around you! Frantically, you jump out")
15500 PROC_WRITE_TEXT_BUFFER(" of the fireplace. The pain is too great,")
15510 PROC_WRITE_TEXT_BUFFER(" and you hit the floor, blacking out........")
15520 PROC_ALL_TEXT
15530 PROC_DEATH
15540 ENDPROC
15550 :
15560 REM :::::::::::::::::::::::::::::
15570 REM :: Exploring the west wall ::
15580 REM :::::::::::::::::::::::::::::
15590 DEF PROC_WEST_WALL
15610 CLS:PROC_ERASE_TEXT_BUFFER
15620 PROC_WRITE_TEXT_BUFFER("That's funny. You can get near the")
15630 PROC_WRITE_TEXT_BUFFER(" bed, but an unseen force keeps you")
15640 PROC_WRITE_TEXT_BUFFER(" from examining the nightstand and the")
15650 PROC_WRITE_TEXT_BUFFER(" rocker..."+CHR$(FF))
15660 PROC_ALL_TEXT
15670 AC$(1)="Get in bed"
15680 AC$(2)="Examine another area"
15690 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
15700 ON BR PROC_GET_IN_BED, PROC_EXPLORE_ROOM
15710 ENDPROC
15720 :
15730 REM ::::::::::::::::::
15740 REM :: Examine desk ::
15750 REM ::::::::::::::::::
15760 DEF PROC_EXAMINE_DESK
15780 CLS:PROC_ERASE_TEXT_BUFFER
15790 PROC_WRITE_TEXT_BUFFER("This is quite a fine piece of furniture.")
15800 PROC_WRITE_TEXT_BUFFER(" The desk is made out of solid teak,")
15810 PROC_WRITE_TEXT_BUFFER(" with brass trimmings. An ink well is")
15820 PROC_WRITE_TEXT_BUFFER(" set into the right side, an old quill")
15830 PROC_WRITE_TEXT_BUFFER(" pen next to it. Other than a note next")
15840 PROC_WRITE_TEXT_BUFFER(" to the pen, the desktop is empty,")
15850 PROC_WRITE_TEXT_BUFFER(" except for an antique clock. There are")
15860 PROC_WRITE_TEXT_BUFFER(" two drawers in the desk, both partially")
15870 PROC_WRITE_TEXT_BUFFER(" opened."+CHR$(FF))
15880 PROC_ALL_TEXT
15890 PROC_DESK_CHOICES
15900 ENDPROC
15910 :
15920 REM :::::::::::::::::::::::
15930 REM :: Desk game actions ::
15940 REM :::::::::::::::::::::::
15950 DEF PROC_DESK_CHOICES
15960 AC$(1)="Read note"
15970 AC$(2)="Search drawers"
15980 AC$(3)="Check time"
15990 AC$(4)="Search another area"
16000 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 4)
16010 ON BR PROC_READ_NOTE, PROC_SEARCH_DRAWERS, PROC_CHECK_TIME(TRUE), PROC_SEARCH_ANOTHER_AREA
16020 ENDPROC
16030 :
16040 REM :::::::::::::::::::::::::::::::
16050 REM :: Read the note on the desk ::
16060 REM :::::::::::::::::::::::::::::::
16070 DEF PROC_READ_NOTE
16080 CLS:PROC_ERASE_TEXT_BUFFER
16090 PROC_WRITE_TEXT_BUFFER("**************** NOTE ***************"+CHR$(NL))
16100 PROC_WRITE_TEXT_BUFFER("J. Henderson ... "+CHR$(17)+CHR$(RED)+"DEAD"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(NL))
16110 PROC_WRITE_TEXT_BUFFER("B. Parker    ... "+CHR$(17)+CHR$(RED)+"DEAD"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(NL))
16120 PROC_WRITE_TEXT_BUFFER("C. Davies    ... "+CHR$(17)+CHR$(RED)+"DEAD"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(NL))
16130 PROC_WRITE_TEXT_BUFFER("P. Johnson   ... "+CHR$(17)+CHR$(RED)+"DEAD"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(NL))
16140 PROC_WRITE_TEXT_BUFFER(CHR$(17)+CHR$(YELLOW)+Name$+CHR$(17)+CHR$(FG%)+STRING$(12 - LEN(Name$), CHR$(BLANK))+" ... "+CHR$(17)+CHR$(RED)+"SOON"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(FF))
16150 PROC_WRITE_TEXT_BUFFER("Terrified, you drop the note and run")
16160 PROC_WRITE_TEXT_BUFFER(" towards the window....")
16170 PROC_ALL_TEXT
16180 PROC_INSPECT_WINDOW
16190 ENDPROC
16200 :
16210 REM :::::::::::::::::::::::::::::
16220 REM :: Search the desk drawers ::
16230 REM :::::::::::::::::::::::::::::
16240 DEF PROC_SEARCH_DRAWERS
16250 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
16260 H = FN_RND_INT(1, 2)
16270 ON H PROC_SEVERED_HEAD, PROC_EMPTY_DRAWERS
16280 ENDPROC
16290 :
16300 REM ::::::::::::::::::
16310 REM :: Severed head ::
16320 REM:::::::::::::::::::
16330 DEF PROC_SEVERED_HEAD
16340 CLS:PROC_ERASE_TEXT_BUFFER
16350 PROC_WRITE_TEXT_BUFFER("Opening the drawers reveal - a human")
16360 PROC_WRITE_TEXT_BUFFER(" head! The horror of seeing the severed")
16370 PROC_WRITE_TEXT_BUFFER(" head is too much for your heart. Grabbing")
16380 PROC_WRITE_TEXT_BUFFER(" your chest in agony, you keel over onto the floor!"+CHR$(FF))
16390 PROC_ALL_TEXT
16400 PROC_DEATH
16410 ENDPROC
16420 :
16430 REM ::::::::::::::::::::::::
16440 REM :: Empty desk drawers ::
16450 REM ::::::::::::::::::::::::
16460 DEF PROC_EMPTY_DRAWERS
16470 CLS:PROC_ERASE_TEXT_BUFFER
16480 PROC_WRITE_TEXT_BUFFER("Both drawers are empty...")
16490 PROC_ALL_TEXT
16510 PROC_DESK_CHOICES
16520 ENDPROC
16530 :
16540 REM :::::::::::::::::::::::
16550 REM :: Noise from behind ::
16560 REM :::::::::::::::::::::::
16570 DEF PROC_NOISE_FROM_BEHIND
16580 CLS:PROC_ERASE_TEXT_BUFFER
16590 PROC_WRITE_TEXT_BUFFER("You hear a noise behind you... Quickly")
16600 PROC_WRITE_TEXT_BUFFER(" you turn and walk to the center of")
16610 PROC_WRITE_TEXT_BUFFER(" the room. All seems fine."+CHR$(FF))
16620 PROC_ALL_TEXT
16640 ENDPROC
16650 :
16660 REM ::::::::::::::::::::::::::::::::::::::::
16670 REM :: Search another area of the bedroom ::
16680 REM ::::::::::::::::::::::::::::::::::::::::
16690 DEF PROC_SEARCH_ANOTHER_AREA
16700 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
16710 PROC_EXPLORE_ROOM
16720 ENDPROC
16730 :
16740 REM ::::::::::::::::::::
16750 REM :: Inspect window ::
16760 REM ::::::::::::::::::::
16770 DEF PROC_INSPECT_WINDOW
16780 CLS:PROC_ERASE_TEXT_BUFFER
16790 PROC_WRITE_TEXT_BUFFER("On close inspection of the window, you")
16800 PROC_WRITE_TEXT_BUFFER(" notice that it was badly set. The sash")
16810 PROC_WRITE_TEXT_BUFFER(" is cracked, the paint is peeling, and")
16820 PROC_WRITE_TEXT_BUFFER(" you can feel the wind blowing through")
16830 PROC_WRITE_TEXT_BUFFER(" the numerous cracks."+CHR$(FF))
16840 PROC_ALL_TEXT
16850 H = FN_RND_INT(1, 3)
16860 ON H PROC_WINDOW_ATTACK,PROC_NOTHING_THERE,PROC_NOISE_FROM_BEHIND
16870 ENDPROC
16880 :
16890 REM ::::::::::::::::::::::::::::
16900 REM :: Attacked at the window ::
16910 REM ::::::::::::::::::::::::::::
16920 DEF PROC_WINDOW_ATTACK
16930 CLS:PROC_ERASE_TEXT_BUFFER
16940 PROC_WRITE_TEXT_BUFFER("CRASH!!! Something with incredible")
16950 PROC_WRITE_TEXT_BUFFER(" strength comes hurtling through the")
16960 PROC_WRITE_TEXT_BUFFER(" window. It grabs you and shakes you 'til")
16970 PROC_WRITE_TEXT_BUFFER(" your limp as a dishrag. You hit the")
16980 PROC_WRITE_TEXT_BUFFER(" floor and black out......")
16990 PROC_ALL_TEXT
17000 PROC_DEATH
17010 ENDPROC
17020 :
17030 REM :::::::::::::::::::::::::
17040 REM :: Nothing of interest ::
17050 REM :::::::::::::::::::::::::
17060 DEF PROC_NOTHING_THERE
17070 CLS:PROC_ERASE_TEXT_BUFFER
17080 PROC_WRITE_TEXT_BUFFER("Nothing much of interest here. You")
17090 PROC_WRITE_TEXT_BUFFER(" decide to check the gramophone..."+CHR$(FF))
17100 PROC_ALL_TEXT
17110 PROC_GRAMOPHONE
17120 ENDPROC
17130 :
17140 REM ::::::::::::::::::::::::::::
17150 REM :: Examine the gramophone ::
17160 REM ::::::::::::::::::::::::::::
17170 DEF PROC_GRAMOPHONE
17180 CLS:PROC_ERASE_TEXT_BUFFER
17190 PROC_WRITE_TEXT_BUFFER("What you wouldn't give to own this! The")
17200 PROC_WRITE_TEXT_BUFFER(" gramophone has obviously been given a")
17210 PROC_WRITE_TEXT_BUFFER(" lot of tender-loving care. The rich")
17220 PROC_WRITE_TEXT_BUFFER(" wood of the case and the brass of the")
17230 PROC_WRITE_TEXT_BUFFER(" horn practically sparkle with polish."+CHR$(NL))
17240 PROC_WRITE_TEXT_BUFFER("There is a record on the platter.")
17250 PROC_WRITE_TEXT_BUFFER(" According to the label, it is Tchaikovsky's")
17260 PROC_WRITE_TEXT_BUFFER(" War of 1812 Overture."+CHR$(FF))
17270 PROC_ALL_TEXT
17280 H = FN_RND_INT(1, 2)
17290 ON H PROC_FUNERAL_MARCH, PROC_NO_TIME_TO_WASTE
17300 ENDPROC
17310 :
17320 REM :::::::::::::::::::::::::::::::::::::
17330 REM :: Funeral march on the gramophone ::
17340 REM :::::::::::::::::::::::::::::::::::::
17350 DEF PROC_FUNERAL_MARCH
17360 CLS:PROC_ERASE_TEXT_BUFFER
17370 PROC_WRITE_TEXT_BUFFER("Staring in disbelief, you watch as")
17380 PROC_WRITE_TEXT_BUFFER(" the gramophone starts to crank up by")
17390 PROC_WRITE_TEXT_BUFFER(" itself!!!"+CHR$(NL))
17400 PROC_WRITE_TEXT_BUFFER("From the horn comes the wonderful")
17410 PROC_WRITE_TEXT_BUFFER(" strains of")
17420 PROC_ALL_TEXT
17430 PROC_FUNERAL_MARCH_THEME:PROC_SLEEP(200)
17440 CLS:PROC_ERASE_TEXT_BUFFER
17450 PROC_WRITE_TEXT_BUFFER(" the FUNERAL MARCH???"+CHR$(NL))
17460 PROC_WRITE_TEXT_BUFFER("Quickly, you run back towards the door..."+CHR$(FF))
17470 PROC_ALL_TEXT
17500 ENDPROC
17510 :
17520 REM ::::::::::::::::::::::
17530 REM :: No time to waste ::
17540 REM ::::::::::::::::::::::
17550 DEF PROC_NO_TIME_TO_WASTE
17560 CLS:PROC_ERASE_TEXT_BUFFER
17570 PROC_WRITE_TEXT_BUFFER("You notice it is now ";FN_FORMAT_TIME(TRUE);".")
17580 PROC_WRITE_TEXT_BUFFER(" No time to be playing around..."+CHR$(FF))
17590 PROC_ALL_TEXT
17610 ENDPROC
17620 :
17630 REM ::::::::::::::::::::
17640 REM :: Look in mirror ::
17650 REM ::::::::::::::::::::
17660 DEF PROC_LOOK_IN_MIRROR
17670 H = FN_RND_INT(1, 2)
17680 ON H PROC_POISON_MIST, PROC_ROOM_SPINNING
17690 ENDPROC
17700 :
17710 REM :::::::::::::::::
17720 REM :: Poison mist ::
17730 REM :::::::::::::::::
17740 DEF PROC_POISON_MIST
17750 CLS:PROC_ERASE_TEXT_BUFFER
17760 PROC_WRITE_TEXT_BUFFER("You know, "+Name$+", that wasn't too bright!!!")
17770 PROC_WRITE_TEXT_BUFFER(" The green mist seems to envelop you.")
17780 PROC_WRITE_TEXT_BUFFER(" You feel yourself gagging, choking.")
17790 PROC_WRITE_TEXT_BUFFER(" Mercifully, you slump to the floor...")
17800 PROC_ALL_TEXT
17810 PROC_DEATH
17820 ENDPROC
17830 :
17840 REM ::::::::::::::::::::::
17850 REM :: Room is spinning ::
17860 REM ::::::::::::::::::::::
17870 DEF PROC_ROOM_SPINNING
17880 CLS:PROC_ERASE_TEXT_BUFFER
17890 PROC_WRITE_TEXT_BUFFER("The glow seems to surround you. You")
17900 PROC_WRITE_TEXT_BUFFER(" can't see!!! The room starts to spin,")
17910 PROC_WRITE_TEXT_BUFFER(" and then...")
17920 PROC_ALL_TEXT
17930 PROC_TZ_THEME:PROC_SLEEP(200)
17940 PROC_INITIAL_TEXT
17950 ENDPROC
17960 :
17970 REM :::::::::::::::::::::::::::
17980 REM :: Hit a key to continue ::
17990 REM :::::::::::::::::::::::::::
18000 DEF PROC_CONTINUE
18010 PRINT:PROC_CENTER(FN_RVS(FG%,BG%,"Hit a key to continue"))
18020 Dummy% = FN_HIT_A_KEY:PROC_TEXT_BOUNDING_BOX
18030 ENDPROC
18040 :
18050 REM :::::::::::::::::::::::::::::::::::::::
18060 REM :: Announce the current running time ::
18070 REM :::::::::::::::::::::::::::::::::::::::
18080 DEF PROC_ANNOUNCE_TIME(ti$)
18090 IF NOT LEN(ti$) THEN ti$ = FN_FORMAT_TIME(TRUE)
18100 PROC_WRITE_TEXT_BUFFER(CHR$(17)+CHR$(YELLOW)+ti$+" AM"+CHR$(17)+CHR$(FG%)+"."+CHR$(NL))
18110 ENDPROC
18120 :
18130 REM ::::::::::::::::::::::::::::::::::::
18140 REM :: Check the current running time ::
18150 REM ::::::::::::::::::::::::::::::::::::
18160 DEF PROC_CHECK_TIME(announceTime%)
18170 LOCAL c%, h%, m%, ti$
18180 ti$ = FN_FORMAT_TIME(TRUE):c% = INSTR(ti$, ":"):h% = VAL(LEFT$(ti$, c% - 1)):m% = VAL(RIGHT$(ti$, LEN(ti$) - c%))
18190 IF h% > 12 THEN OneAM% = TRUE:ti$ = STR$(h% - 12) + ":00":ELSE ti$ = STR$(h%) + ":" + STR$(m%)
18200 IF announceTime% AND NOT OneAM% THEN CLS:PROC_ERASE_TEXT_BUFFER:PROC_ANNOUNCE_TIME(ti$):PROC_ALL_TEXT
18210 IF OneAM% THEN PROC_ONE_AM:ELSE IF NOT (SkipEvents% AND SkipRandom%) THEN PROC_RANDOM_EVENT
18220 ENDPROC
18230 :
18240 REM ::::::::::::::::::
18250 REM :: Random Event ::
18260 REM ::::::::::::::::::
18270 DEF PROC_RANDOM_EVENT
18280 H = FN_RND_INT(1, 6):SkipEvents% = TRUE
18290 ON H PROC_IGNORE,PROC_DEATHLY_COLD_HAND,PROC_FEELING_SLEEPY,PROC_SHADOW_AT_WINDOW,PROC_EVIL_VOICE,PROC_NOISE_FROM_BEHIND
18300 ENDPROC
18310 :
18320 REM ::::::::::::::::
18330 REM :: Evil voice ::
18340 REM ::::::::::::::::
18350 DEF PROC_EVIL_VOICE
18360 CLS:PROC_ERASE_TEXT_BUFFER
18370 PROC_WRITE_TEXT_BUFFER("From out of nowhere, yet from all")
18380 PROC_WRITE_TEXT_BUFFER(" around you, comes a voice. With an evil")
18390 PROC_WRITE_TEXT_BUFFER(" laugh, it says, 'Fool, you die soon!'"+CHR$(FF))
18400 PROC_ALL_TEXT
18430 ENDPROC
18440 :
18450 REM ::::::::::::::::::::::::::
18460 REM :: Shadow at the window ::
18470 REM ::::::::::::::::::::::::::
18480 DEF PROC_SHADOW_AT_WINDOW
18490 CLS:PROC_ERASE_TEXT_BUFFER
18500 PROC_WRITE_TEXT_BUFFER("You notice, out of the corner of your")
18510 PROC_WRITE_TEXT_BUFFER(" eye, a shadow pass over the window!!!"+CHR$(FF))
18520 PROC_ALL_TEXT
18530 AC$(1)="Look out window"
18540 AC$(2)="Ignore it"
18550 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
18560 ON BR PROC_LOOK_OUT_WINDOW, PROC_IGNORE_WINDOW_SHADOW
18570 ENDPROC
18580 :
18590 REM :::::::::::::::::::::::::
18600 REM :: Look out the window ::
18610 REM :::::::::::::::::::::::::
18620 DEF PROC_LOOK_OUT_WINDOW
18640 H = FN_RND_INT(1, 3)
18650 ON H PROC_TURN_AROUND, PROC_MOONLIGHT_SHADOW, PROC_MOONLIT_VIEW
18660 ENDPROC
18670 :
18680 REM ::::::::::::::::::::::
18690 REM :: Moonlight shadow ::
18700 REM ::::::::::::::::::::::
18710 DEF PROC_MOONLIGHT_SHADOW
18720 CLS:PROC_ERASE_TEXT_BUFFER
18730 PROC_WRITE_TEXT_BUFFER("It appears a large bird just")
18740 PROC_WRITE_TEXT_BUFFER(" flew close to the window, and the")
18750 PROC_WRITE_TEXT_BUFFER(" moonlight cast a weird shadow. Phew!!!"+CHR$(FF))
18760 PROC_ALL_TEXT
18780 ENDPROC
18790 :
18800 REM ::::::::::::::::::
18810 REM :: Moonlit view ::
18820 REM ::::::::::::::::::
18830 DEF PROC_MOONLIT_VIEW
18840 CLS:PROC_ERASE_TEXT_BUFFER
18850 PROC_WRITE_TEXT_BUFFER("You look out the window, and")
18860 PROC_WRITE_TEXT_BUFFER(" have a wonderful moonlit view of the")
18870 PROC_WRITE_TEXT_BUFFER(" estate. Sort of makes you wish you had")
18880 PROC_WRITE_TEXT_BUFFER(" brought your camera, doesn't it?"+CHR$(FF))
18890 PROC_ALL_TEXT
18920 ENDPROC
18930 :
18940 REM :::::::::::::::::::::::::::::::::
18950 REM :: Ignore shadow at the window ::
18960 REM :::::::::::::::::::::::::::::::::
18970 DEF PROC_IGNORE_WINDOW_SHADOW
18980 H = FN_RND_INT(1, 2)
18990 ON H PROC_GETTING_BRAVE, PROC_NOTHING_AT_WINDOW
19000 ENDPROC
19010 :
19020 REM :::::::::::::::::::
19030 REM :: Getting brave ::
19040 REM :::::::::::::::::::
19050 DEF PROC_GETTING_BRAVE
19060 CLS:PROC_ERASE_TEXT_BUFFER
19070 PROC_WRITE_TEXT_BUFFER("Getting brave, "+Name$+"?"+CHR$(FF))
19080 PROC_ALL_TEXT
19110 ENDPROC
19120 :
19130 REM :::::::::::::::::::::::
19140 REM :: Nothing at window ::
19150 REM :::::::::::::::::::::::
19160 DEF PROC_NOTHING_AT_WINDOW
19170 CLS:PROC_ERASE_TEXT_BUFFER
19180 PROC_WRITE_TEXT_BUFFER("Oh well, maybe there wasn't anything")
19190 PROC_WRITE_TEXT_BUFFER(" there, anyways..."+CHR$(NL))
19200 PROC_WRITE_TEXT_BUFFER("OR WAS THERE???"+CHR$(FF))
19210 PROC_ALL_TEXT
19240 ENDPROC
19250 :
19260 REM ::::::::::::::::::::
19270 REM :: Feeling sleepy ::
19280 REM ::::::::::::::::::::
19290 DEF PROC_FEELING_SLEEPY
19300 CLS:PROC_ERASE_TEXT_BUFFER
19310 PROC_WRITE_TEXT_BUFFER("You suddenly feel quite sleepy,")
19320 PROC_WRITE_TEXT_BUFFER(" and seem to be moving towards the bed..."+CHR$(FF))
19330 PROC_ALL_TEXT
19340 PROC_GET_IN_BED
19350 ENDPROC
19360 :
19370 REM :::::::::::::::::::::::
19380 REM :: Deathly-cold hand ::
19390 REM :::::::::::::::::::::::
19400 DEF PROC_DEATHLY_COLD_HAND
19410 CLS:PROC_ERASE_TEXT_BUFFER
19420 PROC_WRITE_TEXT_BUFFER("All of a sudden, you jump as you feel a")
19430 PROC_WRITE_TEXT_BUFFER(" deathly-cold hand grab you from behind!"+CHR$(FF))
19440 PROC_ALL_TEXT
19450 PROC_DEATHLY_COLD_HAND_CHOICES
19460 ENDPROC
19470 :
19480 REM ::::::::::::::::::::::::::::::::::::::
19490 REM :: Deathly-cold hand gaming actions ::
19500 REM ::::::::::::::::::::::::::::::::::::::
19510 DEF PROC_DEATHLY_COLD_HAND_CHOICES
19520 AC$(1)="Turn around & look"
19530 AC$(2)="Run!"
19540 AC$(3)="Ignore it"
19550 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 3)
19560 ON BR PROC_TURN_AROUND, PROC_RUN, PROC_IGNORE
19570 ENDPROC
19580 :
19590 REM ::::::::::::::::::::::::::
19600 REM :: Turn around and look ::
19610 REM ::::::::::::::::::::::::::
19620 DEF PROC_TURN_AROUND
19630 H = FN_RND_INT(1, 4)
19640 ON H PROC_NOBODY_BEHIND_YOU, PROC_NOBODY_BEHIND_YOU, PROC_HIDEOUS_THING, PROC_NOBODY_BEHIND_YOU
19650 ENDPROC
19660 :
19670 REM :::::::::::::::::::::::::::::
19680 REM :: Hideous thing to behold ::
19690 REM :::::::::::::::::::::::::::::
19700 DEF PROC_HIDEOUS_THING
19710 CLS:PROC_ERASE_TEXT_BUFFER
19720 PROC_WRITE_TEXT_BUFFER("As you turn around, you are confronted")
19730 PROC_WRITE_TEXT_BUFFER(" with the most gruesome creature")
19740 PROC_WRITE_TEXT_BUFFER(" imaginable. In fact, it is so hideous that")
19750 PROC_WRITE_TEXT_BUFFER(" your blood pressure skyrockets. The")
19760 PROC_WRITE_TEXT_BUFFER(" strain is much too much for your heart,")
19770 PROC_WRITE_TEXT_BUFFER(" and with a gasp of pain, you collapse")
19780 PROC_WRITE_TEXT_BUFFER(" to the floor."+CHR$(FF))
19790 PROC_ALL_TEXT
19800 PROC_DEATH
19810 ENDPROC
19820 :
19830 REM ::::::::::::
19840 REM :: Ignore ::
19850 REM ::::::::::::
19860 DEF PROC_IGNORE
19890 ENDPROC
19900 :
19910 REM ::::::::::::::::
19920 REM :: Run for it ::
19930 REM ::::::::::::::::
19940 DEF PROC_RUN
19950 CLS:PROC_ERASE_TEXT_BUFFER
19960 PROC_WRITE_TEXT_BUFFER("You're frozen to the spot!!!"+CHR$(FF))
19970 PROC_ALL_TEXT
19980 PROC_DEATHLY_COLD_HAND_CHOICES
19990 ENDPROC
20000 :
20010 REM :::::::::::::::::::::::
20020 REM :: Nobody behind you ::
20030 REM :::::::::::::::::::::::
20040 DEF PROC_NOBODY_BEHIND_YOU
20050 CLS:PROC_ERASE_TEXT_BUFFER
20060 PROC_WRITE_TEXT_BUFFER("You turn around, but no one's there!"+CHR$(FF))
20070 PROC_ALL_TEXT
20090 ENDPROC
20100 :
20110 REM :::::::::::::::::
20120 REM :: One O'Clock ::
20130 REM :::::::::::::::::
20140 DEF PROC_ONE_AM
20150 CLS:PROC_ERASE_TEXT_BUFFER
20160 PROC_WRITE_TEXT_BUFFER("It's now 1 AM!!!"+CHR$(NL))
20170 PROC_WRITE_TEXT_BUFFER("The door to the room suddenly flies")
20180 PROC_WRITE_TEXT_BUFFER(" open, and in walks the old man. He's")
20190 PROC_WRITE_TEXT_BUFFER(" apparently startled to see you (still)")
20200 PROC_WRITE_TEXT_BUFFER(" standing there. With a nod of his head,")
20210 PROC_WRITE_TEXT_BUFFER(" he motions you to follow him. You do")
20220 PROC_WRITE_TEXT_BUFFER(" so, out of the room, down the stairs, and")
20230 PROC_WRITE_TEXT_BUFFER(" back to the parlor, where you first")
20240 PROC_WRITE_TEXT_BUFFER(" started tonight."+CHR$(FF))
20250 PROC_WRITE_TEXT_BUFFER("Well, "+Name$+", sit down!!"+CHR$(NL))
20260 PROC_WRITE_TEXT_BUFFER("Good show, good show! I'm glad someone")
20270 PROC_WRITE_TEXT_BUFFER(" has finally survived. Looks like you've")
20280 PROC_WRITE_TEXT_BUFFER(" broken the curse of that damned room.")
20290 PROC_WRITE_TEXT_BUFFER(" I've got your check right here. Don't")
20300 PROC_WRITE_TEXT_BUFFER(" worry, it's certified, all on the up and up."+CHR$(FF))
20310 PROC_ALL_TEXT
20320 AC$(1) = "Yes"
20330 AC$(2) = "No"
20340 BR = FN_MAKE_CHOICE("Would you care to join me for tea, "+Name$+", before you go?", 2)
20350 ON BR PROC_TREACHERY, PROC_SURVIVED
20360 ENDPROC
20370 :
20380 REM :::::::::::::::::::::::::
20390 REM :: Survived the ordeal ::
20400 REM :::::::::::::::::::::::::
20410 DEF PROC_SURVIVED
20420 CLS:PROC_ERASE_TEXT_BUFFER
20430 PROC_WRITE_TEXT_BUFFER("Well, fine then. Take care, "+Name$+", and thank")
20440 PROC_WRITE_TEXT_BUFFER(" you so much for your help."+CHR$(FF))
20450 PROC_WRITE_TEXT_BUFFER("As you walk away from the estate, check")
20460 PROC_WRITE_TEXT_BUFFER(" clutched tightly in hand, you wonder if")
20470 PROC_WRITE_TEXT_BUFFER(" it's all been worth it."+CHR$(NL))
20480 PROC_WRITE_TEXT_BUFFER("Anyways, you've survived, you are")
20490 PROC_WRITE_TEXT_BUFFER(" "+CHR$(17)+CHR$(GREEN)+"$1,000,000"+CHR$(17)+CHR$(FG%)+" wealthier,")
20500 PROC_WRITE_TEXT_BUFFER(" and the curse of DEATH HOUSE is no more."+CHR$(NL))
20510 PROC_ALL_TEXT
20520 PROC_WERE_IN_THE_MONEY_THEME:PROC_SLEEP(250)
20530 CLS:PROC_ERASE_TEXT_BUFFER
20540 PROC_WRITE_TEXT_BUFFER("All of a sudden, you hear a piercing")
20550 PROC_WRITE_TEXT_BUFFER(" scream coming from the house. Maybe you")
20560 PROC_WRITE_TEXT_BUFFER(" didn't break the curse after all."+CHR$(NL))
20570 PROC_WRITE_TEXT_BUFFER("Perhaps - you were just - "+CHR$(17)+CHR$(GREEN)+"LUCKY"+CHR$(17)+CHR$(FG%)+"!!!"+CHR$(NL))
20580 PROC_ALL_TEXT
20590 Won% = TRUE
20600 ENDPROC
20610 :
20620 REM :::::::::::::::
20630 REM :: Treachery ::
20640 REM :::::::::::::::
20650 DEF PROC_TREACHERY
20660 CLS:PROC_ERASE_TEXT_BUFFER
20670 PROC_WRITE_TEXT_BUFFER("As you sit there, sipping your tea,")
20680 PROC_WRITE_TEXT_BUFFER(" you realize the old man is grinning")
20690 PROC_WRITE_TEXT_BUFFER(" madly at you."+CHR$(NL))
20700 PROC_WRITE_TEXT_BUFFER("The room starts to spin,")
20710 PROC_WRITE_TEXT_BUFFER(" and you fall to the floor, teacup still")
20720 PROC_WRITE_TEXT_BUFFER(" clutched in hand...")
20730 PROC_ALL_TEXT
20740 PROC_GOOD_EVENING_FRIENDS_THEME:PROC_SLEEP(250)
20750 PROC_DEATH
20760 ENDPROC
20770 :
20780 REM :::::::::::
20790 REM :: Death ::
20800 REM :::::::::::
20810 DEF PROC_DEATH
20820 CLS:PROC_ERASE_TEXT_BUFFER
20830 PROC_WRITE_TEXT_BUFFER("You hear, off in the distance, a")
20840 PROC_WRITE_TEXT_BUFFER(" door being opened, followed by furtive")
20850 PROC_WRITE_TEXT_BUFFER(" footsteps. With the strength only a")
20860 PROC_WRITE_TEXT_BUFFER(" dying man could muster, you manage to")
20870 PROC_WRITE_TEXT_BUFFER(" open your eyes. The old man is now")
20880 PROC_WRITE_TEXT_BUFFER(" standing over you, sadly shaking his")
20890 PROC_WRITE_TEXT_BUFFER(" head. You try to speak, but can only")
20900 PROC_WRITE_TEXT_BUFFER(" gasp in pain. Slowly, the vision of the")
20910 PROC_WRITE_TEXT_BUFFER(" old man dims, and with a final heavy")
20920 PROC_WRITE_TEXT_BUFFER(" sigh, you pass from this world."+CHR$(FF))
20930 PROC_ALL_TEXT
20940 PROC_FLASH_SCREEN(8, 20)
20950 PROC_DEFAULT_COLORS
20960 CLS:PROC_ERASE_TEXT_BUFFER
20970 PROC_WRITE_TEXT_BUFFER("Suddenly you find yourself standing")
20980 PROC_WRITE_TEXT_BUFFER(" back by the bed. Astonished, you feel")
20990 PROC_WRITE_TEXT_BUFFER(" a great sense of relief wash over you."+CHR$(NL))
21000 PROC_WRITE_TEXT_BUFFER("It must have all been a dream. You're")
21010 PROC_WRITE_TEXT_BUFFER(" alive - you've survived, and soon you'll")
21020 PROC_WRITE_TEXT_BUFFER(" be a millionaire! Your reverie gets cut")
21030 PROC_WRITE_TEXT_BUFFER(" short when you see a ghastly creature")
21040 PROC_WRITE_TEXT_BUFFER(" walk out of the wall in front of you!"+CHR$(NL))
21050 PROC_WRITE_TEXT_BUFFER("Joy turns to panic, and you reach for")
21060 PROC_WRITE_TEXT_BUFFER(" the doorknob, but your hand passes on")
21070 PROC_WRITE_TEXT_BUFFER(" through it. You turn slowly around,")
21080 PROC_WRITE_TEXT_BUFFER(" and come face to face with a roomful")
21090 PROC_WRITE_TEXT_BUFFER(" of ghosts. You notice that they no")
21100 PROC_WRITE_TEXT_BUFFER(" longer seem to eye you malevolently,")
21110 PROC_WRITE_TEXT_BUFFER(" but appear to be... just waiting."+CHR$(FF))
21120 PROC_WRITE_TEXT_BUFFER("Now the full horror of it all dawns on")
21130 PROC_WRITE_TEXT_BUFFER(" you. You HAVE DIED; you're just like")
21140 PROC_WRITE_TEXT_BUFFER(" them, and like them, for all eternity,")
21150 PROC_WRITE_TEXT_BUFFER(" you'll keep watch here, waiting for")
21160 PROC_WRITE_TEXT_BUFFER(" another fool to enter..."+CHR$(NL))
21170 PROC_WRITE_TEXT_BUFFER(STRING$((CW% - 16) DIV 2, CHR$(BLANK))+CHR$(17)+CHR$(RED)+"DEATH HOUSE"+CHR$(17)+CHR$(FG%)+"!"+CHR$(FF))
21180 PROC_ALL_TEXT
21190 PROC_FUNERAL_MARCH_THEME
21200 Lost% = TRUE
21210 ENDPROC
21220 :
21230 REM :::::::::::::::::
21240 REM ::  Game Over  ::
21250 REM :::::::::::::::::
21260 DEF PROC_GAME_OVER
21270 LOCAL co%, m%, msg$
21280 m% = VAL(FN_FORMAT_TIME(FALSE)) - 1200:IF m% > 100 THEN m% = m% - 40
21290 CLS:PROC_ERASE_TEXT_BUFFER
21300 IF Lost% THEN co% = RED:msg$ = "So sorry! You lost.":ELSE co% = GREEN:msg$ = "Congratulations! You won."
21310 PROC_WRITE_TEXT_BUFFER(STRING$(FN_CENTER(msg$), CHR$(BLANK))+CHR$(17)+CHR$(co%)+msg$+CHR$(17)+CHR$(FG%)+CHR$(NL))
21320 PROC_WRITE_TEXT_BUFFER(Name$+", you survived for "+STR$(m%)+" minutes."+CHR$(FF))
21330 PROC_ALL_TEXT
21340 ENDPROC
21350 :
21360 REM :::::::::::::::::::::::
21370 REM :: Play Another Game ::
21380 REM :::::::::::::::::::::::
21390 DEF FN_PLAY_AGAIN
21400 AC$(1) = "No"
21410 AC$(2) = "Yes"
21420 := FN_MAKE_CHOICE("Would you like to play again?", 2)
21430 :
21440 REM :::::::::::::::::
21450 REM :: Say Goodbye ::
21460 REM :::::::::::::::::
21470 DEF PROC_GOODBYE(game$)
21480 PROC_HIDE_CURSOR
21490 CLS:PROC_FULL_CENTER_TEXT("So long and thank you for playing...")
21500 FOR i% = 0 TO FN_CENTER(game$) - 1:PRINTTAB(0, CH% DIV 2 + 2)STRING$(i%, " ")CHR$(17)CHR$(i% MOD 7 + 1)game$:PROC_SLEEP(20):NEXT i%
21510 PROC_DEFAULT_COLORS
21520 PROC_SHOW_CURSOR
21530 ENDPROC
21540 :
21550 REM ::::::::::::::::::::
21560 REM ::   Setup Game   ::
21570 REM ::::::::::::::::::::
21580 DEF PROC_SETUP
21590 BLACK = 0:RED = 1:GREEN = 2:YELLOW = 3:BLUE = 4:MAGENTA = 5:CYAN = 6:WHITE = 7
21600 B_VERT = 140:B_HORZ = 141:B_UR = 142:B_UL = 143:B_DL = 144:B_DR = 145
21610 BLANK = 32:SKULL = 42:C_TAB = 9:NL = 10:CR = 13:FF = 14:DASH = 45:DOT = 46:QST = 63:EX = 33
21620 MAXINT% = &3B9AC9FF:GameName$ = "DEATH-HOUSE":FG% = WHITE:BG% = BLACK
21630 IF SY$ = "A" THEN CW% = FN_getByteVDP(&13):CH% = FN_getByteVDP(&14):ELSE CW% = 40:CH% = 24
21640 TX_SIZE% = 2048
21650 DIM AC$(6), TX TX_SIZE%
21660 TK = TIME:PROC_SLEEP(100):TK = TIME - TK:REM CALIBRATE TIME TICKS
21670 BX$ = CHR$(B_UR) + CHR$(B_HORZ) + CHR$(B_UL) + CHR$(B_VERT) + CHR$(B_DL) + CHR$(B_HORZ) + CHR$(B_DR) + CHR$(B_VERT)
21680 PROC_REDEFINE_CHARS
21690 ENDPROC
21700 :
21710 REM ::::::::::::::::::::::::::::::::::::::
21720 REM :: Display all text buffer contents ::
21730 REM ::::::::::::::::::::::::::::::::::::::
21740 DEF PROC_ALL_TEXT
21750 PROC_WORD_WRAP(1, 1, CW% - 2, CH% - 2, FN_READ_TEXT_BUFFER(0))
21760 ENDPROC
21770 :
21780 REM :::::::::::::::::::::::::::::::::::::::::::::
21790 REM :: Is character position outside of width? ::
21800 REM :::::::::::::::::::::::::::::::::::::::::::::
21810 DEF FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x%)
21820 := (x% >= (ux% + width%))
21830 :
21840 REM :::::::::::::::::::::::::::::::::::::
21850 REM :: Is it a special character code? ::
21860 REM :::::::::::::::::::::::::::::::::::::
21870 DEF FN_IS_SPECIAL(ch%)
21880 := (ch% = BLANK OR ch% = NL OR ch% = C_TAB OR ch% = CR OR ch% = FF OR ch% = DOT OR ch% = DASH OR ch% = QST OR ch% = EX)
21890 :
21900 REM ::::::::::::::::::::::::::::::::::::
21910 REM :: Handle special character codes ::
21920 REM ::::::::::::::::::::::::::::::::::::
21930 DEF PROC_HANDLE_SPECIAL(ux%, uy%, width%, height%, ch%)
21940 LOCAL c%, delay%, i%, n%, newPage%, x%, y%
21950 c% = 0:n% = 1:delay% = 0:newPage% = FALSE:x% = POS:y% = VPOS
21960 IF BLANK = ch% THEN delay% = 30
21970 IF DOT = ch% OR EX = ch% THEN delay% = 100
21980 IF QST = ch% THEN delay% = 150
21990 IF C_TAB = ch% AND NOT FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x% + 1) THEN c% = BLANK:n% = 2
22000 IF FF = ch% THEN newPage% = TRUE
22010 IF NL = ch% OR CR = ch% OR FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x%) THEN x% = ux%:y% = y% + 1:IF y% > (height% - 2) THEN newPage% = TRUE
22020 IF newPage% THEN PRINT:PROC_CONTINUE:y% = uy%:x% = ux%
22030 FOR i% = 1 TO n%
22040   PRINT TAB(x%, y%);
22050   IF c% > 0 THEN PRINT CHR$(c%);
22060   PROC_SLEEP(delay%)
22070 NEXT i%
22080 ENDPROC
22090 :
22100 REM ::::::::::::::::::::::::::::::::::::::
22110 REM :: Display text in word-wrapped box ::
22120 REM ::::::::::::::::::::::::::::::::::::::
22130 DEF PROC_WORD_WRAP(ux%, uy%, width%, height%, text$)
22140 LOCAL ch%, i%, len%, special%, word$, wordLen%, wordStart%, x%, y%
22150 PROC_TEXT_BOUNDING_BOX
22160 len% = LEN(text$):wordStart% = 0:wordLen% = 0:word$ = ""
22170 x% = ux%:y% = uy%:REM Begin from specified starting row
22180 FOR i% = 1 TO len%
22190   IF (wordStart% = 0) THEN wordStart% = i%
22200   ch% = ASC(MID$(text$, i%, 1)):special% = FN_IS_SPECIAL(ch%)
22210   IF (i% = len% OR special%) THEN word$ = MID$(text$, wordStart%, 1 + i% - wordStart% + (i% = len%) * -1):wordLen% = LEN(word$)
22220   IF (wordLen% > (width% - x% + ux%)) THEN y% = y% + 1:x% = ux%
22230   IF (wordLen% > 0) THEN PRINT TAB(x%, y%);word$;:wordStart% = 0:wordLen% = 0:y% = VPOS:x% = POS:PROC_HANDLE_SPECIAL(ux%, uy%, width%, height%, ASC(RIGHT$(word$, 1))):y% = VPOS:x% = POS
22240 NEXT i%
22250 ENDPROC
22260 :
22270 REM :::::::::::::::::::::::::::::::::::
22280 REM :: Draw bounding box around text ::
22290 REM :::::::::::::::::::::::::::::::::::
22300 DEF PROC_TEXT_BOUNDING_BOX
22310 PROC_CLOCKWISE_BOX(0, 0, CW%, CH%, CYAN, TRUE)
22320 PROC_DEFAULT_COLORS
22330 ENDPROC
22340 :
22350 REM :::::::::::::::::::::::::::::::
22360 REM :: Prompt for a story action ::
22370 REM :::::::::::::::::::::::::::::::
22380 DEF FN_MAKE_CHOICE(prompt$, count%)
22390 LOCAL bg%, br%, c%, fg%, i%, ni%, ti, y%
22400 PROC_EMPTY_KEYBOARD_BUFFER
22410 CLS
22420 PRINT prompt$:PRINT
22430 ni% = OneAM% OR Won% OR Lost%:br% = (ni%) * -1 + (NOT ni%) *-FN_RND_INT(1, count%):c% = 0:y% = VPOS:ti = TIME:fg% = FG%:bg%= BG%
22440 REPEAT:REM DISPLAY POSSIBLE CHOICES AND GET SELECTION
22450   FOR i% = 1 TO count%
22460     PRINT TAB(0, y% + i% - 1);
22470     IF br% = i% THEN fg% = YELLOW:PRINT FN_RVS(fg%, bg%, AC$(i%)):REM MOVE REVERSE-VIDEO TO NEXT CHOICE
22480     IF br% <> i% THEN fg% = FG%:PRINT CHR$(17)CHR$(bg%+128)CHR$(17)CHR$(fg%)AC$(i%)
22490   NEXT i%
22500   c% = INKEY(1000)
22510   IF c% = DOWN THEN br% = br% MOD count% + 1:REM TEST FOR CURSOR DOWN
22520   IF c% = UP THEN br% = (count% + br% - 2) MOD count% + 1:REM TEST FOR CURSOR UP
22530 UNTIL c% = 13 OR c% = TRUE
22540 PROC_DEFAULT_COLORS
22550 := br%:REM CHOICE SELECTED IS CURRENT BRANCH (i.e. br%)
22560 :
22570 REM ::::::::::::::::::::::::::::::::::::::::::
22580 REM :: Flash the screen with various colors ::
22590 REM ::::::::::::::::::::::::::::::::::::::::::
22600 DEF PROC_FLASH_SCREEN(count%, delay%)
22610 LOCAL i%
22620 FOR i% = 1 TO count%
22630   COLOUR 128+i%:COLOUR BLACK:CLS
22640   PROC_SLEEP(delay%)
22650 NEXT i%
22660 PROC_DEFAULT_COLORS
22670 ENDPROC
22680 :
22690 REM :::::::::::::::::::::::::::::::::::
22700 REM :: Erase contents of text buffer ::
22710 REM :::::::::::::::::::::::::::::::::::
22720 DEF PROC_ERASE_TEXT_BUFFER
22730 TX_Pointer% = 0:REM Reset Pointer to text buffer
22740 $TX = STRING$(TX_SIZE%, CHR$(CR))
22750 ENDPROC
22760 :
22770 REM :::::::::::::::::::::::::::::::::::
22780 REM :: Write text to the text buffer ::
22790 REM :::::::::::::::::::::::::::::::::::
22800 DEF PROC_WRITE_TEXT_BUFFER(text$)
22810 LOCAL i%
22820 IF TX_Pointer% + LEN(text$) > TX_SIZE% THEN ERROR 19, "String too long"
22830 FOR i% = 1 TO LEN(text$)
22840   $(TX + TX_Pointer%) = MID$(text$, i%, 1)
22850   TX_Pointer% = (TX_Pointer% + 1)
22860 NEXT i%
22870 ENDPROC
22880 :
22890 REM ::::::::::::::::::::::::::::::::::::::
22900 REM :: Read text out of the text buffer ::
22910 REM ::::::::::::::::::::::::::::::::::::::
22920 DEF FN_READ_TEXT_BUFFER(pos%)
22930 LOCAL n%, r$
22940 IF pos% > TX_SIZE% THEN ERROR 14, "Reference array incorrect"
22950 r$ = $(TX + pos%)
22960 := r$
22970 :
22980 REM :::::::::::::::::::::
22990 REM :: Retrieve a byte ::
23000 REM :: register value  ::
23010 REM :: from VDP        ::
23020 REM :::::::::::::::::::::
23030 DEF FN_getByteVDP(var%):A% = &A0:L% = var%:= USR(&FFF4)
23040 :
23050 REM ::::::::::::::::::::::::::::::::::::
23060 REM :: Set the time of the simple RTC ::
23070 REM ::::::::::::::::::::::::::::::::::::
23080 DEF FN_SET_TIME(hours%,minutes%,seconds%)
23090 TIME = hours% * 360000 + minutes% * 6000 + seconds% * 100
23100 := TIME
23110 :
23120 REM :::::::::::::::::::::::::::::
23130 REM :: Format time as a String ::
23140 REM :::::::::::::::::::::::::::::
23150 DEF FN_FORMAT_TIME(addColons%)
23160 LOCAL hours%,minutes%,seconds%,time%,r$
23170 r$ = "":time% = TIME
23180 hours% = time% DIV 360000
23190 minutes% = (time% - hours% * 360000) DIV 6000
23200 seconds% = (time% - hours% * 360000 - minutes% * 6000) DIV 100
23210 r$ = FN_PAD_NUMBER(hours%, 2):IF addColons% THEN r$ = r$ + ":"
23220 r$ = r$ + FN_PAD_NUMBER(minutes%, 2):REM IF addColons% THEN r$ = r$ + ":"
23230 REM r$ = r$ + FN_PAD_NUMBER(seconds%, 2)
23240 := r$
23250 :
23260 REM :::::::::::::::::::::::::::
23270 REM ::   Bounded time ticks  ::
23280 REM :::::::::::::::::::::::::::
23290 DEF FN_INT_TIME:= TIME MOD MAXINT%
23300 :
23310 REM :::::::::::::::::::::::
23320 REM :: Has time reached  ::
23330 REM :: target seconds?   ::
23340 REM :::::::::::::::::::::::
23350 DEF FN_IS_TIME(sec%, prevSec%, targetSec%):= (sec% MOD targetSec% = 0 AND sec% <> prevSec%)
23360 :
23370 REM :::::::::::::::::::::::::::::::::::::::
23380 REM :: Pause execution of the program    ::
23390 REM :: for a number of ticks (1/100) sec ::
23400 REM :::::::::::::::::::::::::::::::::::::::
23410 DEF PROC_SLEEP(hundredth_seconds%):LOCAL t:hundredth_seconds% = hundredth_seconds% + (hundredth_seconds% < 0) * -hundredth_seconds%:t = TIME:REPEAT UNTIL ((TIME - t) > hundredth_seconds%):ENDPROC
23420 :
23430 REM ::::::::::::::::::::::::::::::::
23440 REM :: Return TRUE when random    ::
23450 REM :: value is below given value ::
23460 REM ::::::::::::::::::::::::::::::::
23470 DEF FN_RND_PCT(n%):=RND(1) <= (n% / 100):REM Returns TRUE or FALSE
23480 :
23490 REM :::::::::::::::::::::::::::::::::
23500 REM :: Random Integer Within Range ::
23510 REM :::::::::::::::::::::::::::::::::
23520 DEF FN_RND_INT(lo%, hi%):= (RND(1) * (hi% - lo% + 1)) + lo%
23530 :
23540 REM ::::::::::::::::::::::
23550 REM ::   To Uppercase   ::
23560 REM ::::::::::::::::::::::
23570 DEF FN_TO_UPPER(ch$):LOCAL ch%:ch% = ASC(ch$):ch$ = CHR$(ch% + 32 * (ch% >= 97 AND ch% <= 122)):=ch$
23580 :
23590 REM ::::::::::::::::::::::
23600 REM ::   To Lowercase   ::
23610 REM ::::::::::::::::::::::
23620 DEF FN_TO_LOWER(ch$):LOCAL ch%:ch% = ASC(ch$):ch$ = CHR$(ch% - 32 * (ch% >= 65 AND ch% <= 90)):=ch$
23630 :
23640 REM ::::::::::::::::::::::::::::::::
23650 REM :: Prepend Zeroes To A Number ::
23660 REM ::::::::::::::::::::::::::::::::
23670 DEF FN_PAD_NUMBER(val%, len%)
23680 LOCAL s$
23690 s$ = STR$(val%)
23700 := STRING$(len% - LEN(s$), "0") + s$
23710 :
23720 REM :::::::::::::::::::::::::::
23730 REM :: Hit a key to continue ::
23740 REM :::::::::::::::::::::::::::
23750 DEF FN_HIT_A_KEY
23760 LOCAL c%, ex%, ti
23770 c% = 0:ex% = FALSE:ti = TIME
23780 REPEAT
23790   c% = INKEY(10):IF c% > 0 OR 1000 < (TIME - ti) THEN ex% = TRUE
23800 UNTIL ex%
23810 := c%
23820 :
23830 REM :::::::::::::::::::::::::::::::::::
23840 REM :: Display Text In Reverse Video ::
23850 REM :::::::::::::::::::::::::::::::::::
23860 DEF FN_RVS(fg%, bg%, text$):= CHR$(17)+CHR$(128+fg%)+CHR$(17)+CHR$(bg%)+text$+CHR$(17)+CHR$(fg%)+CHR$(17)+CHR$(128+bg%)
23870 :
23880 REM :::::::::::::::::::::
23890 REM ::   Center text   ::
23900 REM :::::::::::::::::::::
23910 DEF FN_CENTER(text$):= (CW% - LEN(text$)) DIV 2
23920 :
23930 REM :::::::::::::::::::::
23940 REM :: Right-trim text ::
23950 REM :::::::::::::::::::::
23960 DEF FN_RTRIM(text$)
23970 LOCAL trim%
23980 REPEAT
23990   trim% = FALSE
24000   IF ASC(LEFT$(text$, LEN(text$) - 1)) = BLANK THEN text$ = LEFT$(text$, LEN(text$) - 1):trim% = TRUE
24010 UNTIL NOT trim%
24020 := text$
24030 :
24040 REM :::::::::::::::::::::::::
24050 REM :: Prompt For Response ::
24060 REM :::::::::::::::::::::::::
24070 DEF FN_PROMPT(x%, y%, text$, default$)
24080 LOCAL r$
24090 PRINT TAB(x%, y%)text$;" ";default$:PRINT TAB(x% + LEN(text$) + 1, y%);
24100 r$ = GET$:r$ = FN_TO_UPPER(r$):IF r$ = CHR$(13) THEN r$ = default$
24110 := r$
24120 :
24130 REM :::::::::::::::::::::::::::::
24140 REM ::  Display Centered Text  ::
24150 REM :::::::::::::::::::::::::::::
24160 DEF PROC_CENTER(text$)
24170 LOCAL i%, n%, l%
24180 l% = 0
24190 FOR i% = 1 TO LEN(text$)
24200   IF ASC(MID$(text$, i%, 1)) >= BLANK THEN l% = l% + 1
24210 NEXT i%
24220 n% = FN_CENTER(STRING$(l%, CHR$(BLANK)))
24230 VDU 31, n%, VPOS
24240 FOR i% = 1 TO LEN(text$)
24250   VDU ASC(MID$(text$, i%, 1))
24260 NEXT i%
24270 ENDPROC
24280 :
24290 REM :::::::::::::::::::::::::::::::::
24300 REM :: Center text both vertically ::
24310 REM :: and horizontally            ::
24320 REM :::::::::::::::::::::::::::::::::
24330 DEF PROC_FULL_CENTER_TEXT(text$):VDU 31,FN_CENTER(text$), CH% DIV 2:PRINT text$;:ENDPROC
24340 :
24350 REM :::::::::::::::::::::::::::
24360 REM :: Empty Keyboard Buffer ::
24370 REM :::::::::::::::::::::::::::
24380 DEF PROC_EMPTY_KEYBOARD_BUFFER
24390 REPEAT UNTIL INKEY(0) = -1
24400 ENDPROC
24410 :
24420 REM ::::::::::::::::::::::::::::
24430 REM :: Disable display of the ::
24440 REM :: cursor on the screen   ::
24450 REM ::::::::::::::::::::::::::::
24460 DEF PROC_HIDE_CURSOR:VDU 23,1,0;0;0;0;:ENDPROC
24470 :
24480 REM ::::::::::::::::::::::::::::
24490 REM :: Enable display of the  ::
24500 REM :: cursor on the screen   ::
24510 REM ::::::::::::::::::::::::::::
24520 DEF PROC_SHOW_CURSOR:VDU 23,1,1;0;0;0;:ENDPROC
24530 :
24540 REM ::::::::::::::::::::::::::::
24550 REM :: Restore Default Colors ::
24560 REM ::::::::::::::::::::::::::::
24570 DEF PROC_DEFAULT_COLORS
24580 COLOUR 128+BG%:COLOUR FG%
24590 ENDPROC
24600 :
24610 REM :::::::::::::::::::::::::::::::::::::::::::
24620 REM ::  Calculate type index of a clockwise  ::
24630 REM ::  position on a box's perimeter        ::
24640 REM :::::::::::::::::::::::::::::::::::::::::::
24650 DEF FN_CLOCKWISE_BOX_SIDE_INDEX(pos%, width%, height%)
24660 REM 0 = UPPER_LEFT_CORNER, 1 = UPPER_MIDDLE, 2 = UPPER_RIGHT_CORNER, 3 = MIDDLE_RIGHT, 4 = LOWER_RIGHT_CORNER, 5 = LOWER_MIDDLE, 6 = LOWER_LEFT_CORNER, 7 = MIDDLE_LEFT
24670 LOCAL r%
24680 r% = (pos% > 0 AND pos% < width% - 1) * -1 + (pos% = width% - 1) * -2 + (pos% >= width% AND pos% < width% + height% - 2) * -3 + (pos% = width% + height% - 2) * -4
24690 r% = r% + (pos% > width% + height% - 2 AND pos% < 2 * width% + height% - 3) * -5 + (pos% = 2 * width% + height% - 3) * -6 + (pos% > 2 * width% + height% - 3) * -7
24700 :=r%
24710 :
24720 REM ::::::::::::::::::::::::::
24730 REM ::  Draw Box Clockwise  ::
24740 REM ::::::::::::::::::::::::::
24750 DEF PROC_CLOCKWISE_BOX(ux%, uy%, width%, height%, color%, clear%)
24760 LOCAL aq%, bq%, ch%, i%, p%, x%, y%
24770 aq% = width% + height% - 2:bq% = aq% + width%:p% = bq% + height% - 2
24780 FOR i% = 0 TO p% - 1
24790   x% = (i% < width%) * -i% + (i% > (width%-1) AND i% < aq%) * -(width%-1) + (i% >= aq% AND i% < bq%) * (i% - (bq% - 1)) + (i% >= bq%) * 0
24800   y% = (i% < width%) * 0 + (i% > (width%-1) AND i% < aq%) * -(i% - (width%-1)) + (i% >= aq% AND i% < bq%) * -(height%-1) + (i% >= bq%) * -((height%-2) - (i% - bq%))
24810   ch% = ASC(MID$(BX$, FN_CLOCKWISE_BOX_SIDE_INDEX(i%, width%, height%) + 1, 1))
24820   PROC_PLOT(ux% + x%, uy% + y%, ch%, color%)
24830 NEXT i%
24840 IF clear% THEN FOR i% = uy% + 1 TO uy% + height% - 2:PRINT TAB(ux%+1,i%)STRING$(width%-2, " "):NEXT i%
24850 ENDPROC
24860 :
24870 REM :::::::::::::::::::::::::::
24880 REM :: Plot a single colored ::
24890 REM :: character to screen   ::
24900 REM :::::::::::::::::::::::::::
24910 DEF PROC_PLOT(x%, y%, ch%, co%)
24920 VDU 31, x%, y%
24930 VDU 17, co%, ch%
24940 ENDPROC
24950 :
24960 REM ::::::::::::::
24970 REM :: Suspense ::
24980 REM ::::::::::::::
24990 DEF PROC_SUSPENSE(count%, ch%, delay%)
25000 LOCAL i%
25010 PRINT TAB(FN_CENTER(STRING$(count%, CHR$(ch%))), VPOS);
25020 FOR i% = 1 TO count%
25030   PRINT CHR$(ch%);:PROC_SLEEP(delay%)
25040 NEXT i%
25050 PRINT
25060 ENDPROC
25070 :
25080 REM :::::::::::::::::::::::::::::::::
25090 REM :: Enter letters from keyboard ::
25100 REM :::::::::::::::::::::::::::::::::
25110 DEF FN_PROMPT_FOR_LETTERS(length%)
25120 LOCAL c$, r$
25130 r$ = "":PROC_EMPTY_KEYBOARD_BUFFER:PROC_SHOW_CURSOR
25140 REPEAT
25150   c$ = INKEY$(10)
25160   IF ((c$ = CHR$(127) OR c$ = CHR$(8)) AND LEN(r$) > 0) THEN r$ = LEFT$(r$, LEN(r$) - 1):PRINT CHR$(127);
25170   IF ((c$ >= "A" AND c$ <= "Z") OR (c$ >= "a" AND c$ <= "z") OR (c$ = CHR$(BLANK))) AND LEN(r$) < length% THEN r$ = r$ + c$:PRINT c$;
25180 UNTIL c$ = CHR$(CR) AND LEN(r$) <= length%
25190 PROC_HIDE_CURSOR
25200 :=r$
25210 :
25220 REM :::::::::::::::::::::::
25230 REM :: Play Simple Sound ::
25240 REM :::::::::::::::::::::::
25250 DEF PROC_SOUND(index%, duration%)
25260 LOCAL constant%
25270 constant% = 12.2
25280 SOUND 1, -12, index% * constant%, duration%
25290 ENDPROC
25300 :
25310 REM :::::::::::::::::::::::::
25320 REM :: Play Musical Phrase ::
25330 REM :::::::::::::::::::::::::
25340 DEF PROC_PLAY(notes$)
25350 LOCAL d%, j%, l%, p%
25360 l% = LEN(notes$) DIV 3
25370 FOR j% = 1 TO l% STEP 2
25380   p% = VAL(MID$(notes$, 3 * (j% - 1) + 1, 3)):d% = VAL(MID$(notes$, 3 * (j% - 1) + 4, 3))
25390   IF p% >= 0 THEN SOUND 1, -13, p%, d%:ELSE SOUND 1, 0, 0, d%
25400   SOUND 1, 0, p%, 1:REM Stacatto the currently playing sound
25410 NEXT j%
25420 ENDPROC
25430 :
25440 REM :::::::::::::::::::::::::::
25450 REM ::  Funeral March Theme  ::
25460 REM :::::::::::::::::::::::::::
25470 DEF PROC_FUNERAL_MARCH_THEME
25480 PROC_PLAY("089008089006089002089008101006097002097006089002089006089002089024"):REM PITCH,DURATION
25490 ENDPROC
25500 :
25510 REM ::::::::::::::::::::::::::::::::::
25520 REM ::  Good Evening Friends Theme  ::
25530 REM ::::::::::::::::::::::::::::::::::
25540 DEF PROC_GOOD_EVENING_FRIENDS_THEME
25550 PROC_PLAY("149008157008149008161024"):REM PITCH,DURATION
25560 ENDPROC
25570 :
25580 REM :::::::::::::::::::::
25590 REM ::  ITHOTMK Theme  ::
25600 REM :::::::::::::::::::::
25610 DEF PROC_ITHOTMK_THEME
25620 LOCAL notes$:REM PITCH,DURATION
25630 notes$ = "097004105004109004117004125004109004125008121004105004121008117004101004117008"
25640 notes$ = notes$ + "097004105004109004117004125004109004125004145004137004125004109004125004137016"
25650 PROC_PLAY(notes$)
25660 ENDPROC
25670 :
25680 REM ::::::::::::::::
25690 REM ::  TZ Theme  ::
25700 REM ::::::::::::::::
25710 DEF PROC_TZ_THEME
25720 PROC_PLAY("181004185004181004165004181004185004181004165004181004185004181004165004"):REM PITCH,DURATION
25730 ENDPROC
25740 :
25750 REM ::::::::::::::::::::::::::::::::
25760 REM ::  We're In The Money Theme  ::
25770 REM ::::::::::::::::::::::::::::::::
25780 DEF PROC_WERE_IN_THE_MONEY_THEME
25790 PROC_PLAY("157004169006157002161004169012"):REM PITCH,DURATION
25800 ENDPROC
25810 :
25820 REM ::::::::::::::::::::::::::::::
25830 REM :: Define Custom Characters ::
25840 REM ::::::::::::::::::::::::::::::
25850 DEF PROC_REDEFINE_CHARS
25860 VDU 23,SKULL,0,189,126,90,126,165,24,0:REM SKULL(7)
25870 VDU 23,B_VERT,24,24,24,24,24,24,24,24:REM VERTICAL(4)
25880 VDU 23,B_HORZ,0,0,0,255,255,0,0,0:REM HORIZONTAL(4)
25890 VDU 23,B_UR,0,0,0,7,15,28,24,24:REM UPRIGHT C(4)
25900 VDU 23,B_UL,0,0,0,224,240,56,24,24:REM UPLEFT C(4)
25910 VDU 23,B_DL,24,24,56,240,224,0,0,0:REM DOWNLEFT C(4)
25920 VDU 23,B_DR,24,24,28,15,7,0,0,0:REM DOWN RIGHT C(4)
25930 ENDPROC
25940 :
25950 REM ::::::::::::::::::::::::::::::
25960 REM ::  Error Handling Routine  ::
25970 REM ::::::::::::::::::::::::::::::
25980 DEF PROC_HANDLE_ERROR
25990 IF ERR <> 17 THEN PROC_DEFAULT_COLORS:PROC_SHOW_CURSOR:PRINT:REPORT:PRINT" @line #";ERL:STOP
26000 ENDPROC
