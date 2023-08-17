10000 REM :::::::::::::::::::::::::::::::::::::::::::::::
10010 REM :: DEATH HOUSE FOR AgonLight (BBC BASIC v3)  ::
10020 REM :::::::::::::::::::::::::::::::::::::::::::::::
10030 REM :: 20230816: Version 1.1                     ::
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
10340 REM ::::::::::::::::::::
10350 REM ::   Setup Game   ::
10360 REM ::::::::::::::::::::
10370 DEF PROC_SETUP
10380 BLACK = 0:RED = 1:GREEN = 2:YELLOW = 3:BLUE = 4:MAGENTA = 5:CYAN = 6:WHITE = 7
10390 B_VERT = 140:B_HORZ = 141:B_UR = 142:B_UL = 143:B_DL = 144:B_DR = 145
10400 BLANK = 32:SKULL = 42:C_TAB = 9:NL = 10:CR = 13:FF = 12:DASH = 45:DOT = 46:QST = 63:EX = 33
10410 MAXINT% = &3B9AC9FF:GameName$ = "DEATH-HOUSE":FG% = WHITE:BG% = BLACK
10420 IF SY$ = "A" THEN CW% = FN_getByteVDP(&13):CH% = FN_getByteVDP(&14) - 1:ELSE CW% = 40:CH% = 24
10430 TX_SIZE% = 255
10440 DIM AC$(6), TX TX_SIZE%
10450 TK = TIME:PROC_SLEEP(100):TK = TIME - TK:REM CALIBRATE TIME TICKS
10460 BX$ = CHR$(B_UR) + CHR$(B_HORZ) + CHR$(B_UL) + CHR$(B_VERT) + CHR$(B_DL) + CHR$(B_HORZ) + CHR$(B_DR) + CHR$(B_VERT)
10470 PROC_REDEFINE_CHARS
10480 ENDPROC
10490 :
10500 REM :::::::::::::::
10510 REM :: Main loop ::
10520 REM :::::::::::::::
10530 DEF PROC_MAIN_LOOP
10540 REPEAT
10550   IF NOT (Won% OR Lost%) THEN PROC_CHECK_TIME(FALSE)
10560   IF NOT (Won% OR Lost%) THEN PROC_COMMON_CHOICES
10570   SkipEvents% = FALSE
10580 UNTIL Won% OR Lost%
10590 ENDPROC
10600 :
10610 REM :::::::::::::
10620 REM :: Welcome ::
10630 REM :::::::::::::
10640 DEF PROC_WELCOME
10650 CLS
10660 PRINT TAB(0, 4);:PROC_CENTER(CHR$(17)+CHR$(FG%)+"* "+CHR$(17)+CHR$(RED)+"DEATH HOUSE"+CHR$(17)+CHR$(FG%)+" *")
10670 PRINT TAB(0, 6);:PROC_CENTER("by ")
10680 PRINT TAB(0, 8);:PROC_CENTER("Mark S. Boucher")
10690 PROC_CLOCKWISE_BOX((CW% - 17) DIV 2, 3, 17, 7, CYAN)
10700 PROC_ITHOTMK_THEME:PROC_SLEEP(120)
10710 PROC_DEFAULT_COLORS
10720 ENDPROC
10730 :
10740 REM ::::::::::::::
10750 REM :: New game ::
10760 REM ::::::::::::::
10770 DEF PROC_NEW_GAME
10780 Won% = FALSE:Lost% = FALSE:SkipEvents% = TRUE:SkipRandom% = FALSE:OneAM% = FALSE
10790 ENDPROC
10800 :
10810 REM ::::::::::::::::::
10820 REM :: Who are you? ::
10830 REM ::::::::::::::::::
10840 DEF PROC_IDENTIFY_YOURSELF
10850 CLS:PRINT TAB(0, 16)"What is your first name? ";
10860 Name$ = FN_RTRIM(FN_PROMPT_FOR_LETTERS(12)):REM Cap the length of name to be 12 characters
10870 ENDPROC
10880 :
10890 REM ::::::::::::::::::::::::::::::
10900 REM :: Skip Introduction Prompt ::
10910 REM ::::::::::::::::::::::::::::::
10920 DEF FN_SKIP_INTRO
10930 LOCAL message$, r$, y%
10940 message$ = "Skip introduction? (Y/N)":y% = VPOS + 1
10950 PROC_EMPTY_KEYBOARD_BUFFER
10960 REPEAT
10970   r$ = FN_PROMPT(0, y%, message$, "")
10980   IF "0" = r$ THEN SkipRandom% = (NOT SkipRandom%):PROC_SOUND(197 + SkipRandom% * 96, 12)
10990 UNTIL INSTR("YN", r$) <> 0
11000 := r$
11010 :
11020 REM ::::::::::::::::::
11030 REM :: Introduction ::
11040 REM ::::::::::::::::::
11050 DEF PROC_INTRO
11060 CLS:PROC_DISPLAY_TEXT("11")
11070 ENDPROC
11080 :
11090 REM ::::::::::::::::::::::::::
11100 REM :: Initial text of game ::
11110 REM ::::::::::::::::::::::::::
11120 DEF PROC_INITIAL_TEXT
11130 TIME = FN_SET_TIME(12,0,0)
11140 CLS:PROC_DISPLAY_TEXT("27")
11150 ENDPROC
11160 :
11170 REM :::::::::::::::::::::::::::::::::::
11180 REM :: Common available game actions ::
11190 REM :::::::::::::::::::::::::::::::::::
11200 DEF PROC_COMMON_CHOICES
11210 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
11220 AC$(1)="Check the time"
11230 AC$(2)="Sleep"
11240 AC$(3)="Examine the room"
11250 BR = FN_MAKE_CHOICE("Well, "+Name$+", what will you do now?", 3)
11260 ON BR PROC_CHECK_TIME(TRUE), PROC_GET_IN_BED, PROC_EXPLORE_ROOM
11270 ENDPROC
11280 :
11290 REM ::::::::::::::::
11300 REM :: Get in bed ::
11310 REM ::::::::::::::::
11320 DEF PROC_GET_IN_BED
11330 CLS:PROC_DISPLAY_TEXT("52")
11340 H = FN_RND_INT(1, 4)
11350 ON H PROC_HARD_PILLOW,PROC_STRANGLED,PROC_NOT_SLEEPY,PROC_GET_OUT_OF_MY_BED
11360 ENDPROC
11370 :
11380 REM :::::::::::::::::
11390 REM :: Hard pillow ::
11400 REM :::::::::::::::::
11410 DEF PROC_HARD_PILLOW
11420 CLS:PROC_DISPLAY_TEXT("88")
11430 AC$(1)="Grab item"
11440 AC$(2)="Ignore it"
11450 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
11460 ON BR PROC_ITEM_UNDER_PILLOW,PROC_GET_OUT_OF_MY_BED
11470 ENDPROC
11480 :
11490 REM :::::::::::::::::::::::
11500 REM :: Item under pillow ::
11510 REM :::::::::::::::::::::::
11520 DEF PROC_ITEM_UNDER_PILLOW
11530 H = FN_RND_INT(1, 2)
11540 ON H PROC_BRICK_UNDER_PILLOW,PROC_SNAKE_UNDER_PILLOW
11550 ENDPROC
11560 :
11570 REM ::::::::::::::::::::::::
11580 REM :: Brick under pillow ::
11590 REM ::::::::::::::::::::::::
11600 DEF PROC_BRICK_UNDER_PILLOW
11610 CLS:PROC_DISPLAY_TEXT("39")
11620 PROC_NOT_SLEEPY
11630 ENDPROC
11640 :
11650 REM :::::::::::::::::::::::::::::
11660 REM :: Snake underneath pillow ::
11670 REM :::::::::::::::::::::::::::::
11680 DEF PROC_SNAKE_UNDER_PILLOW
11690 CLS:PROC_DISPLAY_TEXT("47")
11700 PROC_DEATH
11710 ENDPROC
11720 :
11730 REM ::::::::::::::::::::::
11740 REM :: Strangled in bed ::
11750 REM ::::::::::::::::::::::
11760 DEF PROC_STRANGLED
11770 CLS:PROC_DISPLAY_TEXT("92")
11780 PROC_DEATH
11790 ENDPROC
11800 :
11810 REM ::::::::::::::::
11820 REM :: Not sleepy ::
11830 REM ::::::::::::::::
11840 DEF PROC_NOT_SLEEPY
11850 CLS:PROC_DISPLAY_TEXT("16")
11860 ENDPROC
11870 :
11880 REM :::::::::::::::::::::::
11890 REM :: Get out of my bed ::
11900 REM :::::::::::::::::::::::
11910 DEF PROC_GET_OUT_OF_MY_BED
11920 CLS:PROC_DISPLAY_TEXT("41")
11930 ENDPROC
11940 :
11950 REM :::::::::::::::::::::
11960 REM :: Explore bedroom ::
11970 REM :::::::::::::::::::::
11980 DEF PROC_EXPLORE_ROOM
11990 AC$(1)="North wall"
12000 AC$(2)="South wall"
12010 AC$(3)="East wall"
12020 AC$(4)="West wall"
12030 BR = FN_MAKE_CHOICE("Which part of the bedroom, "+Name$+"?", 4)
12040 ON BR PROC_NORTH_WALL, PROC_SOUTH_WALL, PROC_EAST_WALL, PROC_WEST_WALL
12050 ENDPROC
12060 :
12070 REM ::::::::::::::::::::::::
12080 REM :: Explore north wall ::
12090 REM ::::::::::::::::::::::::
12100 DEF PROC_NORTH_WALL
12110 CLS:PROC_DISPLAY_TEXT("04")
12120 H = FN_RND_INT(1, 3)
12130 ON H PROC_PIT,PROC_DISTRACTED,PROC_NORTH_WALL_CHOICES
12140 ENDPROC
12150 :
12160 REM :::::::::::::::::::
12170 REM :: Fall into pit ::
12180 REM :::::::::::::::::::
12190 DEF PROC_PIT
12200 CLS:PROC_DISPLAY_TEXT("38")
12210 PROC_DEATH
12220 ENDPROC
12230 :
12240 REM ::::::::::::::::
12250 REM :: Distracted ::
12260 REM ::::::::::::::::
12270 DEF PROC_DISTRACTED
12280 CLS:PROC_DISPLAY_TEXT("73")
12290 PROC_EXPLORE_ROOM
12300 ENDPROC
12310 :
12320 REM :::::::::::::::::::::::::::::
12330 REM :: North wall game actions ::
12340 REM :::::::::::::::::::::::::::::
12350 DEF PROC_NORTH_WALL_CHOICES
12360 AC$(1)="Desk"
12370 AC$(2)="Window"
12380 AC$(3)="Gramophone"
12390 BR = FN_MAKE_CHOICE("Which area first, "+Name$+"?", 3)
12400 ON BR PROC_EXAMINE_DESK, PROC_INSPECT_WINDOW, PROC_GRAMOPHONE
12410 ENDPROC
12420 :
12430 REM ::::::::::::::::::::::::
12440 REM :: Explore south wall ::
12450 REM ::::::::::::::::::::::::
12460 DEF PROC_SOUTH_WALL
12470 CLS:PROC_DISPLAY_TEXT("13")
12480 H = FN_RND_INT(1, 4)
12490 ON H PROC_SOUTH_WALL_CHOICES, PROC_SOUTH_WALL_CHOICES, PROC_GRABBED_FROM_BEHIND, PROC_SOUTH_WALL_CHOICES
12500 ENDPROC
12510 :
12520 REM :::::::::::::::::::::::::
12530 REM :: Grabbed from behind ::
12540 REM :::::::::::::::::::::::::
12550 DEF PROC_GRABBED_FROM_BEHIND
12560 CLS:PROC_DISPLAY_TEXT("49")
12570 PROC_HIDEOUS_THING
12580 ENDPROC
12590 :
12600 REM :::::::::::::::::::::::::::::
12610 REM :: South wall game actions ::
12620 REM :::::::::::::::::::::::::::::
12630 DEF PROC_SOUTH_WALL_CHOICES
12640 AC$(1)="Door"
12650 AC$(2)="Washstand"
12660 BR = FN_MAKE_CHOICE("What will you search, "+Name$+"?", 2)
12670 ON BR PROC_EXAMINE_DOOR, PROC_EXAMINE_WASHSTAND
12680 ENDPROC
12690 :
12700 REM ::::::::::::::::::
12710 REM :: Examine Door ::
12720 REM ::::::::::::::::::
12730 DEF PROC_EXAMINE_DOOR
12740 CLS:PROC_DISPLAY_TEXT("65")
12750 ENDPROC
12760 :
12770 REM :::::::::::::::::::::::
12780 REM :: Examine washstand ::
12790 REM :::::::::::::::::::::::
12800 DEF PROC_EXAMINE_WASHSTAND
12810 CLS:PROC_DISPLAY_TEXT("31")
12820 AC$(1)="Look in mirror"
12830 AC$(2)="Check something else"
12840 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
12850 ON BR PROC_LOOK_IN_MIRROR, PROC_EXPLORE_ROOM
12860 ENDPROC
12870 :
12880 REM :::::::::::::::::::::::
12890 REM :: Explore east wall ::
12900 REM :::::::::::::::::::::::
12910 DEF PROC_EAST_WALL
12920 AC$(1)="Check bookcase"
12930 AC$(2)="Examine fireplace"
12940 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
12950 ON BR PROC_EXAMINE_BOOKCASE, PROC_EXAMINE_FIREPLACE
12960 ENDPROC
12970 :
12980 REM ::::::::::::::::::::::
12990 REM :: Examine bookcase ::
13000 REM ::::::::::::::::::::::
13010 DEF PROC_EXAMINE_BOOKCASE
13020 CLS:PROC_DISPLAY_TEXT("46")
13030 AC$(1)="Take book"
13040 AC$(2)="Examine fireplace"
13050 AC$(3)="Examine another area"
13060 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 3)
13070 ON BR PROC_TAKE_BOOK, PROC_EXAMINE_FIREPLACE, PROC_EXPLORE_ROOM
13080 ENDPROC
13090 :
13100 REM :::::::::::::::::::
13110 REM :: Take the book ::
13120 REM :::::::::::::::::::
13130 DEF PROC_TAKE_BOOK
13140 H = FN_RND_INT(1, 2)
13150 ON H PROC_TAKE_BOOK_TRAP_DOOR, PROC_READ_BOOK
13160 ENDPROC
13170 :
13180 REM ::::::::::::::::::::::::::::::::
13190 REM :: Taking Book Activates Trap ::
13200 REM ::::::::::::::::::::::::::::::::
13210 DEF PROC_TAKE_BOOK_TRAP_DOOR
13220 CLS:PROC_DISPLAY_TEXT("19")
13230 PROC_DEATH
13240 ENDPROC
13250 :
13260 REM :::::::::::::::
13270 REM :: Read Book ::
13280 REM :::::::::::::::
13290 DEF PROC_READ_BOOK
13300 CLS:PROC_DISPLAY_TEXT("71")
13310 PROC_EXAMINE_FIREPLACE
13320 ENDPROC
13330 :
13340 REM :::::::::::::::::::::::
13350 REM :: Examine Fireplace ::
13360 REM :::::::::::::::::::::::
13370 DEF PROC_EXAMINE_FIREPLACE
13380 CLS:PROC_DISPLAY_TEXT("84")
13390 H = FN_RND_INT(1, 2)
13400 ON H PROC_DANGER_SENSE, PROC_IN_FIREPLACE
13410 ENDPROC
13420 :
13430 REM :::::::::::::::::::::
13440 REM :: Sense of danger ::
13450 REM :::::::::::::::::::::
13460 DEF PROC_DANGER_SENSE
13470 CLS:PROC_DISPLAY_TEXT("03")
13480 ENDPROC
13490 :
13500 REM :::::::::::::::::::::::::::
13510 REM :: Roasting in fireplace ::
13520 REM :::::::::::::::::::::::::::
13530 DEF PROC_IN_FIREPLACE
13540 CLS:PROC_DISPLAY_TEXT("55")
13550 PROC_DEATH
13560 ENDPROC
13570 :
13580 REM :::::::::::::::::::::::::::::
13590 REM :: Exploring the west wall ::
13600 REM :::::::::::::::::::::::::::::
13610 DEF PROC_WEST_WALL
13620 CLS:PROC_DISPLAY_TEXT("32")
13630 AC$(1)="Get in bed"
13640 AC$(2)="Examine another area"
13650 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
13660 ON BR PROC_GET_IN_BED, PROC_EXPLORE_ROOM
13670 ENDPROC
13680 :
13690 REM ::::::::::::::::::
13700 REM :: Examine desk ::
13710 REM ::::::::::::::::::
13720 DEF PROC_EXAMINE_DESK
13730 CLS:PROC_DISPLAY_TEXT("53")
13740 PROC_DESK_CHOICES
13750 ENDPROC
13760 :
13770 REM :::::::::::::::::::::::
13780 REM :: Desk game actions ::
13790 REM :::::::::::::::::::::::
13800 DEF PROC_DESK_CHOICES
13810 AC$(1)="Read note"
13820 AC$(2)="Search drawers"
13830 AC$(3)="Check time"
13840 AC$(4)="Search another area"
13850 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 4)
13860 ON BR PROC_READ_NOTE, PROC_SEARCH_DRAWERS, PROC_CHECK_TIME(TRUE), PROC_SEARCH_ANOTHER_AREA
13870 ENDPROC
13880 :
13890 REM :::::::::::::::::::::::::::::::
13900 REM :: Read the note on the desk ::
13910 REM :::::::::::::::::::::::::::::::
13920 DEF PROC_READ_NOTE
13930 CLS:PROC_DISPLAY_TEXT("99")
13940 PROC_INSPECT_WINDOW
13950 ENDPROC
13960 :
13970 REM :::::::::::::::::::::::::::::
13980 REM :: Search the desk drawers ::
13990 REM :::::::::::::::::::::::::::::
14000 DEF PROC_SEARCH_DRAWERS
14010 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
14020 H = FN_RND_INT(1, 2)
14030 ON H PROC_SEVERED_HEAD, PROC_EMPTY_DRAWERS
14040 ENDPROC
14050 :
14060 REM ::::::::::::::::::
14070 REM :: Severed head ::
14080 REM:::::::::::::::::::
14090 DEF PROC_SEVERED_HEAD
14100 CLS:PROC_DISPLAY_TEXT("48")
14110 PROC_DEATH
14120 ENDPROC
14130 :
14140 REM ::::::::::::::::::::::::
14150 REM :: Empty desk drawers ::
14160 REM ::::::::::::::::::::::::
14170 DEF PROC_EMPTY_DRAWERS
14180 CLS:PROC_DISPLAY_TEXT("06")
14190 PROC_DESK_CHOICES
14200 ENDPROC
14210 :
14220 REM :::::::::::::::::::::::
14230 REM :: Noise from behind ::
14240 REM :::::::::::::::::::::::
14250 DEF PROC_NOISE_FROM_BEHIND
14260 CLS:PROC_DISPLAY_TEXT("21")
14270 ENDPROC
14280 :
14290 REM ::::::::::::::::::::::::::::::::::::::::
14300 REM :: Search another area of the bedroom ::
14310 REM ::::::::::::::::::::::::::::::::::::::::
14320 DEF PROC_SEARCH_ANOTHER_AREA
14330 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
14340 PROC_EXPLORE_ROOM
14350 ENDPROC
14360 :
14370 REM ::::::::::::::::::::
14380 REM :: Inspect window ::
14390 REM ::::::::::::::::::::
14400 DEF PROC_INSPECT_WINDOW
14410 CLS:PROC_DISPLAY_TEXT("12")
14420 H = FN_RND_INT(1, 3)
14430 ON H PROC_WINDOW_ATTACK,PROC_NOTHING_THERE,PROC_NOISE_FROM_BEHIND
14440 ENDPROC
14450 :
14460 REM ::::::::::::::::::::::::::::
14470 REM :: Attacked at the window ::
14480 REM ::::::::::::::::::::::::::::
14490 DEF PROC_WINDOW_ATTACK
14500 CLS:PROC_DISPLAY_TEXT("40")
14510 PROC_DEATH
14520 ENDPROC
14530 :
14540 REM :::::::::::::::::::::::::
14550 REM :: Nothing of interest ::
14560 REM :::::::::::::::::::::::::
14570 DEF PROC_NOTHING_THERE
14580 CLS:PROC_DISPLAY_TEXT("18")
14590 PROC_GRAMOPHONE
14600 ENDPROC
14610 :
14620 REM ::::::::::::::::::::::::::::
14630 REM :: Examine the gramophone ::
14640 REM ::::::::::::::::::::::::::::
14650 DEF PROC_GRAMOPHONE
14660 CLS:PROC_DISPLAY_TEXT("61")
14670 H = FN_RND_INT(1, 2)
14680 ON H PROC_FUNERAL_MARCH, PROC_NO_TIME_TO_WASTE
14690 ENDPROC
14700 :
14710 REM :::::::::::::::::::::::::::::::::::::
14720 REM :: Funeral march on the gramophone ::
14730 REM :::::::::::::::::::::::::::::::::::::
14740 DEF PROC_FUNERAL_MARCH
14750 CLS:PROC_DISPLAY_TEXT("2A")
14760 PROC_FUNERAL_MARCH_THEME:PROC_SLEEP(200)
14770 CLS:PROC_DISPLAY_TEXT("2B")
14780 ENDPROC
14790 :
14800 REM ::::::::::::::::::::::
14810 REM :: No time to waste ::
14820 REM ::::::::::::::::::::::
14830 DEF PROC_NO_TIME_TO_WASTE
14840 CLS:PROC_DISPLAY_TEXT("94")
14850 ENDPROC
14860 :
14870 REM ::::::::::::::::::::
14880 REM :: Look in mirror ::
14890 REM ::::::::::::::::::::
14900 DEF PROC_LOOK_IN_MIRROR
14910 H = FN_RND_INT(1, 2)
14920 ON H PROC_POISON_MIST, PROC_ROOM_SPINNING
14930 ENDPROC
14940 :
14950 REM :::::::::::::::::
14960 REM :: Poison mist ::
14970 REM :::::::::::::::::
14980 DEF PROC_POISON_MIST
14990 CLS:PROC_DISPLAY_TEXT("66")
15000 PROC_DEATH
15010 ENDPROC
15020 :
15030 REM ::::::::::::::::::::::
15040 REM :: Room is spinning ::
15050 REM ::::::::::::::::::::::
15060 DEF PROC_ROOM_SPINNING
15070 CLS:PROC_DISPLAY_TEXT("07")
15080 PROC_TZ_THEME:PROC_SLEEP(200)
15090 PROC_INITIAL_TEXT
15100 ENDPROC
15110 :
15120 REM :::::::::::::::::::::::::::
15130 REM :: Hit a key to continue ::
15140 REM :::::::::::::::::::::::::::
15150 DEF PROC_CONTINUE
15160 PRINT:PROC_CENTER(FN_RVS(FG%,BG%,"Hit a key to continue"))
15170 Dummy% = FN_HIT_A_KEY
15180 ENDPROC
15190 :
15200 REM :::::::::::::::::::::::::::::::::::::::
15210 REM :: Announce the current running time ::
15220 REM :::::::::::::::::::::::::::::::::::::::
15230 DEF PROC_ANNOUNCE_TIME(ti$)
15240 IF NOT LEN(ti$) THEN ti$ = FN_FORMAT_TIME(TRUE)
15250 PROC_WRITE_TEXT_BUFFER(CHR$(17)+CHR$(YELLOW)+ti$+" AM"+CHR$(17)+CHR$(FG%)+"."+CHR$(NL))
15260 ENDPROC
15270 :
15280 REM ::::::::::::::::::::::::::::::::::::
15290 REM :: Check the current running time ::
15300 REM ::::::::::::::::::::::::::::::::::::
15310 DEF PROC_CHECK_TIME(announceTime%)
15320 LOCAL c%, h%, m%, ti$
15330 ti$ = FN_FORMAT_TIME(TRUE):c% = INSTR(ti$, ":"):h% = VAL(LEFT$(ti$, c% - 1)):m% = VAL(RIGHT$(ti$, LEN(ti$) - c%))
15340 IF h% > 12 THEN OneAM% = TRUE:ti$ = STR$(h% - 12) + ":00":ELSE ti$ = STR$(h%) + ":" + STR$(m%)
15350 IF announceTime% AND NOT OneAM% THEN CLS:PROC_ERASE_TEXT_BUFFER:PROC_ANNOUNCE_TIME(ti$):PROC_ALL_TEXT
15360 IF OneAM% THEN PROC_ONE_AM:ELSE IF NOT (SkipEvents% AND SkipRandom%) THEN PROC_RANDOM_EVENT
15370 ENDPROC
15380 :
15390 REM ::::::::::::::::::
15400 REM :: Random Event ::
15410 REM ::::::::::::::::::
15420 DEF PROC_RANDOM_EVENT
15430 H = FN_RND_INT(1, 6):SkipEvents% = TRUE
15440 ON H PROC_IGNORE,PROC_DEATHLY_COLD_HAND,PROC_FEELING_SLEEPY,PROC_SHADOW_AT_WINDOW,PROC_EVIL_VOICE,PROC_NOISE_FROM_BEHIND
15450 ENDPROC
15460 :
15470 REM ::::::::::::::::
15480 REM :: Evil voice ::
15490 REM ::::::::::::::::
15500 DEF PROC_EVIL_VOICE
15510 CLS:PROC_DISPLAY_TEXT("37")
15520 ENDPROC
15530 :
15540 REM ::::::::::::::::::::::::::
15550 REM :: Shadow at the window ::
15560 REM ::::::::::::::::::::::::::
15570 DEF PROC_SHADOW_AT_WINDOW
15580 CLS:PROC_DISPLAY_TEXT("76")
15590 AC$(1)="Look out window"
15600 AC$(2)="Ignore it"
15610 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
15620 ON BR PROC_LOOK_OUT_WINDOW, PROC_IGNORE_WINDOW_SHADOW
15630 ENDPROC
15640 :
15650 REM :::::::::::::::::::::::::
15660 REM :: Look out the window ::
15670 REM :::::::::::::::::::::::::
15680 DEF PROC_LOOK_OUT_WINDOW
15690 H = FN_RND_INT(1, 3)
15700 ON H PROC_TURN_AROUND, PROC_MOONLIGHT_SHADOW, PROC_MOONLIT_VIEW
15710 ENDPROC
15720 :
15730 REM ::::::::::::::::::::::
15740 REM :: Moonlight shadow ::
15750 REM ::::::::::::::::::::::
15760 DEF PROC_MOONLIGHT_SHADOW
15770 CLS:PROC_DISPLAY_TEXT("97")
15780 ENDPROC
15790 :
15800 REM ::::::::::::::::::
15810 REM :: Moonlit view ::
15820 REM ::::::::::::::::::
15830 DEF PROC_MOONLIT_VIEW
15840 CLS:PROC_DISPLAY_TEXT("24")
15850 ENDPROC
15860 :
15870 REM :::::::::::::::::::::::::::::::::
15880 REM :: Ignore shadow at the window ::
15890 REM :::::::::::::::::::::::::::::::::
15900 DEF PROC_IGNORE_WINDOW_SHADOW
15910 H = FN_RND_INT(1, 2)
15920 ON H PROC_GETTING_BRAVE, PROC_NOTHING_AT_WINDOW
15930 ENDPROC
15940 :
15950 REM :::::::::::::::::::
15960 REM :: Getting brave ::
15970 REM :::::::::::::::::::
15980 DEF PROC_GETTING_BRAVE
15990 CLS:PROC_DISPLAY_TEXT("08")
16000 ENDPROC
16010 :
16020 REM :::::::::::::::::::::::
16030 REM :: Nothing at window ::
16040 REM :::::::::::::::::::::::
16050 DEF PROC_NOTHING_AT_WINDOW
16060 CLS:PROC_DISPLAY_TEXT("59")
16070 ENDPROC
16080 :
16090 REM ::::::::::::::::::::
16100 REM :: Feeling sleepy ::
16110 REM ::::::::::::::::::::
16120 DEF PROC_FEELING_SLEEPY
16130 CLS:PROC_DISPLAY_TEXT("67")
16140 PROC_GET_IN_BED
16150 ENDPROC
16160 :
16170 REM :::::::::::::::::::::::
16180 REM :: Deathly-cold hand ::
16190 REM :::::::::::::::::::::::
16200 DEF PROC_DEATHLY_COLD_HAND
16210 CLS:PROC_DISPLAY_TEXT("80")
16220 PROC_DEATHLY_COLD_HAND_CHOICES
16230 ENDPROC
16240 :
16250 REM ::::::::::::::::::::::::::::::::::::::
16260 REM :: Deathly-cold hand gaming actions ::
16270 REM ::::::::::::::::::::::::::::::::::::::
16280 DEF PROC_DEATHLY_COLD_HAND_CHOICES
16290 AC$(1)="Turn around & look"
16300 AC$(2)="Run!"
16310 AC$(3)="Ignore it"
16320 BR = FN_MAKE_CHOICE("What now, "+Name$+"?", 3)
16330 ON BR PROC_TURN_AROUND, PROC_RUN, PROC_IGNORE
16340 ENDPROC
16350 :
16360 REM ::::::::::::::::::::::::::
16370 REM :: Turn around and look ::
16380 REM ::::::::::::::::::::::::::
16390 DEF PROC_TURN_AROUND
16400 H = FN_RND_INT(1, 4)
16410 ON H PROC_NOBODY_BEHIND_YOU, PROC_NOBODY_BEHIND_YOU, PROC_HIDEOUS_THING, PROC_NOBODY_BEHIND_YOU
16420 ENDPROC
16430 :
16440 REM :::::::::::::::::::::::::::::
16450 REM :: Hideous thing to behold ::
16460 REM :::::::::::::::::::::::::::::
16470 DEF PROC_HIDEOUS_THING
16480 CLS:PROC_DISPLAY_TEXT("95")
16490 PROC_DEATH
16500 ENDPROC
16510 :
16520 REM ::::::::::::
16530 REM :: Ignore ::
16540 REM ::::::::::::
16550 DEF PROC_IGNORE
16560 ENDPROC
16570 :
16580 REM ::::::::::::::::
16590 REM :: Run for it ::
16600 REM ::::::::::::::::
16610 DEF PROC_RUN
16620 CLS:PROC_DISPLAY_TEXT("09")
16630 PROC_DEATHLY_COLD_HAND_CHOICES
16640 ENDPROC
16650 :
16660 REM :::::::::::::::::::::::
16670 REM :: Nobody behind you ::
16680 REM :::::::::::::::::::::::
16690 DEF PROC_NOBODY_BEHIND_YOU
16700 CLS:PROC_DISPLAY_TEXT("05")
16710 ENDPROC
16720 :
16730 REM :::::::::::::::::
16740 REM :: One O'Clock ::
16750 REM :::::::::::::::::
16760 DEF PROC_ONE_AM
16770 CLS:PROC_DISPLAY_TEXT("60")
16780 AC$(1) = "Yes"
16790 AC$(2) = "No"
16800 BR = FN_MAKE_CHOICE("Would you care to join me for tea, "+Name$+", before you go?", 2)
16810 ON BR PROC_TREACHERY, PROC_SURVIVED
16820 ENDPROC
16830 :
16840 REM :::::::::::::::::::::::::
16850 REM :: Survived the ordeal ::
16860 REM :::::::::::::::::::::::::
16870 DEF PROC_SURVIVED
16880 CLS:PROC_DISPLAY_TEXT("2C")
16890 PROC_WERE_IN_THE_MONEY_THEME:PROC_SLEEP(250)
16900 CLS:PROC_DISPLAY_TEXT("2D")
16910 Won% = TRUE
16920 ENDPROC
16930 :
16940 REM :::::::::::::::
16950 REM :: Treachery ::
16960 REM :::::::::::::::
16970 DEF PROC_TREACHERY
16980 CLS:PROC_DISPLAY_TEXT("70")
16990 PROC_GOOD_EVENING_FRIENDS_THEME:PROC_SLEEP(250)
17000 PROC_DEATH
17010 ENDPROC
17020 :
17030 REM :::::::::::
17040 REM :: Death ::
17050 REM :::::::::::
17060 DEF PROC_DEATH
17070 CLS:PROC_DISPLAY_TEXT("6A")
17080 PROC_FLASH_SCREEN(8, 20)
17090 PROC_DEFAULT_COLORS
17100 CLS:PROC_DISPLAY_TEXT("6B")
17110 PROC_FUNERAL_MARCH_THEME
17120 Lost% = TRUE
17130 ENDPROC
17140 :
17150 REM :::::::::::::::::
17160 REM ::  Game Over  ::
17170 REM :::::::::::::::::
17180 DEF PROC_GAME_OVER
17190 LOCAL co%, m%, msg$
17200 m% = VAL(FN_FORMAT_TIME(FALSE)) - 1200:IF m% > 100 THEN m% = m% - 40
17210 CLS:PROC_ERASE_TEXT_BUFFER
17220 IF Lost% THEN co% = RED:msg$ = "So sorry! You lost.":ELSE co% = GREEN:msg$ = "Congratulations! You won."
17230 PROC_WRITE_TEXT_BUFFER(STRING$(FN_CENTER(msg$), CHR$(BLANK))+CHR$(17)+CHR$(co%)+msg$+CHR$(17)+CHR$(FG%)+CHR$(NL))
17240 PROC_WRITE_TEXT_BUFFER(Name$+", you survived for "+STR$(m%)+" minutes."+CHR$(FF))
17250 PROC_ALL_TEXT
17260 ENDPROC
17270 :
17280 REM :::::::::::::::::::::::
17290 REM :: Play Another Game ::
17300 REM :::::::::::::::::::::::
17310 DEF FN_PLAY_AGAIN
17320 AC$(1) = "No"
17330 AC$(2) = "Yes"
17340 := FN_MAKE_CHOICE("Would you like to play again?", 2)
17350 :
17360 REM :::::::::::::::::
17370 REM :: Say Goodbye ::
17380 REM :::::::::::::::::
17390 DEF PROC_GOODBYE(game$)
17400 PROC_HIDE_CURSOR
17410 CLS:PROC_FULL_CENTER_TEXT("So long and thank you for playing...")
17420 FOR i% = 0 TO FN_CENTER(game$) - 1:PRINTTAB(0, CH% DIV 2 + 2)STRING$(i%, " ")CHR$(17)CHR$(i% MOD 7 + 1)game$:PROC_SLEEP(20):NEXT i%
17430 PROC_DEFAULT_COLORS
17440 PROC_SHOW_CURSOR
17450 ENDPROC
17460 :
17470 REM ::::::::::::::::::::::::::
17480 REM :: Display text passage ::
17490 REM ::::::::::::::::::::::::::
17500 DEF PROC_DISPLAY_TEXT(passage$)
17510 PROC_WORD_WRAPF(1, 1, CW% - 2, CH% - 2, passage$)
17520 ENDPROC
17530 :
17540 REM ::::::::::::::::::::::::::::::::::::::
17550 REM :: Display all text buffer contents ::
17560 REM ::::::::::::::::::::::::::::::::::::::
17570 DEF PROC_ALL_TEXT
17580 PROC_WORD_WRAP(1, 1, CW% - 2, CH% - 2, FN_READ_TEXT_BUFFER(0))
17590 ENDPROC
17600 :
17610 REM :::::::::::::::::::::::::::::::::::::::::::::
17620 REM :: Is character position outside of width? ::
17630 REM :::::::::::::::::::::::::::::::::::::::::::::
17640 DEF FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x%)
17650 := (x% > (ux% + width%))
17660 :
17670 REM :::::::::::::::::::::::::::::
17680 REM :: Process a special token ::
17690 REM :::::::::::::::::::::::::::::
17700 DEF FN_PROCESS_SPECIAL_TOKEN(text$)
17710 LOCAL r$
17720 r$ = FN_XSTRING$(text$, ":NM:", Name$):REM Inject player's name
17730 r$ = FN_XSTRING$(r$, ":TM:", FN_FORMAT_TIME(TRUE)):REM Inject current time
17740 := r$
17750 :
17760 REM :::::::::::::::::::::::::::::::::::::
17770 REM :: Is it a special character code? ::
17780 REM :::::::::::::::::::::::::::::::::::::
17790 DEF FN_IS_SPECIAL(ch%)
17800 := (ch% = BLANK OR ch% = NL OR ch% = C_TAB OR ch% = CR OR ch% = FF OR ch% = DOT OR ch% = DASH OR ch% = QST OR ch% = EX)
17810 :
17820 REM ::::::::::::::::::::::::::::::::::::::::
17830 REM :: Handle when a new page is required ::
17840 REM ::::::::::::::::::::::::::::::::::::::::
17850 DEF PROC_HANDLE_NEW_PAGE(ux%, uy%, width%, height%)
17860 PROC_CONTINUE
17870 PROC_WIPE_TEXT(ux%, uy%, width%, height%)
17880 PROC_TEXT_BOUNDING_BOX(ux%, uy%, width%, height%)
17890 ENDPROC
17900 :
17910 REM ::::::::::::::::::::::::::::::::::::
17920 REM :: Handle special character codes ::
17930 REM ::::::::::::::::::::::::::::::::::::
17940 DEF PROC_HANDLE_SPECIAL(ux%, uy%, width%, height%, ch%)
17950 LOCAL c%, delay%, i%, isOverflow%, n%, newPage%, x%, y%
17960 c% = 0:n% = 1:delay% = 0:newPage% = FALSE:isOverFlow% = FALSE:x% = POS:y% = VPOS
17970 IF DASH = ch% THEN c% = ch%
17980 IF BLANK = ch% THEN delay% = 30:IF x% > ux% AND x% < ux% + width% THEN c% = ch%
17990 IF DOT = ch% OR EX = ch% THEN delay% = 100:c% = ch%
18000 IF QST = ch% THEN delay% = 150:c% = ch%
18010 IF C_TAB = ch% AND NOT FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x% + 1) THEN c% = BLANK:n% = 2
18020 IF FF = ch% THEN newPage% = TRUE
18030 IF NL = ch% OR CR = ch% OR FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x%) THEN isOverFlow% = TRUE
18040 IF isOverFlow% THEN x% = ux%:y% = y% + 1 + (NL = ch% OR CR = ch%)* -1:IF y% > (height% - 2) THEN newPage% = TRUE
18050 IF newPage% THEN PRINT:PROC_HANDLE_NEW_PAGE(ux%, uy%, width%, height%):y% = uy%:x% = ux%
18060 FOR i% = 1 TO n%
18070   PRINT TAB(x%, y%);
18080   IF c% > 0 THEN PRINT CHR$(c%);
18090   PROC_SLEEP(delay%)
18100 NEXT i%
18110 ENDPROC
18120 :
18130 REM :::::::::::::::::::::::::::::::::::::::
18140 REM :: Display text streamed from a file ::
18150 REM :: inside of a word-wrapped box      ::
18160 REM :::::::::::::::::::::::::::::::::::::::
18170 DEF PROC_WORD_WRAPF(ux%, uy%, width%, height%, passage$)
18180 LOCAL ch%, i%, infile%, len%, special%, word$, wordLen%, wordStart%, x%, y%
18190 PROC_TEXT_BOUNDING_BOX(ux%, uy%, width%, height%)
18200 infile% = OPENIN("data/dat"+passage$+".bin")
18210 len% = EXT#infile%:wordStart% = 0:wordLen% = 0:word$ = ""
18220 x% = ux%:y% = uy%:REM Begin from specified starting row
18230 FOR i% = 1 TO len%
18240   IF (wordStart% = 0) THEN wordStart% = i%
18250   ch% = BGET#infile%:special% = FN_IS_SPECIAL(ch%)
18260   IF (i% = len% OR special%) THEN word$ = FN_PROCESS_SPECIAL_TOKEN(FN_FILE_READ_CHARS(infile%, wordStart%, 1 + i% - wordStart%)):wordLen% = LEN(word$)
18270   IF (wordLen% > (width% - x% + ux% + (ch% = BLANK)*-1)) THEN y% = y% + 1:x% = ux%
18280   IF (wordLen% > 0) THEN PRINT TAB(x%, y%);LEFT$(word$, wordLen% + (special%));:wordStart% = 0:wordLen% = 0:y% = VPOS:x% = POS:PROC_HANDLE_SPECIAL(ux%, uy%, width%, height%, ASC(RIGHT$(word$, 1))):y% = VPOS:x% = POS
18290 NEXT i%
18300 CLOSE#infile%
18310 ENDPROC
18320 :
18330 REM ::::::::::::::::::::::::::::::::::::::
18340 REM :: Display text in word-wrapped box ::
18350 REM ::::::::::::::::::::::::::::::::::::::
18360 DEF PROC_WORD_WRAP(ux%, uy%, width%, height%, text$)
18370 LOCAL ch%, i%, len%, special%, word$, wordLen%, wordStart%, x%, y%
18380 PROC_TEXT_BOUNDING_BOX(ux%, uy%, width%, height%)
18390 len% = LEN(text$):wordStart% = 0:wordLen% = 0:word$ = ""
18400 x% = ux%:y% = uy%:REM Begin from specified starting row
18410 FOR i% = 1 TO len%
18420   IF (wordStart% = 0) THEN wordStart% = i%
18430   ch% = ASC(MID$(text$, i%, 1)):special% = FN_IS_SPECIAL(ch%)
18440   IF (i% = len% OR special%) THEN word$ = FN_PROCESS_SPECIAL_TOKEN(MID$(text$, wordStart%, 1 + i% - wordStart%)):wordLen% = LEN(word$)
18450   IF (wordLen% > (width% - x% + ux% + (ch% = BLANK)*-1)) THEN y% = y% + 1:x% = ux%
18460   IF (wordLen% > 0) THEN PRINT TAB(x%, y%);LEFT$(word$, wordLen% + (special%));:wordStart% = 0:wordLen% = 0:y% = VPOS:x% = POS:PROC_HANDLE_SPECIAL(ux%, uy%, width%, height%, ASC(RIGHT$(word$, 1))):y% = VPOS:x% = POS
18470 NEXT i%
18480 ENDPROC
18490 :
18500 REM :::::::::::::::::::::::::::::::::::
18510 REM :: Draw bounding box around text ::
18520 REM :::::::::::::::::::::::::::::::::::
18530 DEF PROC_TEXT_BOUNDING_BOX(ux%, uy%, width%, height%)
18540 PROC_CLOCKWISE_BOX(ux% - 1, uy% - 1, width% + 2, height% + 2, CYAN)
18550 PROC_WIPE_TEXT(ux%, uy%, width%, height%)
18560 PROC_DEFAULT_COLORS
18570 ENDPROC
18580 :
18590 REM :::::::::::::::::::::::::::::::
18600 REM :: Prompt for a story action ::
18610 REM :::::::::::::::::::::::::::::::
18620 DEF FN_MAKE_CHOICE(prompt$, count%)
18630 LOCAL bg%, br%, c%, fg%, i%, ni%, ti, y%
18640 PROC_EMPTY_KEYBOARD_BUFFER
18650 CLS
18660 PRINT prompt$:PRINT
18670 ni% = OneAM% OR Won% OR Lost%:br% = (ni%) * -1 + (NOT ni%) *-FN_RND_INT(1, count%):c% = 0:y% = VPOS:ti = TIME:fg% = FG%:bg%= BG%
18680 REPEAT:REM DISPLAY POSSIBLE CHOICES AND GET SELECTION
18690   FOR i% = 1 TO count%
18700     PRINT TAB(0, y% + i% - 1);
18710     IF br% = i% THEN fg% = YELLOW:PRINT FN_RVS(fg%, bg%, AC$(i%)):REM MOVE REVERSE-VIDEO TO NEXT CHOICE
18720     IF br% <> i% THEN fg% = FG%:PRINT CHR$(17)CHR$(bg%+128)CHR$(17)CHR$(fg%)AC$(i%)
18730   NEXT i%
18740   c% = INKEY(1000)
18750   IF c% = DOWN THEN br% = br% MOD count% + 1:REM TEST FOR CURSOR DOWN
18760   IF c% = UP THEN br% = (count% + br% - 2) MOD count% + 1:REM TEST FOR CURSOR UP
18770 UNTIL c% = 13 OR c% = TRUE
18780 PROC_DEFAULT_COLORS
18790 := br%:REM CHOICE SELECTED IS CURRENT BRANCH (i.e. br%)
18800 :
18810 REM ::::::::::::::::::::::::::::::::::::::::::
18820 REM :: Flash the screen with various colors ::
18830 REM ::::::::::::::::::::::::::::::::::::::::::
18840 DEF PROC_FLASH_SCREEN(count%, delay%)
18850 LOCAL i%
18860 FOR i% = 1 TO count%
18870   COLOUR 128+i%:COLOUR BLACK:CLS
18880   PROC_SLEEP(delay%)
18890 NEXT i%
18900 PROC_DEFAULT_COLORS
18910 ENDPROC
18920 :
18930 REM :::::::::::::::::::::::::::::::::::
18940 REM :: Erase contents of text buffer ::
18950 REM :::::::::::::::::::::::::::::::::::
18960 DEF PROC_ERASE_TEXT_BUFFER
18970 TX_Pointer% = 0:REM Reset Pointer to text buffer
18980 $TX = STRING$(TX_SIZE%, CHR$(CR))
18990 ENDPROC
19000 :
19010 REM :::::::::::::::::::::::::::::::::::
19020 REM :: Write text to the text buffer ::
19030 REM :::::::::::::::::::::::::::::::::::
19040 DEF PROC_WRITE_TEXT_BUFFER(text$)
19050 LOCAL i%
19060 IF TX_Pointer% + LEN(text$) > TX_SIZE% THEN ERROR 19, "String too long"
19070 FOR i% = 1 TO LEN(text$)
19080   $(TX + TX_Pointer%) = MID$(text$, i%, 1)
19090   TX_Pointer% = (TX_Pointer% + 1)
19100 NEXT i%
19110 ENDPROC
19120 :
19130 REM ::::::::::::::::::::::::::::::::::::::
19140 REM :: Read text out of the text buffer ::
19150 REM ::::::::::::::::::::::::::::::::::::::
19160 DEF FN_READ_TEXT_BUFFER(pos%)
19170 LOCAL n%, r$
19180 IF pos% > TX_SIZE% THEN ERROR 14, "Reference array incorrect"
19190 r$ = $(TX + pos%)
19200 := r$
19210 :
19220 REM :::::::::::::::::::::::::::::::::::::::::::::
19230 REM :: Read a stream of characters from a file ::
19240 REM :::::::::::::::::::::::::::::::::::::::::::::
19250 DEF FN_FILE_READ_CHARS(infile%, pos%, len%)
19260 LOCAL currentPos%, i%, r$
19270 r$ = "":currentPos% = PTR#infile%
19280 PTR#infile% = pos% - 1
19290 FOR i% = 1 TO len%
19300   r$ = r$ + CHR$(BGET#infile%)
19310 NEXT i%
19320 PTR#infile% = currentPos%:REM Restore file pointer to previous position
19330 := r$
19340 :
19350 REM :::::::::::::::::::::
19360 REM :: Retrieve a byte ::
19370 REM :: register value  ::
19380 REM :: from VDP        ::
19390 REM :::::::::::::::::::::
19400 DEF FN_getByteVDP(var%):A% = &A0:L% = var%:= USR(&FFF4)
19410 :
19420 REM ::::::::::::::::::::::::::::::::::::
19430 REM :: Set the time of the simple RTC ::
19440 REM ::::::::::::::::::::::::::::::::::::
19450 DEF FN_SET_TIME(hours%,minutes%,seconds%)
19460 TIME = hours% * 360000 + minutes% * 6000 + seconds% * 100
19470 := TIME
19480 :
19490 REM :::::::::::::::::::::::::::::
19500 REM :: Format time as a String ::
19510 REM :::::::::::::::::::::::::::::
19520 DEF FN_FORMAT_TIME(addColons%)
19530 LOCAL hours%,minutes%,seconds%,time%,r$
19540 r$ = "":time% = TIME
19550 hours% = time% DIV 360000
19560 minutes% = (time% - hours% * 360000) DIV 6000
19570 seconds% = (time% - hours% * 360000 - minutes% * 6000) DIV 100
19580 r$ = FN_PAD_NUMBER(hours%, 2):IF addColons% THEN r$ = r$ + ":"
19590 r$ = r$ + FN_PAD_NUMBER(minutes%, 2):REM IF addColons% THEN r$ = r$ + ":"
19600 REM r$ = r$ + FN_PAD_NUMBER(seconds%, 2)
19610 := r$
19620 :
19630 REM :::::::::::::::::::::::::::
19640 REM ::   Bounded time ticks  ::
19650 REM :::::::::::::::::::::::::::
19660 DEF FN_INT_TIME:= TIME MOD MAXINT%
19670 :
19680 REM :::::::::::::::::::::::
19690 REM :: Has time reached  ::
19700 REM :: target seconds?   ::
19710 REM :::::::::::::::::::::::
19720 DEF FN_IS_TIME(sec%, prevSec%, targetSec%):= (sec% MOD targetSec% = 0 AND sec% <> prevSec%)
19730 :
19740 REM :::::::::::::::::::::::::::::::::::::::
19750 REM :: Pause execution of the program    ::
19760 REM :: for a number of ticks (1/100) sec ::
19770 REM :::::::::::::::::::::::::::::::::::::::
19780 DEF PROC_SLEEP(hundredth_seconds%):LOCAL t:hundredth_seconds% = hundredth_seconds% + (hundredth_seconds% < 0) * -hundredth_seconds%:t = TIME:REPEAT UNTIL ((TIME - t) > hundredth_seconds%):ENDPROC
19790 :
19800 REM ::::::::::::::::::::::::::::::::
19810 REM :: Return TRUE when random    ::
19820 REM :: value is below given value ::
19830 REM ::::::::::::::::::::::::::::::::
19840 DEF FN_RND_PCT(n%):=RND(1) <= (n% / 100):REM Returns TRUE or FALSE
19850 :
19860 REM :::::::::::::::::::::::::::::::::
19870 REM :: Random Integer Within Range ::
19880 REM :::::::::::::::::::::::::::::::::
19890 DEF FN_RND_INT(lo%, hi%):= (RND(1) * (hi% - lo% + 1)) + lo%
19900 :
19910 REM ::::::::::::::::::::::
19920 REM ::   To Uppercase   ::
19930 REM ::::::::::::::::::::::
19940 DEF FN_TO_UPPER(ch$):LOCAL ch%:ch% = ASC(ch$):ch$ = CHR$(ch% + 32 * (ch% >= 97 AND ch% <= 122)):=ch$
19950 :
19960 REM ::::::::::::::::::::::
19970 REM ::   To Lowercase   ::
19980 REM ::::::::::::::::::::::
19990 DEF FN_TO_LOWER(ch$):LOCAL ch%:ch% = ASC(ch$):ch$ = CHR$(ch% - 32 * (ch% >= 65 AND ch% <= 90)):=ch$
20000 :
20010 REM ::::::::::::::::::::::::::::::::
20020 REM :: Prepend Zeroes To A Number ::
20030 REM ::::::::::::::::::::::::::::::::
20040 DEF FN_PAD_NUMBER(val%, len%)
20050 LOCAL s$
20060 s$ = STR$(val%)
20070 := STRING$(len% - LEN(s$), "0") + s$
20080 :
20090 REM :::::::::::::::::::::::::::
20100 REM :: Hit a key to continue ::
20110 REM :::::::::::::::::::::::::::
20120 DEF FN_HIT_A_KEY
20130 LOCAL c%, ex%, ti
20140 c% = 0:ex% = FALSE:ti = TIME
20150 REPEAT
20160   c% = INKEY(10):IF c% > 0 OR 1000 < (TIME - ti) THEN ex% = TRUE
20170 UNTIL ex%
20180 := c%
20190 :
20200 REM :::::::::::::::::::::::::::::::::::
20210 REM :: Display Text In Reverse Video ::
20220 REM :::::::::::::::::::::::::::::::::::
20230 DEF FN_RVS(fg%, bg%, text$):= CHR$(17)+CHR$(128+fg%)+CHR$(17)+CHR$(bg%)+text$+CHR$(17)+CHR$(fg%)+CHR$(17)+CHR$(128+bg%)
20240 :
20250 REM :::::::::::::::::::::
20260 REM ::   Center text   ::
20270 REM :::::::::::::::::::::
20280 DEF FN_CENTER(text$):= (CW% - LEN(text$)) DIV 2
20290 :
20300 REM :::::::::::::::::::::
20310 REM :: Right-trim text ::
20320 REM :::::::::::::::::::::
20330 DEF FN_RTRIM(text$)
20340 LOCAL trim%
20350 REPEAT
20360   trim% = FALSE
20370   IF ASC(LEFT$(text$, LEN(text$) - 1)) = BLANK THEN text$ = LEFT$(text$, LEN(text$) - 1):trim% = TRUE
20380 UNTIL NOT trim%
20390 := text$
20400 :
20410 REM ::::::::::::::::::::::::::::::
20420 REM :: Replace Text In A String ::
20430 REM ::::::::::::::::::::::::::::::
20440 DEF FN_XSTRING$(text$, pattern$, newText$)
20450 LOCAL pos%, r$
20460 r$ = text$
20470 pos% = INSTR(text$, pattern$)
20480 IF pos% > 0 THEN r$ = LEFT$(text$, pos%-1) + newText$ + RIGHT$(text$, LEN(text$) - LEN(pattern$) - pos% + 1)
20490 := r$
20500 :
20510 REM :::::::::::::::::::::::::
20520 REM :: Prompt For Response ::
20530 REM :::::::::::::::::::::::::
20540 DEF FN_PROMPT(x%, y%, text$, default$)
20550 LOCAL r$
20560 PRINT TAB(x%, y%)text$;" ";default$:PRINT TAB(x% + LEN(text$) + 1, y%);
20570 r$ = GET$:r$ = FN_TO_UPPER(r$):IF r$ = CHR$(13) THEN r$ = default$
20580 := r$
20590 :
20600 REM :::::::::::::::::::::::::::::
20610 REM ::  Display Centered Text  ::
20620 REM :::::::::::::::::::::::::::::
20630 DEF PROC_CENTER(text$)
20640 LOCAL i%, l%, len%, x%, y%
20650 l% = 0:y% = VPOS:len% = LEN(text$)
20660 FOR i% = 1 TO len%
20670   IF ASC(MID$(text$, i%, 1)) >= BLANK THEN l% = l% + 1
20680 NEXT i%
20690 x% = (CW% - l%) DIV 2
20700 PRINT TAB(x%, y%);:REM VDU 31, x%, y%
20710 FOR i% = 1 TO len%
20720   VDU ASC(MID$(text$, i%, 1))
20730 NEXT i%
20740 ENDPROC
20750 :
20760 REM :::::::::::::::::::::::::::::::::
20770 REM :: Center text both vertically ::
20780 REM :: and horizontally            ::
20790 REM :::::::::::::::::::::::::::::::::
20800 DEF PROC_FULL_CENTER_TEXT(text$)
20810 LOCAL x%, y%
20820 x% = FN_CENTER(text$):y% = CH% DIV 2
20830 VDU 31, x%, y%:PRINT text$;
20840 ENDPROC
20850 :
20860 REM :::::::::::::::::::::::::::
20870 REM :: Empty Keyboard Buffer ::
20880 REM :::::::::::::::::::::::::::
20890 DEF PROC_EMPTY_KEYBOARD_BUFFER
20900 REPEAT UNTIL INKEY(0) = -1
20910 ENDPROC
20920 :
20930 REM ::::::::::::::::::::::::::::
20940 REM :: Disable display of the ::
20950 REM :: cursor on the screen   ::
20960 REM ::::::::::::::::::::::::::::
20970 DEF PROC_HIDE_CURSOR
20980 VDU 23,1,0;0;0;0;
20990 ENDPROC
21000 :
21010 REM ::::::::::::::::::::::::::::
21020 REM :: Enable display of the  ::
21030 REM :: cursor on the screen   ::
21040 REM ::::::::::::::::::::::::::::
21050 DEF PROC_SHOW_CURSOR
21060 VDU 23,1,1;0;0;0;
21070 ENDPROC
21080 :
21090 REM ::::::::::::::::::::::::::::
21100 REM :: Restore Default Colors ::
21110 REM ::::::::::::::::::::::::::::
21120 DEF PROC_DEFAULT_COLORS
21130 COLOUR 128+BG%:COLOUR FG%
21140 ENDPROC
21150 :
21160 REM ::::::::::::::::::::::::::::::::::::::::::::
21170 REM :: Wipe away the text contents of the box ::
21180 REM ::::::::::::::::::::::::::::::::::::::::::::
21190 DEF PROC_WIPE_TEXT(ux%, uy%, width%, height%)
21200 LOCAL i%, blank$
21210 blank$ = STRING$(width%, " ")
21220 FOR i% = uy% TO uy% + height% - 1
21230   PRINT TAB(ux%, i%)blank$
21240 NEXT i%
21250 PRINT TAB(ux%, uy%);:REM Position cursor to upper left corner of bounding box
21260 ENDPROC
21270 :
21280 REM :::::::::::::::::::::::::::::::::::::::::::
21290 REM ::  Calculate type index of a clockwise  ::
21300 REM ::  position on a box's perimeter        ::
21310 REM :::::::::::::::::::::::::::::::::::::::::::
21320 DEF FN_CLOCKWISE_BOX_SIDE_INDEX(pos%, width%, height%)
21330 REM 0 = UPPER_LEFT_CORNER, 1 = UPPER_MIDDLE, 2 = UPPER_RIGHT_CORNER, 3 = MIDDLE_RIGHT, 4 = LOWER_RIGHT_CORNER, 5 = LOWER_MIDDLE, 6 = LOWER_LEFT_CORNER, 7 = MIDDLE_LEFT
21340 LOCAL r%
21350 r% = (pos% > 0 AND pos% < width% - 1) * -1 + (pos% = width% - 1) * -2 + (pos% >= width% AND pos% < width% + height% - 2) * -3 + (pos% = width% + height% - 2) * -4
21360 r% = r% + (pos% > width% + height% - 2 AND pos% < 2 * width% + height% - 3) * -5 + (pos% = 2 * width% + height% - 3) * -6 + (pos% > 2 * width% + height% - 3) * -7
21370 :=r%
21380 :
21390 REM ::::::::::::::::::::::::::
21400 REM ::  Draw Box Clockwise  ::
21410 REM ::::::::::::::::::::::::::
21420 DEF PROC_CLOCKWISE_BOX(ux%, uy%, width%, height%, color%)
21430 LOCAL aq%, bq%, ch%, i%, p%, x%, y%
21440 aq% = width% + height% - 2:bq% = aq% + width%:p% = bq% + height% - 2
21450 FOR i% = 0 TO p% - 1
21460   x% = (i% < width%) * -i% + (i% > (width%-1) AND i% < aq%) * -(width%-1) + (i% >= aq% AND i% < bq%) * (i% - (bq% - 1)) + (i% >= bq%) * 0
21470   y% = (i% < width%) * 0 + (i% > (width%-1) AND i% < aq%) * -(i% - (width%-1)) + (i% >= aq% AND i% < bq%) * -(height%-1) + (i% >= bq%) * -((height%-2) - (i% - bq%))
21480   ch% = ASC(MID$(BX$, FN_CLOCKWISE_BOX_SIDE_INDEX(i%, width%, height%) + 1, 1))
21490   PROC_PLOT(ux% + x%, uy% + y%, ch%, color%)
21500 NEXT i%
21510 ENDPROC
21520 :
21530 REM :::::::::::::::::::::::::::
21540 REM :: Plot a single colored ::
21550 REM :: character to screen   ::
21560 REM :::::::::::::::::::::::::::
21570 DEF PROC_PLOT(x%, y%, ch%, co%)
21580 VDU 31, x%, y%
21590 VDU 17, co%, ch%
21600 ENDPROC
21610 :
21620 REM ::::::::::::::
21630 REM :: Suspense ::
21640 REM ::::::::::::::
21650 DEF PROC_SUSPENSE(count%, ch%, delay%)
21660 LOCAL i%
21670 PRINT TAB(FN_CENTER(STRING$(count%, CHR$(ch%))), VPOS);
21680 FOR i% = 1 TO count%
21690   PRINT CHR$(ch%);:PROC_SLEEP(delay%)
21700 NEXT i%
21710 PRINT
21720 ENDPROC
21730 :
21740 REM :::::::::::::::::::::::::::::::::
21750 REM :: Enter letters from keyboard ::
21760 REM :::::::::::::::::::::::::::::::::
21770 DEF FN_PROMPT_FOR_LETTERS(length%)
21780 LOCAL c$, r$
21790 r$ = "":PROC_EMPTY_KEYBOARD_BUFFER:PROC_SHOW_CURSOR
21800 REPEAT
21810   c$ = GET$
21820   IF ((c$ = CHR$(127) OR c$ = CHR$(8)) AND LEN(r$) > 0) THEN r$ = LEFT$(r$, LEN(r$) - 1):PRINT CHR$(127);
21830   IF ((c$ >= "A" AND c$ <= "Z") OR (c$ >= "a" AND c$ <= "z") OR (c$ = CHR$(BLANK))) AND LEN(r$) < length% THEN r$ = r$ + c$:PRINT c$;
21840 UNTIL c$ = CHR$(CR) AND LEN(r$) <= length%
21850 PROC_HIDE_CURSOR
21860 :=r$
21870 :
21880 REM :::::::::::::::::::::::
21890 REM :: Play Simple Sound ::
21900 REM :::::::::::::::::::::::
21910 DEF PROC_SOUND(index%, duration%)
21920 LOCAL constant%
21930 constant% = 12.2
21940 SOUND 1, -12, index% * constant%, duration%
21950 ENDPROC
21960 :
21970 REM :::::::::::::::::::::::::
21980 REM :: Play Musical Phrase ::
21990 REM :::::::::::::::::::::::::
22000 DEF PROC_PLAY(notes$)
22010 LOCAL d%, j%, l%, p%
22020 l% = LEN(notes$) DIV 3
22030 FOR j% = 1 TO l% STEP 2
22040   p% = VAL(MID$(notes$, 3 * (j% - 1) + 1, 3)):d% = VAL(MID$(notes$, 3 * (j% - 1) + 4, 3))
22050   IF p% >= 0 THEN SOUND 1, -13, p%, d%:ELSE SOUND 1, 0, 0, d%
22060   SOUND 1, 0, p%, 1:REM Stacatto the currently playing sound
22070 NEXT j%
22080 ENDPROC
22090 :
22100 REM :::::::::::::::::::::::::::
22110 REM ::  Funeral March Theme  ::
22120 REM :::::::::::::::::::::::::::
22130 DEF PROC_FUNERAL_MARCH_THEME
22140 PROC_PLAY("089008089006089002089008101006097002097006089002089006089002089024"):REM PITCH,DURATION
22150 ENDPROC
22160 :
22170 REM ::::::::::::::::::::::::::::::::::
22180 REM ::  Good Evening Friends Theme  ::
22190 REM ::::::::::::::::::::::::::::::::::
22200 DEF PROC_GOOD_EVENING_FRIENDS_THEME
22210 PROC_PLAY("149008157008149008161024"):REM PITCH,DURATION
22220 ENDPROC
22230 :
22240 REM :::::::::::::::::::::
22250 REM ::  ITHOTMK Theme  ::
22260 REM :::::::::::::::::::::
22270 DEF PROC_ITHOTMK_THEME
22280 LOCAL notes$:REM PITCH,DURATION
22290 notes$ = "097004105004109004117004125004109004125008121004105004121008117004101004117008"
22300 notes$ = notes$ + "097004105004109004117004125004109004125004145004137004125004109004125004137016"
22310 PROC_PLAY(notes$)
22320 ENDPROC
22330 :
22340 REM ::::::::::::::::
22350 REM ::  TZ Theme  ::
22360 REM ::::::::::::::::
22370 DEF PROC_TZ_THEME
22380 PROC_PLAY("181004185004181004165004181004185004181004165004181004185004181004165004"):REM PITCH,DURATION
22390 ENDPROC
22400 :
22410 REM ::::::::::::::::::::::::::::::::
22420 REM ::  We"re In The Money Theme  ::
22430 REM ::::::::::::::::::::::::::::::::
22440 DEF PROC_WERE_IN_THE_MONEY_THEME
22450 PROC_PLAY("157004169006157002161004169012"):REM PITCH,DURATION
22460 ENDPROC
22470 :
22480 REM ::::::::::::::::::::::::::::::
22490 REM :: Define Custom Characters ::
22500 REM ::::::::::::::::::::::::::::::
22510 DEF PROC_REDEFINE_CHARS
22520 VDU 23,SKULL,0,189,126,90,126,165,24,0:REM SKULL(7)
22530 VDU 23,B_VERT,24,24,24,24,24,24,24,24:REM VERTICAL(4)
22540 VDU 23,B_HORZ,0,0,0,255,255,0,0,0:REM HORIZONTAL(4)
22550 VDU 23,B_UR,0,0,0,7,15,28,24,24:REM UPRIGHT C(4)
22560 VDU 23,B_UL,0,0,0,224,240,56,24,24:REM UPLEFT C(4)
22570 VDU 23,B_DL,24,24,56,240,224,0,0,0:REM DOWNLEFT C(4)
22580 VDU 23,B_DR,24,24,28,15,7,0,0,0:REM DOWN RIGHT C(4)
22590 ENDPROC
22600 :
22610 REM ::::::::::::::::::::::::::::::
22620 REM ::  Error Handling Routine  ::
22630 REM ::::::::::::::::::::::::::::::
22640 DEF PROC_HANDLE_ERROR
22650 IF ERR <> 17 THEN PROC_DEFAULT_COLORS:PROC_SHOW_CURSOR:PRINT:REPORT:PRINT" @line #";ERL:STOP
22660 ENDPROC
