10000 REM :::::::::::::::::::::::::::::::::::::::::::::::
10010 REM :: DEATH HOUSE FOR AgonLight (BBC BASIC v3)  ::
10020 REM :::::::::::::::::::::::::::::::::::::::::::::::
10030 REM :: 20231125: Ver 1.2.1 - Small improvements  ::
10040 REM :::::::::::::::::::::::::::::::::::::::::::::::
10050 REM :: This game is a BBC BASIC v3 port of the   ::
10060 REM :: C<64 game coded in Commodore BASIC v2 by  ::
10070 REM :: Mark S. Boucher with some enhancements by ::
10080 REM :: Tony DeFusco                              ::
10090 REM :::::::::::::::::::::::::::::::::::::::::::::::
10100 REM :: It is best experienced in a 40+ column,   ::
10110 REM :: 64-color display mode.                    ::
10120 REM :::::::::::::::::::::::::::::::::::::::::::::::
10130 REM!Embed @dir$+"data/DAT03.BIN", @dir$+"data/DAT04.BIN", @dir$+"data/DAT05.BIN"
10140 REM!Embed @dir$+"data/DAT06.BIN", @dir$+"data/DAT07.BIN", @dir$+"data/DAT08.BIN"
10150 REM!Embed @dir$+"data/DAT09.BIN", @dir$+"data/DAT11.BIN", @dir$+"data/DAT12.BIN"
10160 REM!Embed @dir$+"data/DAT13.BIN", @dir$+"data/DAT16.BIN", @dir$+"data/DAT18.BIN"
10170 REM!Embed @dir$+"data/DAT19.BIN", @dir$+"data/DAT21.BIN", @dir$+"data/DAT24.BIN"
10180 REM!Embed @dir$+"data/DAT27.BIN", @dir$+"data/DAT2A.BIN", @dir$+"data/DAT2B.BIN"
10190 REM!Embed @dir$+"data/DAT2C.BIN", @dir$+"data/DAT2D.BIN", @dir$+"data/DAT31.BIN"
10200 REM!Embed @dir$+"data/DAT32.BIN", @dir$+"data/DAT37.BIN", @dir$+"data/DAT38.BIN"
10210 REM!Embed @dir$+"data/DAT39.BIN", @dir$+"data/DAT40.BIN", @dir$+"data/DAT41.BIN"
10220 REM!Embed @dir$+"data/DAT46.BIN", @dir$+"data/DAT47.BIN", @dir$+"data/DAT48.BIN"
10230 REM!Embed @dir$+"data/DAT49.BIN", @dir$+"data/DAT52.BIN", @dir$+"data/DAT53.BIN"
10240 REM!Embed @dir$+"data/DAT55.BIN", @dir$+"data/DAT59.BIN", @dir$+"data/DAT60.BIN"
10250 REM!Embed @dir$+"data/DAT61.BIN", @dir$+"data/DAT65.BIN", @dir$+"data/DAT66.BIN"
10260 REM!Embed @dir$+"data/DAT67.BIN", @dir$+"data/DAT6A.BIN", @dir$+"data/DAT6B.BIN"
10270 REM!Embed @dir$+"data/DAT70.BIN", @dir$+"data/DAT71.BIN", @dir$+"data/DAT73.BIN"
10280 REM!Embed @dir$+"data/DAT76.BIN", @dir$+"data/DAT80.BIN", @dir$+"data/DAT84.BIN"
10290 REM!Embed @dir$+"data/DAT88.BIN", @dir$+"data/DAT92.BIN", @dir$+"data/DAT94.BIN"
10300 REM!Embed @dir$+"data/DAT95.BIN", @dir$+"data/DAT97.BIN", @dir$+"data/DAT99.BIN"
10310 CLEAR
10320 REPEAT CLS:SY$=FN_TO_UPPER(FN_PROMPT(0,0,"TARGET (A)gon or (B)BC B-SDL:","A")):UNTIL SY$ = "A" OR SY$ = "B"
10330 IF SY$ = "B" THEN LEFT = 136:RIGHT = 137:DOWN = 138:UP = 139:DL% = 10:MO% = 9:ELSE LEFT = 8:RIGHT = 21:DOWN = 10:UP = 11:DL% = 14:MO% = 8
10340 MODE MO%
10350 PROC_SETUP:PROC_HIDE_CURSOR
10360 ON ERROR PROC_HANDLE_ERROR:REM Handle ESC key
10370 :
10380 PROC_WELCOME
10390 PROC_IDENTIFY_YOURSELF
10400 REPEAT
10410   PROC_NEW_GAME
10420   Resp$ = FN_SKIP_INTRO
10430   IF Resp$ <> "Y" THEN PROC_INTRO
10440   PROC_INITIAL_TEXT
10450   PROC_MAIN_LOOP:REM Invoke main loop
10460   GameOver% = Won% OR Lost%
10470   IF GameOver% THEN PROC_GAME_OVER:Resp% = FN_PLAY_AGAIN:GameOver% = (Resp% = 1)
10480   IF GameOver% THEN PROC_GOODBYE(GameName$)
10490 UNTIL GameOver%
10500 END:REM The official exit point of the game
10510 :
10520 REM ::::::::::::::::::::
10530 REM ::   Setup Game   ::
10540 REM ::::::::::::::::::::
10550 DEF PROC_SETUP
10560 BLACK = 0:RED = 1:GREEN = 2:YELLOW = 3:BLUE = 4:MAGENTA = 5:CYAN = 6:WHITE = 7
10570 B_VERT = 140:B_HORZ = 141:B_UR = 142:B_UL = 143:B_DL = 144:B_DR = 145
10580 BLANK = 32:SKULL = 42:C_TAB = 9:NL = 10:CR = 13:FF = 12:DASH = 45:DOT = 46:QST = 63:EX = 33
10590 MAXINT% = &3B9AC9FF:GameName$ = "DEATH-HOUSE":FG% = WHITE:BG% = BLACK
10600 IF SY$ = "A" THEN CW% = FN_getByteVDP(&13):CH% = FN_getByteVDP(&14) - 1:ELSE CW% = 40:CH% = 24
10610 TX_SIZE% = 255
10620 DIM AC$(6), TX TX_SIZE%
10630 TK = TIME:PROC_SLEEP(100):TK = TIME - TK:REM CALIBRATE TIME TICKS
10640 BX$ = CHR$(B_UR) + CHR$(B_HORZ) + CHR$(B_UL) + CHR$(B_VERT) + CHR$(B_DL) + CHR$(B_HORZ) + CHR$(B_DR) + CHR$(B_VERT)
10650 PROC_REDEFINE_CHARS
10660 ENDPROC
10670 :
10680 REM :::::::::::::::
10690 REM :: Main loop ::
10700 REM :::::::::::::::
10710 DEF PROC_MAIN_LOOP
10720 REPEAT
10730   IF NOT (Won% OR Lost%) THEN PROC_CHECK_TIME(FALSE)
10740   IF NOT (Won% OR Lost%) THEN PROC_COMMON_CHOICES
10750   SkipEvents% = FALSE
10760 UNTIL Won% OR Lost%
10770 ENDPROC
10780 :
10790 REM :::::::::::::
10800 REM :: Welcome ::
10810 REM :::::::::::::
10820 DEF PROC_WELCOME
10830 CLS
10840 PRINT TAB(0, 4);:PROC_CENTER(CHR$(17)+CHR$(FG%)+"* "+CHR$(17)+CHR$(RED)+"DEATH HOUSE"+CHR$(17)+CHR$(FG%)+" *")
10850 PRINT TAB(0, 6);:PROC_CENTER("by ")
10860 PRINT TAB(0, 8);:PROC_CENTER("Mark S. Boucher")
10870 PROC_CLOCKWISE_BOX((FN_MIN(CW%, 40) - 17) DIV 2, 3, 17, 7, CYAN)
10880 PROC_ITHOTMK_THEME:PROC_SLEEP(120)
10890 PROC_DEFAULT_COLORS
10900 ENDPROC
10910 :
10920 REM ::::::::::::::
10930 REM :: New game ::
10940 REM ::::::::::::::
10950 DEF PROC_NEW_GAME
10960 Won% = FALSE:Lost% = FALSE:SkipEvents% = TRUE:SkipRandom% = FALSE:OneAM% = FALSE
10970 ENDPROC
10980 :
10990 REM ::::::::::::::::::
11000 REM :: Who are you? ::
11010 REM ::::::::::::::::::
11020 DEF PROC_IDENTIFY_YOURSELF
11030 CLS:PRINT TAB(0, 16)"What is your first name? ";
11040 Name$ = FN_RTRIM(FN_PROMPT_FOR_LETTERS(12)):REM Cap the length of name to be 12 characters
11050 ENDPROC
11060 :
11070 REM ::::::::::::::::::::::::::::::
11080 REM :: Skip Introduction Prompt ::
11090 REM ::::::::::::::::::::::::::::::
11100 DEF FN_SKIP_INTRO
11110 LOCAL message$, r$, y%
11120 message$ = "Skip introduction? (Y/N)":y% = VPOS + 1
11130 PROC_EMPTY_KEYBOARD_BUFFER
11140 REPEAT
11150   r$ = FN_PROMPT(0, y%, message$, "")
11160   IF "0" = r$ THEN SkipRandom% = (NOT SkipRandom%):PROC_SOUND(197 + SkipRandom% * 96, 12)
11170 UNTIL INSTR("YN", r$) <> 0
11180 := r$
11190 :
11200 REM ::::::::::::::::::
11210 REM :: Introduction ::
11220 REM ::::::::::::::::::
11230 DEF PROC_INTRO
11240 CLS:PROC_DISPLAY_TEXT("11")
11250 ENDPROC
11260 :
11270 REM ::::::::::::::::::::::::::
11280 REM :: Initial text of game ::
11290 REM ::::::::::::::::::::::::::
11300 DEF PROC_INITIAL_TEXT
11310 TIME = FN_SET_TIME(12,0,0)
11320 CLS:PROC_DISPLAY_TEXT("27")
11330 ENDPROC
11340 :
11350 REM :::::::::::::::::::::::::::::::::::
11360 REM :: Common available game actions ::
11370 REM :::::::::::::::::::::::::::::::::::
11380 DEF PROC_COMMON_CHOICES
11390 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
11400 AC$(1)="Check the time"
11410 AC$(2)="Sleep"
11420 AC$(3)="Examine the room"
11430 BR% = FN_MAKE_CHOICE("Well, "+Name$+", what will you do now?", 3)
11440 ON BR% PROC_CHECK_TIME(TRUE), PROC_GET_IN_BED, PROC_EXPLORE_ROOM
11450 ENDPROC
11460 :
11470 REM ::::::::::::::::
11480 REM :: Get in bed ::
11490 REM ::::::::::::::::
11500 DEF PROC_GET_IN_BED
11510 CLS:PROC_DISPLAY_TEXT("52")
11520 BR% = FN_RND_INT(1, 4)
11530 ON BR% PROC_HARD_PILLOW,PROC_STRANGLED,PROC_NOT_SLEEPY,PROC_GET_OUT_OF_MY_BED
11540 ENDPROC
11550 :
11560 REM :::::::::::::::::
11570 REM :: Hard pillow ::
11580 REM :::::::::::::::::
11590 DEF PROC_HARD_PILLOW
11600 CLS:PROC_DISPLAY_TEXT("88")
11610 AC$(1)="Grab item"
11620 AC$(2)="Ignore it"
11630 BR% = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
11640 ON BR% PROC_ITEM_UNDER_PILLOW,PROC_GET_OUT_OF_MY_BED
11650 ENDPROC
11660 :
11670 REM :::::::::::::::::::::::
11680 REM :: Item under pillow ::
11690 REM :::::::::::::::::::::::
11700 DEF PROC_ITEM_UNDER_PILLOW
11710 BR% = FN_RND_INT(1, 2)
11720 ON BR% PROC_BRICK_UNDER_PILLOW,PROC_SNAKE_UNDER_PILLOW
11730 ENDPROC
11740 :
11750 REM ::::::::::::::::::::::::
11760 REM :: Brick under pillow ::
11770 REM ::::::::::::::::::::::::
11780 DEF PROC_BRICK_UNDER_PILLOW
11790 CLS:PROC_DISPLAY_TEXT("39")
11800 PROC_NOT_SLEEPY
11810 ENDPROC
11820 :
11830 REM :::::::::::::::::::::::::::::
11840 REM :: Snake underneath pillow ::
11850 REM :::::::::::::::::::::::::::::
11860 DEF PROC_SNAKE_UNDER_PILLOW
11870 CLS:PROC_DISPLAY_TEXT("47")
11880 PROC_DEATH
11890 ENDPROC
11900 :
11910 REM ::::::::::::::::::::::
11920 REM :: Strangled in bed ::
11930 REM ::::::::::::::::::::::
11940 DEF PROC_STRANGLED
11950 CLS:PROC_DISPLAY_TEXT("92")
11960 PROC_DEATH
11970 ENDPROC
11980 :
11990 REM ::::::::::::::::
12000 REM :: Not sleepy ::
12010 REM ::::::::::::::::
12020 DEF PROC_NOT_SLEEPY
12030 CLS:PROC_DISPLAY_TEXT("16")
12040 ENDPROC
12050 :
12060 REM :::::::::::::::::::::::
12070 REM :: Get out of my bed ::
12080 REM :::::::::::::::::::::::
12090 DEF PROC_GET_OUT_OF_MY_BED
12100 CLS:PROC_DISPLAY_TEXT("41")
12110 ENDPROC
12120 :
12130 REM :::::::::::::::::::::
12140 REM :: Explore bedroom ::
12150 REM :::::::::::::::::::::
12160 DEF PROC_EXPLORE_ROOM
12170 AC$(1)="North wall"
12180 AC$(2)="South wall"
12190 AC$(3)="East wall"
12200 AC$(4)="West wall"
12210 BR% = FN_MAKE_CHOICE("Which part of the bedroom, "+Name$+"?", 4)
12220 ON BR% PROC_NORTH_WALL, PROC_SOUTH_WALL, PROC_EAST_WALL, PROC_WEST_WALL
12230 ENDPROC
12240 :
12250 REM ::::::::::::::::::::::::
12260 REM :: Explore north wall ::
12270 REM ::::::::::::::::::::::::
12280 DEF PROC_NORTH_WALL
12290 CLS:PROC_DISPLAY_TEXT("04")
12300 BR% = FN_RND_INT(1, 3)
12310 ON BR% PROC_PIT,PROC_DISTRACTED,PROC_NORTH_WALL_CHOICES
12320 ENDPROC
12330 :
12340 REM :::::::::::::::::::
12350 REM :: Fall into pit ::
12360 REM :::::::::::::::::::
12370 DEF PROC_PIT
12380 CLS:PROC_DISPLAY_TEXT("38")
12390 PROC_DEATH
12400 ENDPROC
12410 :
12420 REM ::::::::::::::::
12430 REM :: Distracted ::
12440 REM ::::::::::::::::
12450 DEF PROC_DISTRACTED
12460 CLS:PROC_DISPLAY_TEXT("73")
12470 PROC_EXPLORE_ROOM
12480 ENDPROC
12490 :
12500 REM :::::::::::::::::::::::::::::
12510 REM :: North wall game actions ::
12520 REM :::::::::::::::::::::::::::::
12530 DEF PROC_NORTH_WALL_CHOICES
12540 AC$(1)="Desk"
12550 AC$(2)="Window"
12560 AC$(3)="Gramophone"
12570 BR% = FN_MAKE_CHOICE("Which area first, "+Name$+"?", 3)
12580 ON BR% PROC_EXAMINE_DESK, PROC_INSPECT_WINDOW, PROC_GRAMOPHONE
12590 ENDPROC
12600 :
12610 REM ::::::::::::::::::::::::
12620 REM :: Explore south wall ::
12630 REM ::::::::::::::::::::::::
12640 DEF PROC_SOUTH_WALL
12650 CLS:PROC_DISPLAY_TEXT("13")
12660 BR% = FN_RND_INT(1, 4)
12670 ON BR% PROC_SOUTH_WALL_CHOICES, PROC_SOUTH_WALL_CHOICES, PROC_GRABBED_FROM_BEHIND, PROC_SOUTH_WALL_CHOICES
12680 ENDPROC
12690 :
12700 REM :::::::::::::::::::::::::
12710 REM :: Grabbed from behind ::
12720 REM :::::::::::::::::::::::::
12730 DEF PROC_GRABBED_FROM_BEHIND
12740 CLS:PROC_DISPLAY_TEXT("49")
12750 PROC_HIDEOUS_THING
12760 ENDPROC
12770 :
12780 REM :::::::::::::::::::::::::::::
12790 REM :: South wall game actions ::
12800 REM :::::::::::::::::::::::::::::
12810 DEF PROC_SOUTH_WALL_CHOICES
12820 AC$(1)="Door"
12830 AC$(2)="Washstand"
12840 BR% = FN_MAKE_CHOICE("What will you search, "+Name$+"?", 2)
12850 ON BR% PROC_EXAMINE_DOOR, PROC_EXAMINE_WASHSTAND
12860 ENDPROC
12870 :
12880 REM ::::::::::::::::::
12890 REM :: Examine Door ::
12900 REM ::::::::::::::::::
12910 DEF PROC_EXAMINE_DOOR
12920 CLS:PROC_DISPLAY_TEXT("65")
12930 ENDPROC
12940 :
12950 REM :::::::::::::::::::::::
12960 REM :: Examine washstand ::
12970 REM :::::::::::::::::::::::
12980 DEF PROC_EXAMINE_WASHSTAND
12990 CLS:PROC_DISPLAY_TEXT("31")
13000 AC$(1)="Look in mirror"
13010 AC$(2)="Check something else"
13020 BR% = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
13030 ON BR% PROC_LOOK_IN_MIRROR, PROC_EXPLORE_ROOM
13040 ENDPROC
13050 :
13060 REM :::::::::::::::::::::::
13070 REM :: Explore east wall ::
13080 REM :::::::::::::::::::::::
13090 DEF PROC_EAST_WALL
13100 AC$(1)="Check bookcase"
13110 AC$(2)="Examine fireplace"
13120 BR% = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
13130 ON BR% PROC_EXAMINE_BOOKCASE, PROC_EXAMINE_FIREPLACE
13140 ENDPROC
13150 :
13160 REM ::::::::::::::::::::::
13170 REM :: Examine bookcase ::
13180 REM ::::::::::::::::::::::
13190 DEF PROC_EXAMINE_BOOKCASE
13200 CLS:PROC_DISPLAY_TEXT("46")
13210 AC$(1)="Take book"
13220 AC$(2)="Examine fireplace"
13230 AC$(3)="Examine another area"
13240 BR% = FN_MAKE_CHOICE("What now, "+Name$+"?", 3)
13250 ON BR% PROC_TAKE_BOOK, PROC_EXAMINE_FIREPLACE, PROC_EXPLORE_ROOM
13260 ENDPROC
13270 :
13280 REM :::::::::::::::::::
13290 REM :: Take the book ::
13300 REM :::::::::::::::::::
13310 DEF PROC_TAKE_BOOK
13320 BR% = FN_RND_INT(1, 2)
13330 ON BR% PROC_TAKE_BOOK_TRAP_DOOR, PROC_READ_BOOK
13340 ENDPROC
13350 :
13360 REM ::::::::::::::::::::::::::::::::
13370 REM :: Taking Book Activates Trap ::
13380 REM ::::::::::::::::::::::::::::::::
13390 DEF PROC_TAKE_BOOK_TRAP_DOOR
13400 CLS:PROC_DISPLAY_TEXT("19")
13410 PROC_DEATH
13420 ENDPROC
13430 :
13440 REM :::::::::::::::
13450 REM :: Read Book ::
13460 REM :::::::::::::::
13470 DEF PROC_READ_BOOK
13480 CLS:PROC_DISPLAY_TEXT("71")
13490 PROC_EXAMINE_FIREPLACE
13500 ENDPROC
13510 :
13520 REM :::::::::::::::::::::::
13530 REM :: Examine Fireplace ::
13540 REM :::::::::::::::::::::::
13550 DEF PROC_EXAMINE_FIREPLACE
13560 CLS:PROC_DISPLAY_TEXT("84")
13570 BR% = FN_RND_INT(1, 2)
13580 ON BR% PROC_DANGER_SENSE, PROC_IN_FIREPLACE
13590 ENDPROC
13600 :
13610 REM :::::::::::::::::::::
13620 REM :: Sense of danger ::
13630 REM :::::::::::::::::::::
13640 DEF PROC_DANGER_SENSE
13650 CLS:PROC_DISPLAY_TEXT("03")
13660 ENDPROC
13670 :
13680 REM :::::::::::::::::::::::::::
13690 REM :: Roasting in fireplace ::
13700 REM :::::::::::::::::::::::::::
13710 DEF PROC_IN_FIREPLACE
13720 CLS:PROC_DISPLAY_TEXT("55")
13730 PROC_DEATH
13740 ENDPROC
13750 :
13760 REM :::::::::::::::::::::::::::::
13770 REM :: Exploring the west wall ::
13780 REM :::::::::::::::::::::::::::::
13790 DEF PROC_WEST_WALL
13800 CLS:PROC_DISPLAY_TEXT("32")
13810 AC$(1)="Get in bed"
13820 AC$(2)="Examine another area"
13830 BR% = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
13840 ON BR% PROC_GET_IN_BED, PROC_EXPLORE_ROOM
13850 ENDPROC
13860 :
13870 REM ::::::::::::::::::
13880 REM :: Examine desk ::
13890 REM ::::::::::::::::::
13900 DEF PROC_EXAMINE_DESK
13910 CLS:PROC_DISPLAY_TEXT("53")
13920 PROC_DESK_CHOICES
13930 ENDPROC
13940 :
13950 REM :::::::::::::::::::::::
13960 REM :: Desk game actions ::
13970 REM :::::::::::::::::::::::
13980 DEF PROC_DESK_CHOICES
13990 AC$(1)="Read note"
14000 AC$(2)="Search drawers"
14010 AC$(3)="Check time"
14020 AC$(4)="Search another area"
14030 BR% = FN_MAKE_CHOICE("What now, "+Name$+"?", 4)
14040 ON BR% PROC_READ_NOTE, PROC_SEARCH_DRAWERS, PROC_CHECK_TIME(TRUE), PROC_SEARCH_ANOTHER_AREA
14050 ENDPROC
14060 :
14070 REM :::::::::::::::::::::::::::::::
14080 REM :: Read the note on the desk ::
14090 REM :::::::::::::::::::::::::::::::
14100 DEF PROC_READ_NOTE
14110 CLS:PROC_DISPLAY_TEXT("99")
14120 PROC_INSPECT_WINDOW
14130 ENDPROC
14140 :
14150 REM :::::::::::::::::::::::::::::
14160 REM :: Search the desk drawers ::
14170 REM :::::::::::::::::::::::::::::
14180 DEF PROC_SEARCH_DRAWERS
14190 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
14200 BR% = FN_RND_INT(1, 2)
14210 ON BR% PROC_SEVERED_HEAD, PROC_EMPTY_DRAWERS
14220 ENDPROC
14230 :
14240 REM ::::::::::::::::::
14250 REM :: Severed head ::
14260 REM:::::::::::::::::::
14270 DEF PROC_SEVERED_HEAD
14280 CLS:PROC_DISPLAY_TEXT("48")
14290 PROC_DEATH
14300 ENDPROC
14310 :
14320 REM ::::::::::::::::::::::::
14330 REM :: Empty desk drawers ::
14340 REM ::::::::::::::::::::::::
14350 DEF PROC_EMPTY_DRAWERS
14360 CLS:PROC_DISPLAY_TEXT("06")
14370 PROC_DESK_CHOICES
14380 ENDPROC
14390 :
14400 REM :::::::::::::::::::::::
14410 REM :: Noise from behind ::
14420 REM :::::::::::::::::::::::
14430 DEF PROC_NOISE_FROM_BEHIND
14440 CLS:PROC_DISPLAY_TEXT("21")
14450 ENDPROC
14460 :
14470 REM ::::::::::::::::::::::::::::::::::::::::
14480 REM :: Search another area of the bedroom ::
14490 REM ::::::::::::::::::::::::::::::::::::::::
14500 DEF PROC_SEARCH_ANOTHER_AREA
14510 CLS:PROC_SUSPENSE(20, ASC("-"), 20)
14520 PROC_EXPLORE_ROOM
14530 ENDPROC
14540 :
14550 REM ::::::::::::::::::::
14560 REM :: Inspect window ::
14570 REM ::::::::::::::::::::
14580 DEF PROC_INSPECT_WINDOW
14590 CLS:PROC_DISPLAY_TEXT("12")
14600 BR% = FN_RND_INT(1, 3)
14610 ON BR% PROC_WINDOW_ATTACK,PROC_NOTHING_THERE,PROC_NOISE_FROM_BEHIND
14620 ENDPROC
14630 :
14640 REM ::::::::::::::::::::::::::::
14650 REM :: Attacked at the window ::
14660 REM ::::::::::::::::::::::::::::
14670 DEF PROC_WINDOW_ATTACK
14680 CLS:PROC_DISPLAY_TEXT("40")
14690 PROC_DEATH
14700 ENDPROC
14710 :
14720 REM :::::::::::::::::::::::::
14730 REM :: Nothing of interest ::
14740 REM :::::::::::::::::::::::::
14750 DEF PROC_NOTHING_THERE
14760 CLS:PROC_DISPLAY_TEXT("18")
14770 PROC_GRAMOPHONE
14780 ENDPROC
14790 :
14800 REM ::::::::::::::::::::::::::::
14810 REM :: Examine the gramophone ::
14820 REM ::::::::::::::::::::::::::::
14830 DEF PROC_GRAMOPHONE
14840 CLS:PROC_DISPLAY_TEXT("61")
14850 BR% = FN_RND_INT(1, 2)
14860 ON BR% PROC_FUNERAL_MARCH, PROC_NO_TIME_TO_WASTE
14870 ENDPROC
14880 :
14890 REM :::::::::::::::::::::::::::::::::::::
14900 REM :: Funeral march on the gramophone ::
14910 REM :::::::::::::::::::::::::::::::::::::
14920 DEF PROC_FUNERAL_MARCH
14930 CLS:PROC_DISPLAY_TEXT("2A")
14940 PROC_FUNERAL_MARCH_THEME:PROC_SLEEP(200)
14950 CLS:PROC_DISPLAY_TEXT("2B")
14960 ENDPROC
14970 :
14980 REM ::::::::::::::::::::::
14990 REM :: No time to waste ::
15000 REM ::::::::::::::::::::::
15010 DEF PROC_NO_TIME_TO_WASTE
15020 CLS:PROC_DISPLAY_TEXT("94")
15030 ENDPROC
15040 :
15050 REM ::::::::::::::::::::
15060 REM :: Look in mirror ::
15070 REM ::::::::::::::::::::
15080 DEF PROC_LOOK_IN_MIRROR
15090 BR% = FN_RND_INT(1, 2)
15100 ON BR% PROC_POISON_MIST, PROC_ROOM_SPINNING
15110 ENDPROC
15120 :
15130 REM :::::::::::::::::
15140 REM :: Poison mist ::
15150 REM :::::::::::::::::
15160 DEF PROC_POISON_MIST
15170 CLS:PROC_DISPLAY_TEXT("66")
15180 PROC_DEATH
15190 ENDPROC
15200 :
15210 REM ::::::::::::::::::::::
15220 REM :: Room is spinning ::
15230 REM ::::::::::::::::::::::
15240 DEF PROC_ROOM_SPINNING
15250 CLS:PROC_DISPLAY_TEXT("07")
15260 PROC_TZ_THEME:PROC_SLEEP(200)
15270 PROC_INITIAL_TEXT
15280 ENDPROC
15290 :
15300 REM :::::::::::::::::::::::::::
15310 REM :: Hit a key to continue ::
15320 REM :::::::::::::::::::::::::::
15330 DEF PROC_CONTINUE
15340 PRINT:PROC_CENTER(FN_RVS(FG%,BG%,"Hit a key to continue"))
15350 Dummy% = FN_HIT_A_KEY
15360 ENDPROC
15370 :
15380 REM :::::::::::::::::::::::::::::::::::::::
15390 REM :: Announce the current running time ::
15400 REM :::::::::::::::::::::::::::::::::::::::
15410 DEF PROC_ANNOUNCE_TIME(ti$)
15420 IF NOT LEN(ti$) THEN ti$ = FN_FORMAT_TIME(TRUE)
15430 PROC_WRITE_TEXT_BUFFER(CHR$(17)+CHR$(YELLOW)+ti$+" AM"+CHR$(17)+CHR$(FG%)+"."+CHR$(NL))
15440 ENDPROC
15450 :
15460 REM ::::::::::::::::::::::::::::::::::::
15470 REM :: Check the current running time ::
15480 REM ::::::::::::::::::::::::::::::::::::
15490 DEF PROC_CHECK_TIME(announceTime%)
15500 LOCAL c%, h%, m%, ti$
15510 ti$ = FN_FORMAT_TIME(TRUE):c% = INSTR(ti$, ":"):h% = VAL(LEFT$(ti$, c% - 1)):m% = VAL(RIGHT$(ti$, LEN(ti$) - c%))
15520 IF h% > 12 THEN OneAM% = TRUE:ti$ = STR$(h% - 12) + ":00":ELSE ti$ = STR$(h%) + ":" + STR$(m%)
15530 IF announceTime% AND NOT OneAM% THEN CLS:PROC_ERASE_TEXT_BUFFER:PROC_ANNOUNCE_TIME(ti$):PROC_ALL_TEXT
15540 IF OneAM% THEN PROC_ONE_AM:ELSE IF NOT (SkipEvents% AND SkipRandom%) THEN PROC_RANDOM_EVENT
15550 ENDPROC
15560 :
15570 REM ::::::::::::::::::
15580 REM :: Random Event ::
15590 REM ::::::::::::::::::
15600 DEF PROC_RANDOM_EVENT
15610 BR% = FN_RND_INT(1, 6):SkipEvents% = TRUE
15620 ON BR% PROC_IGNORE,PROC_DEATHLY_COLD_HAND,PROC_FEELING_SLEEPY,PROC_SHADOW_AT_WINDOW,PROC_EVIL_VOICE,PROC_NOISE_FROM_BEHIND
15630 ENDPROC
15640 :
15650 REM ::::::::::::::::
15660 REM :: Evil voice ::
15670 REM ::::::::::::::::
15680 DEF PROC_EVIL_VOICE
15690 CLS:PROC_DISPLAY_TEXT("37")
15700 ENDPROC
15710 :
15720 REM ::::::::::::::::::::::::::
15730 REM :: Shadow at the window ::
15740 REM ::::::::::::::::::::::::::
15750 DEF PROC_SHADOW_AT_WINDOW
15760 CLS:PROC_DISPLAY_TEXT("76")
15770 AC$(1)="Look out window"
15780 AC$(2)="Ignore it"
15790 BR% = FN_MAKE_CHOICE("What now, "+Name$+"?", 2)
15800 ON BR% PROC_LOOK_OUT_WINDOW, PROC_IGNORE_WINDOW_SHADOW
15810 ENDPROC
15820 :
15830 REM :::::::::::::::::::::::::
15840 REM :: Look out the window ::
15850 REM :::::::::::::::::::::::::
15860 DEF PROC_LOOK_OUT_WINDOW
15870 BR% = FN_RND_INT(1, 3)
15880 ON BR% PROC_TURN_AROUND, PROC_MOONLIGHT_SHADOW, PROC_MOONLIT_VIEW
15890 ENDPROC
15900 :
15910 REM ::::::::::::::::::::::
15920 REM :: Moonlight shadow ::
15930 REM ::::::::::::::::::::::
15940 DEF PROC_MOONLIGHT_SHADOW
15950 CLS:PROC_DISPLAY_TEXT("97")
15960 ENDPROC
15970 :
15980 REM ::::::::::::::::::
15990 REM :: Moonlit view ::
16000 REM ::::::::::::::::::
16010 DEF PROC_MOONLIT_VIEW
16020 CLS:PROC_DISPLAY_TEXT("24")
16030 ENDPROC
16040 :
16050 REM :::::::::::::::::::::::::::::::::
16060 REM :: Ignore shadow at the window ::
16070 REM :::::::::::::::::::::::::::::::::
16080 DEF PROC_IGNORE_WINDOW_SHADOW
16090 BR% = FN_RND_INT(1, 2)
16100 ON BR% PROC_GETTING_BRAVE, PROC_NOTHING_AT_WINDOW
16110 ENDPROC
16120 :
16130 REM :::::::::::::::::::
16140 REM :: Getting brave ::
16150 REM :::::::::::::::::::
16160 DEF PROC_GETTING_BRAVE
16170 CLS:PROC_DISPLAY_TEXT("08")
16180 ENDPROC
16190 :
16200 REM :::::::::::::::::::::::
16210 REM :: Nothing at window ::
16220 REM :::::::::::::::::::::::
16230 DEF PROC_NOTHING_AT_WINDOW
16240 CLS:PROC_DISPLAY_TEXT("59")
16250 ENDPROC
16260 :
16270 REM ::::::::::::::::::::
16280 REM :: Feeling sleepy ::
16290 REM ::::::::::::::::::::
16300 DEF PROC_FEELING_SLEEPY
16310 CLS:PROC_DISPLAY_TEXT("67")
16320 PROC_GET_IN_BED
16330 ENDPROC
16340 :
16350 REM :::::::::::::::::::::::
16360 REM :: Deathly-cold hand ::
16370 REM :::::::::::::::::::::::
16380 DEF PROC_DEATHLY_COLD_HAND
16390 CLS:PROC_DISPLAY_TEXT("80")
16400 PROC_DEATHLY_COLD_HAND_CHOICES
16410 ENDPROC
16420 :
16430 REM ::::::::::::::::::::::::::::::::::::::
16440 REM :: Deathly-cold hand gaming actions ::
16450 REM ::::::::::::::::::::::::::::::::::::::
16460 DEF PROC_DEATHLY_COLD_HAND_CHOICES
16470 AC$(1)="Turn around & look"
16480 AC$(2)="Run!"
16490 AC$(3)="Ignore it"
16500 BR% = FN_MAKE_CHOICE("What now, "+Name$+"?", 3)
16510 ON BR% PROC_TURN_AROUND, PROC_RUN, PROC_IGNORE
16520 ENDPROC
16530 :
16540 REM ::::::::::::::::::::::::::
16550 REM :: Turn around and look ::
16560 REM ::::::::::::::::::::::::::
16570 DEF PROC_TURN_AROUND
16580 BR% = FN_RND_INT(1, 4)
16590 ON BR% PROC_NOBODY_BEHIND_YOU, PROC_NOBODY_BEHIND_YOU, PROC_HIDEOUS_THING, PROC_NOBODY_BEHIND_YOU
16600 ENDPROC
16610 :
16620 REM :::::::::::::::::::::::::::::
16630 REM :: Hideous thing to behold ::
16640 REM :::::::::::::::::::::::::::::
16650 DEF PROC_HIDEOUS_THING
16660 CLS:PROC_DISPLAY_TEXT("95")
16670 PROC_DEATH
16680 ENDPROC
16690 :
16700 REM ::::::::::::
16710 REM :: Ignore ::
16720 REM ::::::::::::
16730 DEF PROC_IGNORE
16740 ENDPROC
16750 :
16760 REM ::::::::::::::::
16770 REM :: Run for it ::
16780 REM ::::::::::::::::
16790 DEF PROC_RUN
16800 CLS:PROC_DISPLAY_TEXT("09")
16810 PROC_DEATHLY_COLD_HAND_CHOICES
16820 ENDPROC
16830 :
16840 REM :::::::::::::::::::::::
16850 REM :: Nobody behind you ::
16860 REM :::::::::::::::::::::::
16870 DEF PROC_NOBODY_BEHIND_YOU
16880 CLS:PROC_DISPLAY_TEXT("05")
16890 ENDPROC
16900 :
16910 REM :::::::::::::::::
16920 REM :: One O'Clock ::
16930 REM :::::::::::::::::
16940 DEF PROC_ONE_AM
16950 CLS:PROC_DISPLAY_TEXT("60")
16960 AC$(1) = "Yes"
16970 AC$(2) = "No"
16980 BR% = FN_MAKE_CHOICE("Would you care to join me for tea, "+Name$+", before you go?", 2)
16990 ON BR% PROC_TREACHERY, PROC_SURVIVED
17000 ENDPROC
17010 :
17020 REM :::::::::::::::::::::::::
17030 REM :: Survived the ordeal ::
17040 REM :::::::::::::::::::::::::
17050 DEF PROC_SURVIVED
17060 CLS:PROC_DISPLAY_TEXT("2C")
17070 PROC_WERE_IN_THE_MONEY_THEME:PROC_SLEEP(250)
17080 CLS:PROC_DISPLAY_TEXT("2D")
17090 Won% = TRUE
17100 ENDPROC
17110 :
17120 REM :::::::::::::::
17130 REM :: Treachery ::
17140 REM :::::::::::::::
17150 DEF PROC_TREACHERY
17160 CLS:PROC_DISPLAY_TEXT("70")
17170 PROC_GOOD_EVENING_FRIENDS_THEME:PROC_SLEEP(250)
17180 PROC_DEATH
17190 ENDPROC
17200 :
17210 REM :::::::::::
17220 REM :: Death ::
17230 REM :::::::::::
17240 DEF PROC_DEATH
17250 CLS:PROC_DISPLAY_TEXT("6A")
17260 PROC_FLASH_SCREEN(8, 20)
17270 PROC_DEFAULT_COLORS
17280 CLS:PROC_DISPLAY_TEXT("6B")
17290 PROC_FUNERAL_MARCH_THEME
17300 Lost% = TRUE
17310 ENDPROC
17320 :
17330 REM :::::::::::::::::
17340 REM ::  Game Over  ::
17350 REM :::::::::::::::::
17360 DEF PROC_GAME_OVER
17370 LOCAL co%, m%, msg$
17380 m% = VAL(FN_FORMAT_TIME(FALSE)) - 1200:IF m% > 100 THEN m% = m% - 40
17390 CLS:PROC_ERASE_TEXT_BUFFER
17400 IF Lost% THEN co% = RED:msg$ = "So sorry! You lost.":ELSE co% = GREEN:msg$ = "Congratulations! You won."
17410 PROC_WRITE_TEXT_BUFFER(STRING$(FN_CENTER(msg$), CHR$(BLANK))+CHR$(17)+CHR$(co%)+msg$+CHR$(17)+CHR$(FG%)+CHR$(NL))
17420 PROC_WRITE_TEXT_BUFFER(Name$+", you survived for "+STR$(m%)+" minutes."+CHR$(FF))
17430 PROC_ALL_TEXT
17440 ENDPROC
17450 :
17460 REM :::::::::::::::::::::::
17470 REM :: Play Another Game ::
17480 REM :::::::::::::::::::::::
17490 DEF FN_PLAY_AGAIN
17500 AC$(1) = "No"
17510 AC$(2) = "Yes"
17520 := FN_MAKE_CHOICE("Would you like to play again?", 2)
17530 :
17540 REM :::::::::::::::::
17550 REM :: Say Goodbye ::
17560 REM :::::::::::::::::
17570 DEF PROC_GOODBYE(game$)
17580 PROC_HIDE_CURSOR
17590 CLS:PROC_FULL_CENTER_TEXT("So long and thank you for playing...")
17600 FOR i% = 0 TO FN_CENTER(game$) - 1:PRINTTAB(0, CH% DIV 2 + 2)STRING$(i%, " ")CHR$(17)CHR$(i% MOD 7 + 1)game$:PROC_SLEEP(20):NEXT i%
17610 PROC_DEFAULT_COLORS
17620 PROC_SHOW_CURSOR
17630 ENDPROC
17640 :
17650 REM ::::::::::::::::::::::::::
17660 REM :: Display text passage ::
17670 REM ::::::::::::::::::::::::::
17680 DEF PROC_DISPLAY_TEXT(passage$)
17690 PROC_WORD_WRAPF(1, 1, CW% - 2, CH% - 2, passage$)
17700 ENDPROC
17710 :
17720 REM ::::::::::::::::::::::::::::::::::::::
17730 REM :: Display all text buffer contents ::
17740 REM ::::::::::::::::::::::::::::::::::::::
17750 DEF PROC_ALL_TEXT
17760 PROC_WORD_WRAP(1, 1, CW% - 2, CH% - 2, FN_READ_TEXT_BUFFER(0))
17770 ENDPROC
17780 :
17790 REM :::::::::::::::::::::::::::::::::::::::::::::
17800 REM :: Is character position outside of width? ::
17810 REM :::::::::::::::::::::::::::::::::::::::::::::
17820 DEF FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x%)
17830 := (x% > (ux% + width%))
17840 :
17850 REM :::::::::::::::::::::::::::::
17860 REM :: Process a special token ::
17870 REM :::::::::::::::::::::::::::::
17880 DEF FN_PROCESS_SPECIAL_TOKEN(text$)
17890 LOCAL r$
17900 r$ = FN_XSTRING$(text$, ":NM:", Name$):REM Inject player's name
17910 r$ = FN_XSTRING$(r$, ":TM:", FN_FORMAT_TIME(TRUE)):REM Inject current time
17920 := r$
17930 :
17940 REM :::::::::::::::::::::::::::::::::::::
17950 REM :: Is it a special character code? ::
17960 REM :::::::::::::::::::::::::::::::::::::
17970 DEF FN_IS_SPECIAL(ch%)
17980 := (ch% = BLANK OR ch% = NL OR ch% = C_TAB OR ch% = CR OR ch% = FF OR ch% = DOT OR ch% = DASH OR ch% = QST OR ch% = EX)
17990 :
18000 REM ::::::::::::::::::::::::::::::::::::::::
18010 REM :: Handle when a new page is required ::
18020 REM ::::::::::::::::::::::::::::::::::::::::
18030 DEF PROC_HANDLE_NEW_PAGE(ux%, uy%, width%, height%)
18040 PROC_CONTINUE
18050 PROC_WIPE_TEXT(ux%, uy%, width%, height%)
18060 PROC_TEXT_BOUNDING_BOX(ux%, uy%, width%, height%)
18070 ENDPROC
18080 :
18090 REM ::::::::::::::::::::::::::::::::::::
18100 REM :: Handle special character codes ::
18110 REM ::::::::::::::::::::::::::::::::::::
18120 DEF PROC_HANDLE_SPECIAL(ux%, uy%, width%, height%, ch%)
18130 LOCAL c%, delay%, i%, isOverflow%, n%, newPage%, x%, y%
18140 c% = 0:n% = 1:delay% = 0:newPage% = FALSE:isOverFlow% = FALSE:x% = POS:y% = VPOS
18150 IF DASH = ch% THEN c% = ch%
18160 IF BLANK = ch% THEN delay% = 30:IF x% > ux% AND x% < ux% + width% THEN c% = ch%
18170 IF DOT = ch% OR EX = ch% THEN delay% = 100:c% = ch%
18180 IF QST = ch% THEN delay% = 150:c% = ch%
18190 IF C_TAB = ch% AND NOT FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x% + 1) THEN c% = BLANK:n% = 2
18200 IF FF = ch% THEN newPage% = TRUE
18210 IF NL = ch% OR CR = ch% OR FN_IS_OVER_FLOW(ux%, uy%, width%, height%, x%) THEN isOverFlow% = TRUE
18220 IF isOverFlow% THEN x% = ux%:y% = y% + 1 + (NL = ch% OR CR = ch%)* -1:IF y% > (height% - 2) THEN newPage% = TRUE
18230 IF newPage% THEN PRINT:PROC_HANDLE_NEW_PAGE(ux%, uy%, width%, height%):y% = uy%:x% = ux%
18240 FOR i% = 1 TO n%
18250   PRINT TAB(x%, y%);
18260   IF c% > 0 THEN PRINT CHR$(c%);
18270   PROC_SLEEP(delay%)
18280 NEXT i%
18290 ENDPROC
18300 :
18310 REM :::::::::::::::::::::::::::::::::::::::
18320 REM :: Display text streamed from a file ::
18330 REM :: inside of a word-wrapped box      ::
18340 REM :::::::::::::::::::::::::::::::::::::::
18350 DEF PROC_WORD_WRAPF(ux%, uy%, width%, height%, passage$)
18360 LOCAL ch%, i%, infile%, len%, special%, word$, wordLen%, wordStart%, x%, y%
18370 PROC_TEXT_BOUNDING_BOX(ux%, uy%, width%, height%)
18380 infile% = OPENIN("data/dat"+passage$+".bin")
18390 len% = EXT#infile%:wordStart% = 0:wordLen% = 0:word$ = ""
18400 x% = ux%:y% = uy%:REM Begin from specified starting row
18410 FOR i% = 1 TO len%
18420   IF (wordStart% = 0) THEN wordStart% = i%
18430   ch% = BGET#infile%:special% = FN_IS_SPECIAL(ch%)
18440   IF (i% = len% OR special%) THEN word$ = FN_PROCESS_SPECIAL_TOKEN(FN_FILE_READ_CHARS(infile%, wordStart%, 1 + i% - wordStart%)):wordLen% = LEN(word$)
18450   IF (wordLen% > (width% - x% + ux% + (ch% = BLANK)*-1)) THEN y% = y% + 1:x% = ux%
18460   IF (wordLen% > 0) THEN PRINT TAB(x%, y%);LEFT$(word$, wordLen% + (special%));:wordStart% = 0:wordLen% = 0:y% = VPOS:x% = POS:PROC_HANDLE_SPECIAL(ux%, uy%, width%, height%, ASC(RIGHT$(word$, 1))):y% = VPOS:x% = POS
18470 NEXT i%
18480 CLOSE#infile%
18490 ENDPROC
18500 :
18510 REM ::::::::::::::::::::::::::::::::::::::
18520 REM :: Display text in word-wrapped box ::
18530 REM ::::::::::::::::::::::::::::::::::::::
18540 DEF PROC_WORD_WRAP(ux%, uy%, width%, height%, text$)
18550 LOCAL ch%, i%, len%, special%, word$, wordLen%, wordStart%, x%, y%
18560 PROC_TEXT_BOUNDING_BOX(ux%, uy%, width%, height%)
18570 len% = LEN(text$):wordStart% = 0:wordLen% = 0:word$ = ""
18580 x% = ux%:y% = uy%:REM Begin from specified starting row
18590 FOR i% = 1 TO len%
18600   IF (wordStart% = 0) THEN wordStart% = i%
18610   ch% = ASC(MID$(text$, i%, 1)):special% = FN_IS_SPECIAL(ch%)
18620   IF (i% = len% OR special%) THEN word$ = FN_PROCESS_SPECIAL_TOKEN(MID$(text$, wordStart%, 1 + i% - wordStart%)):wordLen% = LEN(word$)
18630   IF (wordLen% > (width% - x% + ux% + (ch% = BLANK)*-1)) THEN y% = y% + 1:x% = ux%
18640   IF (wordLen% > 0) THEN PRINT TAB(x%, y%);LEFT$(word$, wordLen% + (special%));:wordStart% = 0:wordLen% = 0:y% = VPOS:x% = POS:PROC_HANDLE_SPECIAL(ux%, uy%, width%, height%, ASC(RIGHT$(word$, 1))):y% = VPOS:x% = POS
18650 NEXT i%
18660 ENDPROC
18670 :
18680 REM :::::::::::::::::::::::::::::::::::
18690 REM :: Draw bounding box around text ::
18700 REM :::::::::::::::::::::::::::::::::::
18710 DEF PROC_TEXT_BOUNDING_BOX(ux%, uy%, width%, height%)
18720 PROC_CLOCKWISE_BOX(ux% - 1, uy% - 1, width% + 2, height% + 2, CYAN)
18730 PROC_WIPE_TEXT(ux%, uy%, width%, height%)
18740 PROC_DEFAULT_COLORS
18750 ENDPROC
18760 :
18770 REM :::::::::::::::::::::::::::::::
18780 REM :: Prompt for a story action ::
18790 REM :::::::::::::::::::::::::::::::
18800 DEF FN_MAKE_CHOICE(prompt$, count%)
18810 LOCAL bg%, br%, c%, fg%, i%, ni%, ti, y%
18820 PROC_EMPTY_KEYBOARD_BUFFER
18830 CLS
18840 PRINT prompt$:PRINT
18850 ni% = OneAM% OR Won% OR Lost%:br% = (ni%) * -1 + (NOT ni%) *-FN_RND_INT(1, count%):c% = 0:y% = VPOS:ti = TIME:fg% = FG%:bg%= BG%
18860 REPEAT:REM DISPLAY POSSIBLE CHOICES AND GET SELECTION
18870   FOR i% = 1 TO count%
18880     PRINT TAB(0, y% + i% - 1);
18890     IF br% = i% THEN fg% = YELLOW:PRINT FN_RVS(fg%, bg%, AC$(i%)):REM MOVE REVERSE-VIDEO TO NEXT CHOICE
18900     IF br% <> i% THEN fg% = FG%:PRINT CHR$(17)CHR$(bg%+128)CHR$(17)CHR$(fg%)AC$(i%)
18910   NEXT i%
18920   c% = INKEY(1000)
18930   IF c% = DOWN THEN br% = br% MOD count% + 1:REM TEST FOR CURSOR DOWN
18940   IF c% = UP THEN br% = (count% + br% - 2) MOD count% + 1:REM TEST FOR CURSOR UP
18950 UNTIL c% = 13 OR c% = TRUE
18960 PROC_DEFAULT_COLORS
18970 := br%:REM CHOICE SELECTED IS CURRENT BRANCH (i.e. br%)
18980 :
18990 REM ::::::::::::::::::::::::::::::::::::::::::
19000 REM :: Flash the screen with various colors ::
19010 REM ::::::::::::::::::::::::::::::::::::::::::
19020 DEF PROC_FLASH_SCREEN(count%, delay%)
19030 LOCAL i%
19040 FOR i% = 1 TO count%
19050   COLOUR 128+i%:COLOUR BLACK:CLS
19060   PROC_SLEEP(delay%)
19070 NEXT i%
19080 PROC_DEFAULT_COLORS
19090 ENDPROC
19100 :
19110 REM :::::::::::::::::::::::::::::::::::
19120 REM :: Erase contents of text buffer ::
19130 REM :::::::::::::::::::::::::::::::::::
19140 DEF PROC_ERASE_TEXT_BUFFER
19150 TX_Pointer% = 0:REM Reset Pointer to text buffer
19160 $TX = STRING$(TX_SIZE%, CHR$(CR))
19170 ENDPROC
19180 :
19190 REM :::::::::::::::::::::::::::::::::::
19200 REM :: Write text to the text buffer ::
19210 REM :::::::::::::::::::::::::::::::::::
19220 DEF PROC_WRITE_TEXT_BUFFER(text$)
19230 LOCAL i%
19240 IF TX_Pointer% + LEN(text$) > TX_SIZE% THEN ERROR 19, "String too long"
19250 FOR i% = 1 TO LEN(text$)
19260   $(TX + TX_Pointer%) = MID$(text$, i%, 1)
19270   TX_Pointer% = (TX_Pointer% + 1)
19280 NEXT i%
19290 ENDPROC
19300 :
19310 REM ::::::::::::::::::::::::::::::::::::::
19320 REM :: Read text out of the text buffer ::
19330 REM ::::::::::::::::::::::::::::::::::::::
19340 DEF FN_READ_TEXT_BUFFER(pos%)
19350 LOCAL n%, r$
19360 IF pos% > TX_SIZE% THEN ERROR 14, "Reference array incorrect"
19370 r$ = $(TX + pos%)
19380 := r$
19390 :
19400 REM :::::::::::::::::::::::::::::::::::::::::::::
19410 REM :: Read a stream of characters from a file ::
19420 REM :::::::::::::::::::::::::::::::::::::::::::::
19430 DEF FN_FILE_READ_CHARS(infile%, pos%, len%)
19440 LOCAL currentPos%, i%, r$
19450 r$ = "":currentPos% = PTR#infile%
19460 PTR#infile% = pos% - 1
19470 FOR i% = 1 TO len%
19480   r$ = r$ + CHR$(BGET#infile%)
19490 NEXT i%
19500 PTR#infile% = currentPos%:REM Restore file pointer to previous position
19510 := r$
19520 :
19530 REM :::::::::::::::::::::
19540 REM :: Retrieve a byte ::
19550 REM :: register value  ::
19560 REM :: from VDP        ::
19570 REM :::::::::::::::::::::
19580 DEF FN_getByteVDP(var%):A% = &A0:L% = var%:= USR(&FFF4)
19590 :
19600 REM ::::::::::::::::::::::::::::::::::::
19610 REM :: Set the time of the simple RTC ::
19620 REM ::::::::::::::::::::::::::::::::::::
19630 DEF FN_SET_TIME(hours%,minutes%,seconds%)
19640 TIME = hours% * 360000 + minutes% * 6000 + seconds% * 100
19650 := TIME
19660 :
19670 REM :::::::::::::::::::::::::::::
19680 REM :: Format time as a String ::
19690 REM :::::::::::::::::::::::::::::
19700 DEF FN_FORMAT_TIME(addColons%)
19710 LOCAL hours%,minutes%,seconds%,time%,r$
19720 r$ = "":time% = TIME
19730 hours% = time% DIV 360000
19740 minutes% = (time% - hours% * 360000) DIV 6000
19750 seconds% = (time% - hours% * 360000 - minutes% * 6000) DIV 100
19760 r$ = FN_PAD_NUMBER(hours%, 2):IF addColons% THEN r$ = r$ + ":"
19770 r$ = r$ + FN_PAD_NUMBER(minutes%, 2):REM IF addColons% THEN r$ = r$ + ":"
19780 REM r$ = r$ + FN_PAD_NUMBER(seconds%, 2)
19790 := r$
19800 :
19810 REM :::::::::::::::::::::::::::
19820 REM ::   Bounded time ticks  ::
19830 REM :::::::::::::::::::::::::::
19840 DEF FN_INT_TIME:= TIME MOD MAXINT%
19850 :
19860 REM :::::::::::::::::::::::
19870 REM :: Has time reached  ::
19880 REM :: target seconds?   ::
19890 REM :::::::::::::::::::::::
19900 DEF FN_IS_TIME(sec%, prevSec%, targetSec%):= (sec% MOD targetSec% = 0 AND sec% <> prevSec%)
19910 :
19920 REM :::::::::::::::::::::::::::::::::::::::
19930 REM :: Pause execution of the program    ::
19940 REM :: for a number of ticks (1/100) sec ::
19950 REM :::::::::::::::::::::::::::::::::::::::
19960 DEF PROC_SLEEP(hundredth_seconds%):LOCAL t:hundredth_seconds% = hundredth_seconds% + (hundredth_seconds% < 0) * -hundredth_seconds%:t = TIME:REPEAT UNTIL ((TIME - t) > hundredth_seconds%):ENDPROC
19970 :
19980 REM ::::::::::::::::::::::::::::::::
19990 REM :: Return TRUE when random    ::
20000 REM :: value is below given value ::
20010 REM ::::::::::::::::::::::::::::::::
20020 DEF FN_RND_PCT(n%):=RND(1) <= (n% / 100):REM Returns TRUE or FALSE
20030 :
20040 REM :::::::::::::::::::::::::::::::::
20050 REM :: Random Integer Within Range ::
20060 REM :::::::::::::::::::::::::::::::::
20070 DEF FN_RND_INT(lo%, hi%):= INT(RND(1) * (hi% - lo% + 1)) + lo%
20080 :
20090 REM ::::::::::::::::::::::
20100 REM :: Maximum of x & y ::
20110 REM ::::::::::::::::::::::
20120 DEF FN_MAX(x, y):= y + (x > y) * (y - x)
20130 :
20140 REM ::::::::::::::::::::::
20150 REM :: Minimum of x & y ::
20160 REM ::::::::::::::::::::::
20170 DEF FN_MIN(x, y):= y + (x < y) * (y - x)
20180 :
20190 REM ::::::::::::::::::::::
20200 REM ::   To Uppercase   ::
20210 REM ::::::::::::::::::::::
20220 DEF FN_TO_UPPER(ch$):LOCAL ch%:ch% = ASC(ch$):ch$ = CHR$(ch% + 32 * (ch% >= 97 AND ch% <= 122)):=ch$
20230 :
20240 REM ::::::::::::::::::::::
20250 REM ::   To Lowercase   ::
20260 REM ::::::::::::::::::::::
20270 DEF FN_TO_LOWER(ch$):LOCAL ch%:ch% = ASC(ch$):ch$ = CHR$(ch% - 32 * (ch% >= 65 AND ch% <= 90)):=ch$
20280 :
20290 REM ::::::::::::::::::::::::::::::::
20300 REM :: Prepend Zeroes To A Number ::
20310 REM ::::::::::::::::::::::::::::::::
20320 DEF FN_PAD_NUMBER(val%, len%)
20330 LOCAL s$
20340 s$ = STR$(val%)
20350 := STRING$(len% - LEN(s$), "0") + s$
20360 :
20370 REM :::::::::::::::::::::::::::
20380 REM :: Hit a key to continue ::
20390 REM :::::::::::::::::::::::::::
20400 DEF FN_HIT_A_KEY
20410 LOCAL c%, ex%, ti
20420 c% = 0:ex% = FALSE:ti = TIME
20430 REPEAT
20440   c% = INKEY(10):IF c% > 0 OR 1000 < (TIME - ti) THEN ex% = TRUE
20450 UNTIL ex%
20460 := c%
20470 :
20480 REM :::::::::::::::::::::::::::::::::::
20490 REM :: Display Text In Reverse Video ::
20500 REM :::::::::::::::::::::::::::::::::::
20510 DEF FN_RVS(fg%, bg%, text$):= CHR$(17)+CHR$(128+fg%)+CHR$(17)+CHR$(bg%)+text$+CHR$(17)+CHR$(fg%)+CHR$(17)+CHR$(128+bg%)
20520 :
20530 REM :::::::::::::::::::::
20540 REM ::   Center text   ::
20550 REM :::::::::::::::::::::
20560 DEF FN_CENTER(text$):= (CW% - LEN(text$)) DIV 2
20570 :
20580 REM :::::::::::::::::::::
20590 REM :: Right-trim text ::
20600 REM :::::::::::::::::::::
20610 DEF FN_RTRIM(text$)
20620 LOCAL trim%
20630 REPEAT
20640   trim% = FALSE
20650   IF ASC(LEFT$(text$, LEN(text$) - 1)) = BLANK THEN text$ = LEFT$(text$, LEN(text$) - 1):trim% = TRUE
20660 UNTIL NOT trim%
20670 := text$
20680 :
20690 REM ::::::::::::::::::::::::::::::
20700 REM :: Replace Text In A String ::
20710 REM ::::::::::::::::::::::::::::::
20720 DEF FN_XSTRING$(text$, pattern$, newText$)
20730 LOCAL pos%, r$
20740 r$ = text$
20750 pos% = INSTR(text$, pattern$)
20760 IF pos% > 0 THEN r$ = LEFT$(text$, pos%-1) + newText$ + RIGHT$(text$, LEN(text$) - LEN(pattern$) - pos% + 1)
20770 := r$
20780 :
20790 REM :::::::::::::::::::::::::
20800 REM :: Prompt For Response ::
20810 REM :::::::::::::::::::::::::
20820 DEF FN_PROMPT(x%, y%, text$, default$)
20830 LOCAL r$
20840 PRINT TAB(x%, y%)text$;" ";default$:PRINT TAB(x% + LEN(text$) + 1, y%);
20850 r$ = GET$:r$ = FN_TO_UPPER(r$):IF r$ = CHR$(13) THEN r$ = default$
20860 := r$
20870 :
20880 REM :::::::::::::::::::::::::::::
20890 REM ::  Display Centered Text  ::
20900 REM :::::::::::::::::::::::::::::
20910 DEF PROC_CENTER(text$)
20920 LOCAL i%, l%, len%, x%, y%
20930 l% = 0:y% = VPOS:len% = LEN(text$)
20940 FOR i% = 1 TO len%
20950   IF ASC(MID$(text$, i%, 1)) >= BLANK THEN l% = l% + 1
20960 NEXT i%
20970 x% = (CW% - l%) DIV 2
20980 PRINT TAB(x%, y%);:REM VDU 31, x%, y%
20990 FOR i% = 1 TO len%
21000   VDU ASC(MID$(text$, i%, 1))
21010 NEXT i%
21020 ENDPROC
21030 :
21040 REM :::::::::::::::::::::::::::::::::
21050 REM :: Center text both vertically ::
21060 REM :: and horizontally            ::
21070 REM :::::::::::::::::::::::::::::::::
21080 DEF PROC_FULL_CENTER_TEXT(text$)
21090 LOCAL x%, y%
21100 x% = FN_CENTER(text$):y% = CH% DIV 2
21110 VDU 31, x%, y%:PRINT text$;
21120 ENDPROC
21130 :
21140 REM :::::::::::::::::::::::::::
21150 REM :: Empty Keyboard Buffer ::
21160 REM :::::::::::::::::::::::::::
21170 DEF PROC_EMPTY_KEYBOARD_BUFFER
21180 REPEAT UNTIL INKEY(0) = -1
21190 ENDPROC
21200 :
21210 REM ::::::::::::::::::::::::::::
21220 REM :: Disable display of the ::
21230 REM :: cursor on the screen   ::
21240 REM ::::::::::::::::::::::::::::
21250 DEF PROC_HIDE_CURSOR
21260 VDU 23,1,0;0;0;0;
21270 ENDPROC
21280 :
21290 REM ::::::::::::::::::::::::::::
21300 REM :: Enable display of the  ::
21310 REM :: cursor on the screen   ::
21320 REM ::::::::::::::::::::::::::::
21330 DEF PROC_SHOW_CURSOR
21340 VDU 23,1,1;0;0;0;
21350 ENDPROC
21360 :
21370 REM ::::::::::::::::::::::::::::
21380 REM :: Restore Default Colors ::
21390 REM ::::::::::::::::::::::::::::
21400 DEF PROC_DEFAULT_COLORS
21410 COLOUR 128+BG%:COLOUR FG%
21420 ENDPROC
21430 :
21440 REM ::::::::::::::::::::::::::::::::::::::::::::
21450 REM :: Wipe away the text contents of the box ::
21460 REM ::::::::::::::::::::::::::::::::::::::::::::
21470 DEF PROC_WIPE_TEXT(ux%, uy%, width%, height%)
21480 LOCAL i%, blank$
21490 blank$ = STRING$(width%, " ")
21500 FOR i% = uy% TO uy% + height% - 1
21510   PRINT TAB(ux%, i%)blank$
21520 NEXT i%
21530 PRINT TAB(ux%, uy%);:REM Position cursor to upper left corner of bounding box
21540 ENDPROC
21550 :
21560 REM :::::::::::::::::::::::::::::::::::::::::::
21570 REM ::  Calculate type index of a clockwise  ::
21580 REM ::  position on a box's perimeter        ::
21590 REM :::::::::::::::::::::::::::::::::::::::::::
21600 DEF FN_CLOCKWISE_BOX_SIDE_INDEX(pos%, width%, height%)
21610 REM 0 = UPPER_LEFT_CORNER, 1 = UPPER_MIDDLE, 2 = UPPER_RIGHT_CORNER, 3 = MIDDLE_RIGHT, 4 = LOWER_RIGHT_CORNER, 5 = LOWER_MIDDLE, 6 = LOWER_LEFT_CORNER, 7 = MIDDLE_LEFT
21620 LOCAL r%
21630 r% = (pos% > 0 AND pos% < width% - 1) * -1 + (pos% = width% - 1) * -2 + (pos% >= width% AND pos% < width% + height% - 2) * -3 + (pos% = width% + height% - 2) * -4
21640 r% = r% + (pos% > width% + height% - 2 AND pos% < 2 * width% + height% - 3) * -5 + (pos% = 2 * width% + height% - 3) * -6 + (pos% > 2 * width% + height% - 3) * -7
21650 :=r%
21660 :
21670 REM ::::::::::::::::::::::::::
21680 REM ::  Draw Box Clockwise  ::
21690 REM ::::::::::::::::::::::::::
21700 DEF PROC_CLOCKWISE_BOX(ux%, uy%, width%, height%, color%)
21710 LOCAL aq%, bq%, ch%, i%, p%, x%, y%
21720 aq% = width% + height% - 2:bq% = aq% + width%:p% = bq% + height% - 2
21730 FOR i% = 0 TO p% - 1
21740   x% = (i% < width%) * -i% + (i% > (width%-1) AND i% < aq%) * -(width%-1) + (i% >= aq% AND i% < bq%) * (i% - (bq% - 1)) + (i% >= bq%) * 0
21750   y% = (i% < width%) * 0 + (i% > (width%-1) AND i% < aq%) * -(i% - (width%-1)) + (i% >= aq% AND i% < bq%) * -(height%-1) + (i% >= bq%) * -((height%-2) - (i% - bq%))
21760   ch% = ASC(MID$(BX$, FN_CLOCKWISE_BOX_SIDE_INDEX(i%, width%, height%) + 1, 1))
21770   PROC_PLOT(ux% + x%, uy% + y%, ch%, color%)
21780 NEXT i%
21790 ENDPROC
21800 :
21810 REM :::::::::::::::::::::::::::
21820 REM :: Plot a single colored ::
21830 REM :: character to screen   ::
21840 REM :::::::::::::::::::::::::::
21850 DEF PROC_PLOT(x%, y%, ch%, co%)
21860 VDU 31, x%, y%
21870 VDU 17, co%, ch%
21880 ENDPROC
21890 :
21900 REM ::::::::::::::
21910 REM :: Suspense ::
21920 REM ::::::::::::::
21930 DEF PROC_SUSPENSE(count%, ch%, delay%)
21940 LOCAL i%
21950 PRINT TAB(FN_CENTER(STRING$(count%, CHR$(ch%))), VPOS);
21960 FOR i% = 1 TO count%
21970   PRINT CHR$(ch%);:PROC_SLEEP(delay%)
21980 NEXT i%
21990 PRINT
22000 ENDPROC
22010 :
22020 REM :::::::::::::::::::::::::::::::::
22030 REM :: Enter letters from keyboard ::
22040 REM :::::::::::::::::::::::::::::::::
22050 DEF FN_PROMPT_FOR_LETTERS(length%)
22060 LOCAL c$, r$
22070 r$ = "":PROC_EMPTY_KEYBOARD_BUFFER:PROC_SHOW_CURSOR
22080 REPEAT
22090   c$ = GET$
22100   IF ((c$ = CHR$(127) OR c$ = CHR$(8)) AND LEN(r$) > 0) THEN r$ = LEFT$(r$, LEN(r$) - 1):PRINT CHR$(127);
22110   IF ((c$ >= "A" AND c$ <= "Z") OR (c$ >= "a" AND c$ <= "z") OR (c$ = CHR$(BLANK))) AND LEN(r$) < length% THEN r$ = r$ + c$:PRINT c$;
22120 UNTIL c$ = CHR$(CR) AND LEN(r$) <= length%
22130 PROC_HIDE_CURSOR
22140 :=r$
22150 :
22160 REM :::::::::::::::::::::::
22170 REM :: Play Simple Sound ::
22180 REM :::::::::::::::::::::::
22190 DEF PROC_SOUND(index%, duration%)
22200 LOCAL constant%
22210 constant% = 12.2
22220 SOUND 1, -12, index% * constant%, duration%
22230 ENDPROC
22240 :
22250 REM :::::::::::::::::::::::::
22260 REM :: Play Musical Phrase ::
22270 REM :::::::::::::::::::::::::
22280 DEF PROC_PLAY(notes$)
22290 LOCAL d%, j%, l%, p%
22300 l% = LEN(notes$) DIV 3
22310 FOR j% = 1 TO l% STEP 2
22320   p% = VAL(MID$(notes$, 3 * (j% - 1) + 1, 3)):d% = VAL(MID$(notes$, 3 * (j% - 1) + 4, 3))
22330   IF p% >= 0 THEN SOUND 1, -13, p%, d%:ELSE SOUND 1, 0, 0, d%
22340   SOUND 1, 0, p%, 1:REM Stacatto the currently playing sound
22350 NEXT j%
22360 ENDPROC
22370 :
22380 REM :::::::::::::::::::::::::::
22390 REM ::  Funeral March Theme  ::
22400 REM :::::::::::::::::::::::::::
22410 DEF PROC_FUNERAL_MARCH_THEME
22420 PROC_PLAY("089008089006089002089008101006097002097006089002089006089002089024"):REM PITCH,DURATION
22430 ENDPROC
22440 :
22450 REM ::::::::::::::::::::::::::::::::::
22460 REM ::  Good Evening Friends Theme  ::
22470 REM ::::::::::::::::::::::::::::::::::
22480 DEF PROC_GOOD_EVENING_FRIENDS_THEME
22490 PROC_PLAY("149008157008149008161024"):REM PITCH,DURATION
22500 ENDPROC
22510 :
22520 REM :::::::::::::::::::::
22530 REM ::  ITHOTMK Theme  ::
22540 REM :::::::::::::::::::::
22550 DEF PROC_ITHOTMK_THEME
22560 LOCAL notes$:REM PITCH,DURATION
22570 notes$ = "097004105004109004117004125004109004125008121004105004121008117004101004117008"
22580 notes$ = notes$ + "097004105004109004117004125004109004125004145004137004125004109004125004137016"
22590 PROC_PLAY(notes$)
22600 ENDPROC
22610 :
22620 REM ::::::::::::::::
22630 REM ::  TZ Theme  ::
22640 REM ::::::::::::::::
22650 DEF PROC_TZ_THEME
22660 PROC_PLAY("181004185004181004165004181004185004181004165004181004185004181004165004"):REM PITCH,DURATION
22670 ENDPROC
22680 :
22690 REM ::::::::::::::::::::::::::::::::
22700 REM ::  We're In The Money Theme  ::
22710 REM ::::::::::::::::::::::::::::::::
22720 DEF PROC_WERE_IN_THE_MONEY_THEME
22730 PROC_PLAY("157004169006157002161004169012"):REM PITCH,DURATION
22740 ENDPROC
22750 :
22760 REM ::::::::::::::::::::::::::::::
22770 REM :: Define Custom Characters ::
22780 REM ::::::::::::::::::::::::::::::
22790 DEF PROC_REDEFINE_CHARS
22800 VDU 23,SKULL,0,189,126,90,126,165,24,0:REM SKULL(7)
22810 VDU 23,B_VERT,24,24,24,24,24,24,24,24:REM VERTICAL(4)
22820 VDU 23,B_HORZ,0,0,0,255,255,0,0,0:REM HORIZONTAL(4)
22830 VDU 23,B_UR,0,0,0,7,15,28,24,24:REM UPRIGHT C(4)
22840 VDU 23,B_UL,0,0,0,224,240,56,24,24:REM UPLEFT C(4)
22850 VDU 23,B_DL,24,24,56,240,224,0,0,0:REM DOWNLEFT C(4)
22860 VDU 23,B_DR,24,24,28,15,7,0,0,0:REM DOWN RIGHT C(4)
22870 ENDPROC
22880 :
22890 REM ::::::::::::::::::::::::::::::
22900 REM ::  Error Handling Routine  ::
22910 REM ::::::::::::::::::::::::::::::
22920 DEF PROC_HANDLE_ERROR
22930 IF ERR <> 17 THEN PROC_DEFAULT_COLORS:PROC_SHOW_CURSOR:PRINT:REPORT:PRINT" @line #";ERL:STOP
22940 ENDPROC
