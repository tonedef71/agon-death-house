10000 CLEAR
10010 REM :::::::::::::::::::::::::::::::
10020 REM :: Constants and Definitions ::
10030 REM :::::::::::::::::::::::::::::::
10040 BLANK = 32:SKULL = 42:C_TAB = 9:NL = 10:CR = 13:FF = 12:DASH = 45:DOT = 46:QST = 63:EX = 33
10050 BLACK = 0:RED = 1:GREEN = 2:YELLOW = 3:BLUE = 4:MAGENTA = 5:CYAN = 6:WHITE = 7
10060 FG% = WHITE:BG% = BLACK:CW% = 40
10070 TX_SIZE% = 2048:DIM TX TX_SIZE%:REM Text memory buffer
10080 :
10090 COLOUR 128 + BLACK:COLOUR WHITE
10100 PRINT "To output individual passages, invoke "
10110 PRINT "individual PROCs."
10120 PRINT
10130 PRINT "To output all of the passages, invoke "
10140 PRINT "PROC_WRITE_ALL."
10150 END
10160 :
10170 REM :::::::::::::::::::::::::::
10180 REM :: Invoke all story file ::
10190 REM :: write procedures      ::
10200 REM :::::::::::::::::::::::::::
10210 DEF PROC_WRITE_ALL
10220 PROC_INTRO
10230 PROC_INITIAL_TEXT
10240 PROC_GET_IN_BED
10250 PROC_HARD_PILLOW
10260 PROC_BRICK_UNDER_PILLOW
10270 PROC_SNAKE_UNDER_PILLOW
10280 PROC_STRANGLED
10290 PROC_NOT_SLEEPY
10300 PROC_GET_OUT_OF_MY_BED
10310 PROC_NORTH_WALL
10320 PROC_PIT
10330 PROC_DISTRACTED
10340 PROC_SOUTH_WALL
10350 PROC_GRABBED_FROM_BEHIND
10360 PROC_EXAMINE_DOOR
10370 PROC_EXAMINE_WASHSTAND
10380 PROC_EXAMINE_BOOKCASE
10390 PROC_TAKE_BOOK_TRAP_DOOR
10400 PROC_READ_BOOK
10410 PROC_EXAMINE_FIREPLACE
10420 PROC_DANGER_SENSE
10430 PROC_IN_FIREPLACE
10440 PROC_WEST_WALL
10450 PROC_EXAMINE_DESK
10460 PROC_READ_NOTE
10470 PROC_SEVERED_HEAD
10480 PROC_EMPTY_DRAWERS
10490 PROC_NOISE_FROM_BEHIND
10500 PROC_INSPECT_WINDOW
10510 PROC_WINDOW_ATTACK
10520 PROC_NOTHING_THERE
10530 PROC_GRAMOPHONE
10540 PROC_FUNERAL_MARCH
10550 PROC_NO_TIME_TO_WASTE
10560 PROC_POISON_MIST
10570 PROC_ROOM_SPINNING
10580 PROC_EVIL_VOICE
10590 PROC_SHADOW_AT_WINDOW
10600 PROC_MOONLIGHT_SHADOW
10610 PROC_MOONLIT_VIEW
10620 PROC_GETTING_BRAVE
10630 PROC_NOTHING_AT_WINDOW
10640 PROC_FEELING_SLEEPY
10650 PROC_DEATHLY_COLD_HAND
10660 PROC_HIDEOUS_THING
10670 PROC_RUN
10680 PROC_NOBODY_BEHIND_YOU
10690 PROC_ONE_AM
10700 PROC_SURVIVED
10710 PROC_TREACHERY
10720 PROC_DEATH
10730 ENDPROC
10740 :
10750 REM ::::::::::::::::::
10760 REM :: Introduction ::
10770 REM ::::::::::::::::::
10780 DEF PROC_INTRO
10790 PROC_INIT_STORY_FILE("11")
10800 PROC_WRITE_STORY_FILE("Welcome to my house, :NM:.")
10810 PROC_WRITE_STORY_FILE(" Well, let's see. Oh, it's only half past")
10820 PROC_WRITE_STORY_FILE(" eleven. That gives me a few minutes to")
10830 PROC_WRITE_STORY_FILE(" explain the situation to you. Are you")
10840 PROC_WRITE_STORY_FILE(" quite comfortable in that chair?"+CHR$(NL))
10850 PROC_WRITE_STORY_FILE("Good, then why don't I begin."+CHR$(NL))
10860 PROC_WRITE_STORY_FILE("The proposition is actually quite a")
10870 PROC_WRITE_STORY_FILE(" simple one. At midnight, I lock you in")
10880 PROC_WRITE_STORY_FILE(" the east bedroom of this house. At precisely")
10890 PROC_WRITE_STORY_FILE(" 1 AM, I will unlock the door. If")
10900 PROC_WRITE_STORY_FILE(" you are still alive, I will give you, free and clear,")
10910 PROC_WRITE_STORY_FILE(" the sum of $1,000,000."+CHR$(FF))
10920 PROC_WRITE_STORY_FILE("I know that must sound terribly insane,")
10930 PROC_WRITE_STORY_FILE(" but I trust you did enough research to")
10940 PROC_WRITE_STORY_FILE(" understand the offer."+CHR$(NL))
10950 PROC_WRITE_STORY_FILE("You did do some checking around, didn't you?"+CHR$(NL))
10960 PROC_WRITE_STORY_FILE("Well, no matter; I can tell you about it."+CHR$(FF))
10970 PROC_WRITE_STORY_FILE("The room you are about to enter was")
10980 PROC_WRITE_STORY_FILE(" once my great-grandfather's. Some time")
10990 PROC_WRITE_STORY_FILE(" after midnight one dreary night, the")
11000 PROC_WRITE_STORY_FILE(" servants heard a terrible scream coming")
11010 PROC_WRITE_STORY_FILE(" from his bed chamber. When they opened the")
11020 PROC_WRITE_STORY_FILE(" door to his room, he was dead. The doctor")
11030 PROC_WRITE_STORY_FILE(" said that he had died of a heart")
11040 PROC_WRITE_STORY_FILE(" attack. The servants swore he looked as")
11050 PROC_WRITE_STORY_FILE(" if he was scared into his grave. Ever")
11060 PROC_WRITE_STORY_FILE(" since his death, anyone who slept in")
11070 PROC_WRITE_STORY_FILE(" his room died, some time between midnight")
11080 PROC_WRITE_STORY_FILE(" and one AM. When I took possession of this house,")
11090 PROC_WRITE_STORY_FILE(" I made the offer I now propose to you. Four")
11100 PROC_WRITE_STORY_FILE(" people took me up on it. All died. "+CHR$(FF))
11110 PROC_WRITE_STORY_FILE("So that's the story, pure and simple."+CHR$(NL))
11120 PROC_WRITE_STORY_FILE("..."+CHR$(NL))
11130 PROC_WRITE_STORY_FILE("My, is it that time already? Well, why")
11140 PROC_WRITE_STORY_FILE(" don't you follow me up these stairs......"+CHR$(NL))
11150 PROC_WRITE_STORY_FILE("Ah, here we are. I see you have your")
11160 PROC_WRITE_STORY_FILE(" flashlight. Good, you never know around")
11170 PROC_WRITE_STORY_FILE(" here when the lights will go out."+CHR$(NL))
11180 PROC_WRITE_STORY_FILE("Well, it's that time, :NM:......"+CHR$(NL))
11190 PROC_WRITE_STORY_FILE("Take care, and I hope to find you fine")
11200 PROC_WRITE_STORY_FILE(" and well in an hour."+CHR$(NL))
11210 PROC_WRITE_STORY_FILE("Good luck!!!"+CHR$(FF))
11220 PROC_CLOSE_STORY_FILE
11230 ENDPROC
11240 :
11250 REM ::::::::::::::::::::::::::
11260 REM :: Initial text of game ::
11270 REM ::::::::::::::::::::::::::
11280 DEF PROC_INITIAL_TEXT
11290 PROC_INIT_STORY_FILE("27")
11300 PROC_WRITE_STORY_FILE(CHR$(17)+CHR$(YELLOW)+":TM: AM"+CHR$(17)+CHR$(FG%)+"."+CHR$(NL))
11310 PROC_WRITE_STORY_FILE("The turning of the key in the lock")
11320 PROC_WRITE_STORY_FILE(" makes your skin crawl. However, as you")
11330 PROC_WRITE_STORY_FILE(" look around the room, you slowly start")
11340 PROC_WRITE_STORY_FILE(" to relax. Other than the fact that the")
11350 PROC_WRITE_STORY_FILE(" furnishings are obviously quite old,")
11360 PROC_WRITE_STORY_FILE(" the room appears quite normal. There is")
11370 PROC_WRITE_STORY_FILE(" a window in the middle of the wall to")
11380 PROC_WRITE_STORY_FILE(" your front, no doubt affording a breath-")
11390 PROC_WRITE_STORY_FILE("taking view of the estate. To the left")
11400 PROC_WRITE_STORY_FILE(" of the window is an ornate writing desk")
11410 PROC_WRITE_STORY_FILE(" that must be at least two hundred years")
11420 PROC_WRITE_STORY_FILE(" old. To the right of the window, on a richly")
11430 PROC_WRITE_STORY_FILE(" inlaid table, is a gramophone, looking")
11440 PROC_WRITE_STORY_FILE(" as if it was bought only yesterday."+CHR$(FF))
11450 PROC_WRITE_STORY_FILE("The wall to your right is completely")
11460 PROC_WRITE_STORY_FILE(" taken up with an immense bookcase built")
11470 PROC_WRITE_STORY_FILE(" around an Italian marble fireplace. The")
11480 PROC_WRITE_STORY_FILE(" shelves are packed tight with books,")
11490 PROC_WRITE_STORY_FILE(" and from your viewpoint, most of them")
11500 PROC_WRITE_STORY_FILE(" seem to be bound in leather. There are")
11510 PROC_WRITE_STORY_FILE(" logs in the fireplace, but no fire. Of")
11520 PROC_WRITE_STORY_FILE(" course, considering the summer heat,")
11530 PROC_WRITE_STORY_FILE(" a fire would be out of the question,")
11540 PROC_WRITE_STORY_FILE(" but somehow you kind of wish there was,")
11550 PROC_WRITE_STORY_FILE(" as if the cheery glow from it would")
11560 PROC_WRITE_STORY_FILE(" ward away all things evil."+CHR$(FF))
11570 PROC_WRITE_STORY_FILE("In the center of the left wall is the")
11580 PROC_WRITE_STORY_FILE(" bed, a massive four-poster with canopy.")
11590 PROC_WRITE_STORY_FILE(" To its right, a nightstand. A rather")
11600 PROC_WRITE_STORY_FILE(" time-worn rocking chair is to the left.")
11610 PROC_WRITE_STORY_FILE(" Behind you is the door, and to its")
11620 PROC_WRITE_STORY_FILE(" right, an old-fashioned washstand,")
11630 PROC_WRITE_STORY_FILE(" with pitcher, bowl, and a rather oddly")
11640 PROC_WRITE_STORY_FILE(" shaped mirror on the wall behind. All")
11650 PROC_WRITE_STORY_FILE(" in all, a normal-looking room."+CHR$(FF))
11660 PROC_CLOSE_STORY_FILE
11670 ENDPROC
11680 :
11690 REM ::::::::::::::::
11700 REM :: Get in bed ::
11710 REM ::::::::::::::::
11720 DEF PROC_GET_IN_BED
11730 PROC_INIT_STORY_FILE("52")
11740 PROC_WRITE_STORY_FILE("You slowly climb into the bed... The thick")
11750 PROC_WRITE_STORY_FILE(" coverlets are quite comfortable, but the")
11760 PROC_WRITE_STORY_FILE(" bed itself is rather hard. Slowly you")
11770 PROC_WRITE_STORY_FILE(" lay your head on the pillow........")
11780 PROC_CLOSE_STORY_FILE
11790 ENDPROC
11800 :
11810 REM :::::::::::::::::
11820 REM :: Hard pillow ::
11830 REM :::::::::::::::::
11840 DEF PROC_HARD_PILLOW
11850 PROC_INIT_STORY_FILE("88")
11860 PROC_WRITE_STORY_FILE("and it feels like you've just slammed")
11870 PROC_WRITE_STORY_FILE(" it into a building. There's something")
11880 PROC_WRITE_STORY_FILE(" under the pillow!"+CHR$(FF))
11890 PROC_CLOSE_STORY_FILE
11900 ENDPROC
11910 :
11920 REM ::::::::::::::::::::::::
11930 REM :: Brick under pillow ::
11940 REM ::::::::::::::::::::::::
11950 DEF PROC_BRICK_UNDER_PILLOW
11960 PROC_INIT_STORY_FILE("39")
11970 PROC_WRITE_STORY_FILE("No wonder it felt like you slammed your")
11980 PROC_WRITE_STORY_FILE(" head into a building! Someone put a")
11990 PROC_WRITE_STORY_FILE(" brick under the pillow. Disgusted, you")
12000 PROC_WRITE_STORY_FILE(" throw the brick down and again lay on")
12010 PROC_WRITE_STORY_FILE(" the pillow..."+CHR$(FF))
12020 PROC_CLOSE_STORY_FILE
12030 ENDPROC
12040 :
12050 REM :::::::::::::::::::::::::::::
12060 REM :: Snake underneath pillow ::
12070 REM :::::::::::::::::::::::::::::
12080 DEF PROC_SNAKE_UNDER_PILLOW
12090 PROC_INIT_STORY_FILE("47")
12100 PROC_WRITE_STORY_FILE("As you reach under the pillow and withdraw")
12110 PROC_WRITE_STORY_FILE(" the item, you suddenly realize it's")
12120 PROC_WRITE_STORY_FILE(" moving. Startled, you find that you're")
12130 PROC_WRITE_STORY_FILE(" holding a rattlesnake! You feel a sharp")
12140 PROC_WRITE_STORY_FILE(" pain in your chest, and lapse into")
12150 PROC_WRITE_STORY_FILE(" unconsciousness..."+CHR$(FF))
12160 PROC_CLOSE_STORY_FILE
12170 ENDPROC
12180 :
12190 REM ::::::::::::::::::::::
12200 REM :: Strangled in bed ::
12210 REM ::::::::::::::::::::::
12220 DEF PROC_STRANGLED
12230 PROC_INIT_STORY_FILE("92")
12240 PROC_WRITE_STORY_FILE("Just as your getting all snuggled in,")
12250 PROC_WRITE_STORY_FILE(" strong hands seize you roughly by the")
12260 PROC_WRITE_STORY_FILE(" throat. Your eyes open wide, but you")
12270 PROC_WRITE_STORY_FILE(" can't see who's strangling you. Slowly,")
12280 PROC_WRITE_STORY_FILE(" you sink into oblivion..."+CHR$(FF))
12290 PROC_CLOSE_STORY_FILE
12300 ENDPROC
12310 :
12320 REM ::::::::::::::::
12330 REM :: Not sleepy ::
12340 REM ::::::::::::::::
12350 DEF PROC_NOT_SLEEPY
12360 PROC_INIT_STORY_FILE("16")
12370 PROC_WRITE_STORY_FILE("After a moment or so of tossing and")
12380 PROC_WRITE_STORY_FILE(" turning, you realize you'll never fall")
12390 PROC_WRITE_STORY_FILE(" asleep. Cursing, you get out of bed."+CHR$(FF))
12400 PROC_CLOSE_STORY_FILE
12410 ENDPROC
12420 :
12430 REM :::::::::::::::::::::::
12440 REM :: Get out of my bed ::
12450 REM :::::::::::::::::::::::
12460 DEF PROC_GET_OUT_OF_MY_BED
12470 PROC_INIT_STORY_FILE("41")
12480 PROC_WRITE_STORY_FILE("Suddenly, someone (or something) in an")
12490 PROC_WRITE_STORY_FILE(" evil-sounding voice screams 'Get out of")
12500 PROC_WRITE_STORY_FILE(" my damn bed' right in your ear. With")
12510 PROC_WRITE_STORY_FILE(" speed that would please a military drill")
12520 PROC_WRITE_STORY_FILE(" sergeant, you jump out of bed and start")
12530 PROC_WRITE_STORY_FILE(" to stammer an apology, until you realize")
12540 PROC_WRITE_STORY_FILE(" that you're alone!"+CHR$(FF))
12550 PROC_CLOSE_STORY_FILE
12560 ENDPROC
12570 :
12580 REM ::::::::::::::::::::::::
12590 REM :: Explore north wall ::
12600 REM ::::::::::::::::::::::::
12610 DEF PROC_NORTH_WALL
12620 PROC_INIT_STORY_FILE("04")
12630 PROC_WRITE_STORY_FILE("...moving to north wall...")
12640 PROC_CLOSE_STORY_FILE
12650 ENDPROC
12660 :
12670 REM :::::::::::::::::::
12680 REM :: Fall into pit ::
12690 REM :::::::::::::::::::
12700 DEF PROC_PIT
12710 PROC_INIT_STORY_FILE("38")
12720 PROC_WRITE_STORY_FILE("Funny, the floor in front of you just")
12730 PROC_WRITE_STORY_FILE(" opened up."+CHR$(NL))
12740 PROC_WRITE_STORY_FILE("You're falling into a pit!!!"+CHR$(NL))
12750 PROC_WRITE_STORY_FILE("As you fall, seemingly forever, you look")
12760 PROC_WRITE_STORY_FILE(" down. You're getting closer to a bedding")
12770 PROC_WRITE_STORY_FILE(" of 30-foot spikes! You feel a")
12780 PROC_WRITE_STORY_FILE(" sharp pain, then nothing..."+CHR$(FF))
12790 PROC_CLOSE_STORY_FILE
12800 ENDPROC
12810 :
12820 REM ::::::::::::::::
12830 REM :: Distracted ::
12840 REM ::::::::::::::::
12850 DEF PROC_DISTRACTED
12860 PROC_INIT_STORY_FILE("73")
12870 PROC_WRITE_STORY_FILE("As you approach the north wall,")
12880 PROC_WRITE_STORY_FILE(" something on the east wall catches your eye!!!"+CHR$(FF))
12890 PROC_CLOSE_STORY_FILE
12900 ENDPROC
12910 :
12920 REM ::::::::::::::::::::::::
12930 REM :: Explore south wall ::
12940 REM ::::::::::::::::::::::::
12950 DEF PROC_SOUTH_WALL
12960 PROC_INIT_STORY_FILE("13")
12970 PROC_WRITE_STORY_FILE("...moving to south wall...")
12980 PROC_CLOSE_STORY_FILE
12990 ENDPROC
13000 :
13010 REM :::::::::::::::::::::::::
13020 REM :: Grabbed from behind ::
13030 REM :::::::::::::::::::::::::
13040 DEF PROC_GRABBED_FROM_BEHIND
13050 PROC_INIT_STORY_FILE("49")
13060 PROC_WRITE_STORY_FILE("Uh oh! As you move towards the south")
13070 PROC_WRITE_STORY_FILE(" wall, something grabs you from behind!"+CHR$(NL))
13080 PROC_WRITE_STORY_FILE("Almost in slow motion, it turns you around......")
13090 PROC_CLOSE_STORY_FILE
13100 ENDPROC
13110 :
13120 REM ::::::::::::::::::
13130 REM :: Examine Door ::
13140 REM ::::::::::::::::::
13150 DEF PROC_EXAMINE_DOOR
13160 PROC_INIT_STORY_FILE("65")
13170 PROC_WRITE_STORY_FILE("Yep, this is a door alright, and as")
13180 PROC_WRITE_STORY_FILE(" you are quite aware, it's LOCKED!"+CHR$(NL))
13190 PROC_WRITE_STORY_FILE("After all, it's only :TM:; you")
13200 PROC_WRITE_STORY_FILE(" know you're NOT getting out of here")
13210 PROC_WRITE_STORY_FILE(" until 1 AM!!!"+CHR$(FF))
13220 PROC_CLOSE_STORY_FILE
13230 ENDPROC
13240 :
13250 REM :::::::::::::::::::::::
13260 REM :: Examine washstand ::
13270 REM :::::::::::::::::::::::
13280 DEF PROC_EXAMINE_WASHSTAND
13290 PROC_INIT_STORY_FILE("31")
13300 PROC_WRITE_STORY_FILE("As you turn to examine the washstand,")
13310 PROC_WRITE_STORY_FILE(" you jump back in fright! The stand is")
13320 PROC_WRITE_STORY_FILE(" gone! All that remains is the mirror,")
13330 PROC_WRITE_STORY_FILE(" which is emanating a peculiar greenish")
13340 PROC_WRITE_STORY_FILE(" glow."+CHR$(FF))
13350 PROC_CLOSE_STORY_FILE
13360 ENDPROC
13370 :
13380 REM ::::::::::::::::::::::
13390 REM :: Examine bookcase ::
13400 REM ::::::::::::::::::::::
13410 DEF PROC_EXAMINE_BOOKCASE
13420 PROC_INIT_STORY_FILE("46")
13430 PROC_WRITE_STORY_FILE("The bookcase bespeaks of an owner with")
13440 PROC_WRITE_STORY_FILE(" excellent taste. All of the major authors")
13450 PROC_WRITE_STORY_FILE(" are represented here - Hardy, James,")
13460 PROC_WRITE_STORY_FILE(" Twain, Shakespeare, etc. One large book")
13470 PROC_WRITE_STORY_FILE(" has been pulled most of the way out of")
13480 PROC_WRITE_STORY_FILE(" the bookcase, and seems to be dangerously")
13490 PROC_WRITE_STORY_FILE(" close to falling."+CHR$(FF))
13500 PROC_CLOSE_STORY_FILE
13510 ENDPROC
13520 :
13530 REM ::::::::::::::::::::::::::::::::
13540 REM :: Taking Book Activates Trap ::
13550 REM ::::::::::::::::::::::::::::::::
13560 DEF PROC_TAKE_BOOK_TRAP_DOOR
13570 PROC_INIT_STORY_FILE("19")
13580 PROC_WRITE_STORY_FILE("Gee, just like in the movies. You take")
13590 PROC_WRITE_STORY_FILE(" the book, and a trap door opens up beneath you.")
13600 PROC_WRITE_STORY_FILE(" Trap door?"+CHR$(NL))
13610 PROC_WRITE_STORY_FILE("AAAAAIIIIGGGHH!!!!")
13620 PROC_CLOSE_STORY_FILE
13630 ENDPROC
13640 :
13650 REM :::::::::::::::
13660 REM :: Read Book ::
13670 REM :::::::::::::::
13680 DEF PROC_READ_BOOK
13690 PROC_INIT_STORY_FILE("71")
13700 PROC_WRITE_STORY_FILE("Nice book. The title is *CANNABALISM*")
13710 PROC_WRITE_STORY_FILE(" GUIDE FOR THE GOURMET."+CHR$(NL))
13720 PROC_WRITE_STORY_FILE("Yuck, it's a cookbook! You open it to the table")
13730 PROC_WRITE_STORY_FILE(" of contents..."+CHR$(FF))
13740 PROC_WRITE_STORY_FILE("************* CHAPTER I *************"+CHR$(NL))
13750 PROC_WRITE_STORY_FILE("HOW TO COOK "+CHR$(17)+CHR$(RED)+":NM:"+CHR$(17)+CHR$(FG%)+" ***"+CHR$(NL))
13760 PROC_WRITE_STORY_FILE("Omigod!!!!!!"+CHR$(NL))
13770 PROC_WRITE_STORY_FILE("You drop the book in fright")
13780 PROC_WRITE_STORY_FILE(" and run over to the fireplace..."+CHR$(FF))
13790 PROC_CLOSE_STORY_FILE
13800 ENDPROC
13810 :
13820 REM :::::::::::::::::::::::
13830 REM :: Examine Fireplace ::
13840 REM :::::::::::::::::::::::
13850 DEF PROC_EXAMINE_FIREPLACE
13860 PROC_INIT_STORY_FILE("84")
13870 PROC_WRITE_STORY_FILE("This fireplace is huge! It looks like")
13880 PROC_WRITE_STORY_FILE(" you could park a VW bug in it. The")
13890 PROC_WRITE_STORY_FILE(" marble has been meticulously scrubbed.")
13900 PROC_WRITE_STORY_FILE(" Not one trace of soot remains. The logs")
13910 PROC_WRITE_STORY_FILE(" give off a tantalizing pine odor."+CHR$(NL))
13920 PROC_WRITE_STORY_FILE("Conspicuous by its absence is the screen.")
13930 PROC_WRITE_STORY_FILE(" For such a large fireplace, it seems")
13940 PROC_WRITE_STORY_FILE(" rather dangerous to leave the front")
13950 PROC_WRITE_STORY_FILE(" opened up."+CHR$(FF))
13960 PROC_CLOSE_STORY_FILE
13970 ENDPROC
13980 :
13990 REM :::::::::::::::::::::
14000 REM :: Sense of danger ::
14010 REM :::::::::::::::::::::
14020 DEF PROC_DANGER_SENSE
14030 PROC_INIT_STORY_FILE("03")
14040 PROC_WRITE_STORY_FILE("Sensing danger, you move back to the center of the room......")
14050 PROC_CLOSE_STORY_FILE
14060 ENDPROC
14070 :
14080 REM :::::::::::::::::::::::::::
14090 REM :: Roasting in fireplace ::
14100 REM :::::::::::::::::::::::::::
14110 DEF PROC_IN_FIREPLACE
14120 PROC_INIT_STORY_FILE("55")
14130 PROC_WRITE_STORY_FILE("You seem rather warm. Of course, you")
14140 PROC_WRITE_STORY_FILE(" SHOULD feel warm. Somehow, you're IN")
14150 PROC_WRITE_STORY_FILE(" the fireplace, with a roaring fire")
14160 PROC_WRITE_STORY_FILE(" around you! Frantically, you jump out")
14170 PROC_WRITE_STORY_FILE(" of the fireplace. The pain is too great,")
14180 PROC_WRITE_STORY_FILE(" and you hit the floor, blacking out........")
14190 PROC_CLOSE_STORY_FILE
14200 ENDPROC
14210 :
14220 REM :::::::::::::::::::::::::::::
14230 REM :: Exploring the west wall ::
14240 REM :::::::::::::::::::::::::::::
14250 DEF PROC_WEST_WALL
14260 PROC_INIT_STORY_FILE("32")
14270 PROC_WRITE_STORY_FILE("That's funny. You can get near the")
14280 PROC_WRITE_STORY_FILE(" bed, but an unseen force keeps you")
14290 PROC_WRITE_STORY_FILE(" from examining the nightstand and the")
14300 PROC_WRITE_STORY_FILE(" rocker..."+CHR$(FF))
14310 PROC_CLOSE_STORY_FILE
14320 ENDPROC
14330 :
14340 REM ::::::::::::::::::
14350 REM :: Examine desk ::
14360 REM ::::::::::::::::::
14370 DEF PROC_EXAMINE_DESK
14380 PROC_INIT_STORY_FILE("53")
14390 PROC_WRITE_STORY_FILE("This is quite a fine piece of furniture.")
14400 PROC_WRITE_STORY_FILE(" The desk is made out of solid teak,")
14410 PROC_WRITE_STORY_FILE(" with brass trimmings. An ink well is")
14420 PROC_WRITE_STORY_FILE(" set into the right side, an old quill")
14430 PROC_WRITE_STORY_FILE(" pen next to it. Other than a note next")
14440 PROC_WRITE_STORY_FILE(" to the pen, the desktop is empty,")
14450 PROC_WRITE_STORY_FILE(" except for an antique clock. There are")
14460 PROC_WRITE_STORY_FILE(" two drawers in the desk, both partially")
14470 PROC_WRITE_STORY_FILE(" opened."+CHR$(FF))
14480 PROC_CLOSE_STORY_FILE
14490 ENDPROC
14500 :
14510 REM :::::::::::::::::::::::::::::::
14520 REM :: Read the note on the desk ::
14530 REM :::::::::::::::::::::::::::::::
14540 DEF PROC_READ_NOTE
14550 PROC_INIT_STORY_FILE("99")
14560 PROC_WRITE_STORY_FILE("**************** NOTE ***************"+CHR$(NL))
14570 PROC_WRITE_STORY_FILE("J. Henderson ... "+CHR$(17)+CHR$(RED)+"DEAD"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(NL))
14580 PROC_WRITE_STORY_FILE("B. Parker    ... "+CHR$(17)+CHR$(RED)+"DEAD"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(NL))
14590 PROC_WRITE_STORY_FILE("C. Davies    ... "+CHR$(17)+CHR$(RED)+"DEAD"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(NL))
14600 PROC_WRITE_STORY_FILE("P. Johnson   ... "+CHR$(17)+CHR$(RED)+"DEAD"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(NL))
14610 PROC_WRITE_STORY_FILE(CHR$(17)+CHR$(YELLOW)+":NM:"+CHR$(17)+CHR$(FG%)+STRING$(1, CHR$(BLANK))+" ... "+CHR$(17)+CHR$(RED)+"SOON"+CHR$(17)+CHR$(FG%)+" ..."+CHR$(FF))
14620 PROC_WRITE_STORY_FILE("Terrified, you drop the note and run")
14630 PROC_WRITE_STORY_FILE(" towards the window....")
14640 PROC_CLOSE_STORY_FILE
14650 ENDPROC
14660 :
14670 REM ::::::::::::::::::
14680 REM :: Severed head ::
14690 REM:::::::::::::::::::
14700 DEF PROC_SEVERED_HEAD
14710 PROC_INIT_STORY_FILE("48")
14720 PROC_WRITE_STORY_FILE("Opening the drawers reveal - a human")
14730 PROC_WRITE_STORY_FILE(" head! The horror of seeing the severed")
14740 PROC_WRITE_STORY_FILE(" head is too much for your heart. Grabbing")
14750 PROC_WRITE_STORY_FILE(" your chest in agony, you keel over onto the floor!"+CHR$(FF))
14760 PROC_CLOSE_STORY_FILE
14770 ENDPROC
14780 :
14790 REM ::::::::::::::::::::::::
14800 REM :: Empty desk drawers ::
14810 REM ::::::::::::::::::::::::
14820 DEF PROC_EMPTY_DRAWERS
14830 PROC_INIT_STORY_FILE("06")
14840 PROC_WRITE_STORY_FILE("Both drawers are empty...")
14850 PROC_CLOSE_STORY_FILE
14860 ENDPROC
14870 :
14880 REM :::::::::::::::::::::::
14890 REM :: Noise from behind ::
14900 REM :::::::::::::::::::::::
14910 DEF PROC_NOISE_FROM_BEHIND
14920 PROC_INIT_STORY_FILE("21")
14930 PROC_WRITE_STORY_FILE("You hear a noise behind you... Quickly")
14940 PROC_WRITE_STORY_FILE(" you turn and walk to the center of")
14950 PROC_WRITE_STORY_FILE(" the room. All seems fine."+CHR$(FF))
14960 PROC_CLOSE_STORY_FILE
14970 ENDPROC
14980 :
14990 REM ::::::::::::::::::::
15000 REM :: Inspect window ::
15010 REM ::::::::::::::::::::
15020 DEF PROC_INSPECT_WINDOW
15030 PROC_INIT_STORY_FILE("12")
15040 PROC_WRITE_STORY_FILE("On close inspection of the window, you")
15050 PROC_WRITE_STORY_FILE(" notice that it was badly set. The sash")
15060 PROC_WRITE_STORY_FILE(" is cracked, the paint is peeling, and")
15070 PROC_WRITE_STORY_FILE(" you can feel the wind blowing through")
15080 PROC_WRITE_STORY_FILE(" the numerous cracks."+CHR$(FF))
15090 PROC_CLOSE_STORY_FILE
15100 ENDPROC
15110 :
15120 REM ::::::::::::::::::::::::::::
15130 REM :: Attacked at the window ::
15140 REM ::::::::::::::::::::::::::::
15150 DEF PROC_WINDOW_ATTACK
15160 PROC_INIT_STORY_FILE("40")
15170 PROC_WRITE_STORY_FILE("CRASH!!! Something with incredible")
15180 PROC_WRITE_STORY_FILE(" strength comes hurtling through the")
15190 PROC_WRITE_STORY_FILE(" window. It grabs you and shakes you 'til")
15200 PROC_WRITE_STORY_FILE(" your limp as a dishrag. You hit the")
15210 PROC_WRITE_STORY_FILE(" floor and black out......")
15220 PROC_CLOSE_STORY_FILE
15230 ENDPROC
15240 :
15250 REM :::::::::::::::::::::::::
15260 REM :: Nothing of interest ::
15270 REM :::::::::::::::::::::::::
15280 DEF PROC_NOTHING_THERE
15290 PROC_INIT_STORY_FILE("18")
15300 PROC_WRITE_STORY_FILE("Nothing much of interest here. You")
15310 PROC_WRITE_STORY_FILE(" decide to check the gramophone..."+CHR$(FF))
15320 PROC_CLOSE_STORY_FILE
15330 ENDPROC
15340 :
15350 REM ::::::::::::::::::::::::::::
15360 REM :: Examine the gramophone ::
15370 REM ::::::::::::::::::::::::::::
15380 DEF PROC_GRAMOPHONE
15390 PROC_INIT_STORY_FILE("61")
15400 PROC_WRITE_STORY_FILE("What you wouldn't give to own this! The")
15410 PROC_WRITE_STORY_FILE(" gramophone has obviously been given a")
15420 PROC_WRITE_STORY_FILE(" lot of tender-loving care. The rich")
15430 PROC_WRITE_STORY_FILE(" wood of the case and the brass of the")
15440 PROC_WRITE_STORY_FILE(" horn practically sparkle with polish."+CHR$(NL))
15450 PROC_WRITE_STORY_FILE("There is a record on the platter.")
15460 PROC_WRITE_STORY_FILE(" According to the label, it is Tchaikovsky's")
15470 PROC_WRITE_STORY_FILE(" War of 1812 Overture."+CHR$(FF))
15480 PROC_CLOSE_STORY_FILE
15490 ENDPROC
15500 :
15510 REM :::::::::::::::::::::::::::::::::::::
15520 REM :: Funeral march on the gramophone ::
15530 REM :::::::::::::::::::::::::::::::::::::
15540 DEF PROC_FUNERAL_MARCH
15550 PROC_INIT_STORY_FILE("2A")
15560 PROC_WRITE_STORY_FILE("Staring in disbelief, you watch as")
15570 PROC_WRITE_STORY_FILE(" the gramophone starts to crank up by")
15580 PROC_WRITE_STORY_FILE(" itself!!!"+CHR$(NL))
15590 PROC_WRITE_STORY_FILE("From the horn comes the wonderful")
15600 PROC_WRITE_STORY_FILE(" strains of")
15610 PROC_CLOSE_STORY_FILE
15620 PROC_INIT_STORY_FILE("2B")
15630 PROC_WRITE_STORY_FILE(" the FUNERAL MARCH???"+CHR$(NL))
15640 PROC_WRITE_STORY_FILE("Quickly, you run back towards the door..."+CHR$(FF))
15650 PROC_CLOSE_STORY_FILE
15660 ENDPROC
15670 :
15680 REM ::::::::::::::::::::::
15690 REM :: No time to waste ::
15700 REM ::::::::::::::::::::::
15710 DEF PROC_NO_TIME_TO_WASTE
15720 PROC_INIT_STORY_FILE("94")
15730 PROC_WRITE_STORY_FILE("You notice it is now :TM:.")
15740 PROC_WRITE_STORY_FILE(" No time to be playing around..."+CHR$(FF))
15750 PROC_CLOSE_STORY_FILE
15760 ENDPROC
15770 :
15780 REM :::::::::::::::::
15790 REM :: Poison mist ::
15800 REM :::::::::::::::::
15810 DEF PROC_POISON_MIST
15820 PROC_INIT_STORY_FILE("66")
15830 PROC_WRITE_STORY_FILE("You know, :NM:, that wasn't too bright!!!")
15840 PROC_WRITE_STORY_FILE(" The green mist seems to envelop you.")
15850 PROC_WRITE_STORY_FILE(" You feel yourself gagging, choking.")
15860 PROC_WRITE_STORY_FILE(" Mercifully, you slump to the floor...")
15870 PROC_CLOSE_STORY_FILE
15880 ENDPROC
15890 :
15900 REM ::::::::::::::::::::::
15910 REM :: Room is spinning ::
15920 REM ::::::::::::::::::::::
15930 DEF PROC_ROOM_SPINNING
15940 PROC_INIT_STORY_FILE("07")
15950 PROC_WRITE_STORY_FILE("The glow seems to surround you. You")
15960 PROC_WRITE_STORY_FILE(" can't see!!! The room starts to spin,")
15970 PROC_WRITE_STORY_FILE(" and then...")
15980 PROC_CLOSE_STORY_FILE
15990 ENDPROC
16000 :
16010 REM ::::::::::::::::
16020 REM :: Evil voice ::
16030 REM ::::::::::::::::
16040 DEF PROC_EVIL_VOICE
16050 PROC_INIT_STORY_FILE("37")
16060 PROC_WRITE_STORY_FILE("From out of nowhere, yet from all")
16070 PROC_WRITE_STORY_FILE(" around you, comes a voice. With an evil")
16080 PROC_WRITE_STORY_FILE(" laugh, it says, 'Fool, you die soon!'"+CHR$(FF))
16090 PROC_CLOSE_STORY_FILE
16100 ENDPROC
16110 :
16120 REM ::::::::::::::::::::::::::
16130 REM :: Shadow at the window ::
16140 REM ::::::::::::::::::::::::::
16150 DEF PROC_SHADOW_AT_WINDOW
16160 PROC_INIT_STORY_FILE("76")
16170 PROC_WRITE_STORY_FILE("You notice, out of the corner of your")
16180 PROC_WRITE_STORY_FILE(" eye, a shadow pass over the window!!!"+CHR$(FF))
16190 PROC_CLOSE_STORY_FILE
16200 ENDPROC
16210 :
16220 REM ::::::::::::::::::::::
16230 REM :: Moonlight shadow ::
16240 REM ::::::::::::::::::::::
16250 DEF PROC_MOONLIGHT_SHADOW
16260 PROC_INIT_STORY_FILE("97")
16270 PROC_WRITE_STORY_FILE("It appears a large bird just")
16280 PROC_WRITE_STORY_FILE(" flew close to the window, and the")
16290 PROC_WRITE_STORY_FILE(" moonlight cast a weird shadow. Phew!!!"+CHR$(FF))
16300 PROC_CLOSE_STORY_FILE
16310 ENDPROC
16320 :
16330 REM ::::::::::::::::::
16340 REM :: Moonlit view ::
16350 REM ::::::::::::::::::
16360 DEF PROC_MOONLIT_VIEW
16370 PROC_INIT_STORY_FILE("24")
16380 PROC_WRITE_STORY_FILE("You look out the window, and")
16390 PROC_WRITE_STORY_FILE(" have a wonderful moonlit view of the")
16400 PROC_WRITE_STORY_FILE(" estate. Sort of makes you wish you had")
16410 PROC_WRITE_STORY_FILE(" brought your camera, doesn't it?"+CHR$(FF))
16420 PROC_CLOSE_STORY_FILE
16430 ENDPROC
16440 :
16450 REM :::::::::::::::::::
16460 REM :: Getting brave ::
16470 REM :::::::::::::::::::
16480 DEF PROC_GETTING_BRAVE
16490 PROC_INIT_STORY_FILE("08")
16500 PROC_WRITE_STORY_FILE("Getting brave, :NM:?"+CHR$(FF))
16510 PROC_CLOSE_STORY_FILE
16520 ENDPROC
16530 :
16540 REM :::::::::::::::::::::::
16550 REM :: Nothing at window ::
16560 REM :::::::::::::::::::::::
16570 DEF PROC_NOTHING_AT_WINDOW
16580 PROC_INIT_STORY_FILE("59")
16590 PROC_WRITE_STORY_FILE("Oh well, maybe there wasn't anything")
16600 PROC_WRITE_STORY_FILE(" there, anyways..."+CHR$(NL))
16610 PROC_WRITE_STORY_FILE("OR WAS THERE???"+CHR$(FF))
16620 PROC_CLOSE_STORY_FILE
16630 ENDPROC
16640 :
16650 REM ::::::::::::::::::::
16660 REM :: Feeling sleepy ::
16670 REM ::::::::::::::::::::
16680 DEF PROC_FEELING_SLEEPY
16690 PROC_INIT_STORY_FILE("67")
16700 PROC_WRITE_STORY_FILE("You suddenly feel quite sleepy,")
16710 PROC_WRITE_STORY_FILE(" and seem to be moving towards the bed..."+CHR$(FF))
16720 PROC_CLOSE_STORY_FILE
16730 ENDPROC
16740 :
16750 REM :::::::::::::::::::::::
16760 REM :: Deathly-cold hand ::
16770 REM :::::::::::::::::::::::
16780 DEF PROC_DEATHLY_COLD_HAND
16790 PROC_INIT_STORY_FILE("80")
16800 PROC_WRITE_STORY_FILE("All of a sudden, you jump as you feel a")
16810 PROC_WRITE_STORY_FILE(" deathly-cold hand grab you from behind!"+CHR$(FF))
16820 PROC_CLOSE_STORY_FILE
16830 ENDPROC
16840 :
16850 REM :::::::::::::::::::::::::::::
16860 REM :: Hideous thing to behold ::
16870 REM :::::::::::::::::::::::::::::
16880 DEF PROC_HIDEOUS_THING
16890 PROC_INIT_STORY_FILE("95")
16900 PROC_WRITE_STORY_FILE("As you turn around, you are confronted")
16910 PROC_WRITE_STORY_FILE(" with the most gruesome creature")
16920 PROC_WRITE_STORY_FILE(" imaginable. In fact, it is so hideous that")
16930 PROC_WRITE_STORY_FILE(" your blood pressure skyrockets. The")
16940 PROC_WRITE_STORY_FILE(" strain is much too much for your heart,")
16950 PROC_WRITE_STORY_FILE(" and with a gasp of pain, you collapse")
16960 PROC_WRITE_STORY_FILE(" to the floor."+CHR$(FF))
16970 PROC_CLOSE_STORY_FILE
16980 ENDPROC
16990 :
17000 REM ::::::::::::::::
17010 REM :: Run for it ::
17020 REM ::::::::::::::::
17030 DEF PROC_RUN
17040 PROC_INIT_STORY_FILE("09")
17050 PROC_WRITE_STORY_FILE("You're frozen to the spot!!!"+CHR$(FF))
17060 PROC_CLOSE_STORY_FILE
17070 ENDPROC
17080 :
17090 REM :::::::::::::::::::::::
17100 REM :: Nobody behind you ::
17110 REM :::::::::::::::::::::::
17120 DEF PROC_NOBODY_BEHIND_YOU
17130 PROC_INIT_STORY_FILE("05")
17140 PROC_WRITE_STORY_FILE("You turn around, but no one's there!"+CHR$(FF))
17150 PROC_CLOSE_STORY_FILE
17160 ENDPROC
17170 :
17180 REM :::::::::::::::::
17190 REM :: One O'Clock ::
17200 REM :::::::::::::::::
17210 DEF PROC_ONE_AM
17220 PROC_INIT_STORY_FILE("60")
17230 PROC_WRITE_STORY_FILE("It's now 1 AM!!!"+CHR$(NL))
17240 PROC_WRITE_STORY_FILE("The door to the room suddenly flies")
17250 PROC_WRITE_STORY_FILE(" open, and in walks the old man. He's")
17260 PROC_WRITE_STORY_FILE(" apparently startled to see you (still)")
17270 PROC_WRITE_STORY_FILE(" standing there. With a nod of his head,")
17280 PROC_WRITE_STORY_FILE(" he motions you to follow him. You do")
17290 PROC_WRITE_STORY_FILE(" so, out of the room, down the stairs, and")
17300 PROC_WRITE_STORY_FILE(" back to the parlor, where you first")
17310 PROC_WRITE_STORY_FILE(" started tonight."+CHR$(FF))
17320 PROC_WRITE_STORY_FILE("Well, :NM:, sit down!!"+CHR$(NL))
17330 PROC_WRITE_STORY_FILE("Good show, good show! I'm glad someone")
17340 PROC_WRITE_STORY_FILE(" has finally survived. Looks like you've")
17350 PROC_WRITE_STORY_FILE(" broken the curse of that damned room.")
17360 PROC_WRITE_STORY_FILE(" I've got your check right here. Don't")
17370 PROC_WRITE_STORY_FILE(" worry, it's certified, all on the up and up."+CHR$(FF))
17380 PROC_CLOSE_STORY_FILE
17390 ENDPROC
17400 :
17410 REM :::::::::::::::::::::::::
17420 REM :: Survived the ordeal ::
17430 REM :::::::::::::::::::::::::
17440 DEF PROC_SURVIVED
17450 PROC_INIT_STORY_FILE("2C")
17460 PROC_WRITE_STORY_FILE("Well, fine then. Take care, :NM:, and thank")
17470 PROC_WRITE_STORY_FILE(" you so much for your help."+CHR$(FF))
17480 PROC_WRITE_STORY_FILE("As you walk away from the estate, check")
17490 PROC_WRITE_STORY_FILE(" clutched tightly in hand, you wonder if")
17500 PROC_WRITE_STORY_FILE(" it's all been worth it."+CHR$(NL))
17510 PROC_WRITE_STORY_FILE("Anyways, you've survived, you are")
17520 PROC_WRITE_STORY_FILE(" "+CHR$(17)+CHR$(GREEN)+"$1,000,000"+CHR$(17)+CHR$(FG%)+" wealthier,")
17530 PROC_WRITE_STORY_FILE(" and the curse of DEATH HOUSE is no more."+CHR$(NL))
17540 PROC_CLOSE_STORY_FILE
17550 PROC_INIT_STORY_FILE("2D")
17560 PROC_WRITE_STORY_FILE("All of a sudden, you hear a piercing")
17570 PROC_WRITE_STORY_FILE(" scream coming from the house. Maybe you")
17580 PROC_WRITE_STORY_FILE(" didn't break the curse after all."+CHR$(NL))
17590 PROC_WRITE_STORY_FILE("Perhaps - you were just - "+CHR$(17)+CHR$(GREEN)+"LUCKY"+CHR$(17)+CHR$(FG%)+"!!!"+CHR$(NL))
17600 PROC_CLOSE_STORY_FILE
17610 ENDPROC
17620 :
17630 REM :::::::::::::::
17640 REM :: Treachery ::
17650 REM :::::::::::::::
17660 DEF PROC_TREACHERY
17670 PROC_INIT_STORY_FILE("70")
17680 PROC_WRITE_STORY_FILE("As you sit there, sipping your tea,")
17690 PROC_WRITE_STORY_FILE(" you realize the old man is grinning")
17700 PROC_WRITE_STORY_FILE(" madly at you."+CHR$(NL))
17710 PROC_WRITE_STORY_FILE("The room starts to spin,")
17720 PROC_WRITE_STORY_FILE(" and you fall to the floor, teacup still")
17730 PROC_WRITE_STORY_FILE(" clutched in hand...")
17740 PROC_CLOSE_STORY_FILE
17750 ENDPROC
17760 :
17770 REM :::::::::::
17780 REM :: Death ::
17790 REM :::::::::::
17800 DEF PROC_DEATH
17810 PROC_INIT_STORY_FILE("6A")
17820 PROC_WRITE_STORY_FILE("You hear, off in the distance, a")
17830 PROC_WRITE_STORY_FILE(" door being opened, followed by furtive")
17840 PROC_WRITE_STORY_FILE(" footsteps. With the strength only a")
17850 PROC_WRITE_STORY_FILE(" dying man could muster, you manage to")
17860 PROC_WRITE_STORY_FILE(" open your eyes. The old man is now")
17870 PROC_WRITE_STORY_FILE(" standing over you, sadly shaking his")
17880 PROC_WRITE_STORY_FILE(" head. You try to speak, but can only")
17890 PROC_WRITE_STORY_FILE(" gasp in pain. Slowly, the vision of the")
17900 PROC_WRITE_STORY_FILE(" old man dims, and with a final heavy")
17910 PROC_WRITE_STORY_FILE(" sigh, you pass from this world."+CHR$(FF))
17920 PROC_CLOSE_STORY_FILE
17930 PROC_INIT_STORY_FILE("6B")
17940 PROC_WRITE_STORY_FILE("Suddenly you find yourself standing")
17950 PROC_WRITE_STORY_FILE(" back by the bed. Astonished, you feel")
17960 PROC_WRITE_STORY_FILE(" a great sense of relief wash over you."+CHR$(NL))
17970 PROC_WRITE_STORY_FILE("It must have all been a dream. You're")
17980 PROC_WRITE_STORY_FILE(" alive - you've survived, and soon you'll")
17990 PROC_WRITE_STORY_FILE(" be a millionaire! Your reverie gets cut")
18000 PROC_WRITE_STORY_FILE(" short when you see a ghastly creature")
18010 PROC_WRITE_STORY_FILE(" walk out of the wall in front of you!"+CHR$(NL))
18020 PROC_WRITE_STORY_FILE("Joy turns to panic, and you reach for")
18030 PROC_WRITE_STORY_FILE(" the doorknob, but your hand passes on")
18040 PROC_WRITE_STORY_FILE(" through it. You turn slowly around,")
18050 PROC_WRITE_STORY_FILE(" and come face to face with a roomful")
18060 PROC_WRITE_STORY_FILE(" of ghosts. You notice that they no")
18070 PROC_WRITE_STORY_FILE(" longer seem to eye you malevolently,")
18080 PROC_WRITE_STORY_FILE(" but appear to be... just waiting."+CHR$(FF))
18090 PROC_WRITE_STORY_FILE("Now the full horror of it all dawns on")
18100 PROC_WRITE_STORY_FILE(" you. You HAVE DIED; you're just like")
18110 PROC_WRITE_STORY_FILE(" them, and like them, for all eternity,")
18120 PROC_WRITE_STORY_FILE(" you'll keep watch here, waiting for")
18130 PROC_WRITE_STORY_FILE(" another fool to enter..."+CHR$(NL))
18140 PROC_WRITE_STORY_FILE(STRING$((CW% - 16) DIV 2, CHR$(BLANK))+CHR$(17)+CHR$(RED)+"DEATH HOUSE"+CHR$(17)+CHR$(FG%)+"!"+CHR$(FF))
18150 PROC_CLOSE_STORY_FILE
18160 ENDPROC
18170 :
18180 REM :::::::::::::::::::::::::::::
18190 REM :: Initialize a story file ::
18200 REM :::::::::::::::::::::::::::::
18210 DEF PROC_INIT_STORY_FILE(id$)
18220 F0% = OPENOUT("DATA/DAT" + id$ + ".BIN")
18230 ENDPROC
18240 :
18250 REM ::::::::::::::::::::::::
18260 REM :: Write a story file ::
18270 REM ::::::::::::::::::::::::
18280 DEF PROC_WRITE_STORY_FILE(text$)
18290 LOCAL i%
18300 FOR i% = 1 TO LEN(text$)
18310   BPUT#F0%, ASC(MID$(text$, i%, 1))
18320 NEXT i%
18330 ENDPROC
18340 :
18350 REM ::::::::::::::::::::::::
18360 REM :: Close a story file ::
18370 REM ::::::::::::::::::::::::
18380 DEF PROC_CLOSE_STORY_FILE
18390 CLOSE#F0%
18400 ENDPROC
18410 :
18420 REM :::::::::::::::::::::::::::::::::::
18430 REM :: Erase contents of text buffer ::
18440 REM :::::::::::::::::::::::::::::::::::
18450 DEF PROC_ERASE_TEXT
18460 TX_Pointer% = 0:REM Reset Pointer to text buffer
18470 $TX = STRING$(TX_SIZE%, CHR$(CR))
18480 ENDPROC
18490 :
18500 REM :::::::::::::::::::::::::::::::::::
18510 REM :: Write text to the text buffer ::
18520 REM :::::::::::::::::::::::::::::::::::
18530 DEF PROC_WRITE_TEXTB(text$)
18540 LOCAL i%
18550 IF TX_Pointer% + LEN(text$) > TX_SIZE% THEN ERROR 19, "String too long"
18560 FOR i% = 1 TO LEN(text$)
18570   $(TX + TX_Pointer%) = MID$(text$, i%, 1)
18580   TX_Pointer% = (TX_Pointer% + 1)
18590 NEXT i%
18600 ENDPROC
18610 :
18620 REM ::::::::::::::::::::::::::::::
18630 REM :: Read contents of binary  ::
18640 REM :: file and write them to   ::
18650 REM :: the internal text buffer ::
18660 REM ::::::::::::::::::::::::::::::
18670 DEF PROC_WRITE_TEXTF(id$)
18680 LOCAL infile%, i%, l%
18690 l% = -1
18700 infile% = OPENIN("data/dat"  + id$ + ".bin")
18710 IF infile% <> 0 THEN l% = EXT#infile%
18720 IF l% > 0 AND TX_Pointer% + l% > TX_SIZE% THEN ERROR 19, "String too long"
18730 PTR#infile% = 0:REM Position file pointer at beginning of file
18740 FOR i% = 1 TO l%
18750   $(TX + i% - 1) = CHR$(BGET#infile%)
18760 NEXT i%
18770 TX_Pointer% = (TX_Pointer% + l%)
18780 CLOSE#infile%
18790 ENDPROC
18800 :
18810 REM ::::::::::::::::::::::::::::::::::::::
18820 REM :: Read text out of the text buffer ::
18830 REM ::::::::::::::::::::::::::::::::::::::
18840 DEF FN_READ_TEXT(pos%)
18850 LOCAL n%, r$
18860 IF pos% > TX_SIZE% THEN ERROR 14, "Reference array incorrect"
18870 r$ = $(TX + pos%)
18880 := r$
