extends Node

var altar_object = {1 : "candle"}

var musicVolume = 0.0
var fxVolume = 0.0
var spawn_active = false;

var alter_correct_location = {3 : 1}

var object_at_postion = {1:0,2:0,3:0,4:0,5:0}

var ghost_spawn_validation = [1,0,0,0,0,0]
var eye_spawn_validation = [1,2,0,0,0,0]
var tentacle_spawn_validation = [0,0,0,0,5,2]
var mantis_spawn_validation = [0,1,2,5,4,3]
var demon_spawn_validation = [0,0,2,1,4,0]
var max_page = 1;
var ghost1_summon_count = 0
var active_pages = [1]

var successful_summons =0;
var disable_screen_shake = false
 
var ghost_dialog_ghost_1 = ["Boo! ... you don't seem very scared.",
							"Most peole don't want a demon",
							"No",
							"Ghost powers.\r\nI should go."]

var ghost_dialog_reply_1 = ["Sorry, I'm trying to summon a demon. Not a ghost.",
"I need it to answer a question.\r\nYou wouldn't know where ...",
"How did you know what I was going to ask?",
"OK. Bye"]

var ghost_dialog_ghost_2 = ["Boo! ... you again. I still don't know your answer"]
var ghost_dialog_reply_2 = ["OK. Bye"]

var ghost_dialog_ghost_3 = ["Boo! ... you again. Do you mean to keep summoning me?",
"Will it happen again?"]
var ghost_dialog_reply_3 = ["Yes, it's all part of the process. Very intentional",
"Maybe"]

var eye_dialog_eye_1= ["I see you!!!", "I see across all the infernal planes",
 "Only you. All my eyes are on you summoner", "I'm always looking", "I'll be watching"]
var eye_dialog_reply_1= ["Yes, I guess you would", "What do you see in this plane",
 "That nice. \n\r I was looking for for someone else", "Yes. Goodbye", " ..."]


var tentacle_dialog_tentacle_1 = ["Hello my new friend"]
var tentacle_dialog_reply_1 = [" Nope. I've read enough grimoires to know where this is going.\r\n Goodbye"]

var mantis_dialog_mantis_1 = ["Click .. click,click ....click", "click .. click,click ....click",
"click .. click,click ....click","bye"]
var mantis_dialog_reply_1 = ["Hello. Are you a demon or just a very big mantis?",
"Do you speak human at all?", "I guess not. Goodbye", "What? ...."]


var demon_dialog_demon_1 = ["Mortal, why have you summoned Balror from his slumber", "Ahh. You lost them at the covern orgy then?",
"Forget I said anything.\r\nLet me see ... yes there they are.\r\nIn the pocket of the jeans on your bedroom floor",
"I am far to tired after last night. I really must be going"]
var demon_dialog_reply_1 = [" Hello Balror.\r\n I misplaced my keys yesterday and I really need them to get to work",
"No.\r\nWhat orgy?\r\nI didn't get an invite to..",
"Thank you. Um I have a few other questions.",
"Oh. Bye.\r\nI wonder why I wasn't invited ..."]




var bos_page1_left = "A simple summon requires only a guiding light to draw the spirit from the darkness"
var bos_page1_right = ""
var bos_page1_image_left = ""
var bos_page1_image_right = "res://Book/summon1.JPG"
var bos_page2_left = "Follow the light with something sharp to summon the all seeing eye. Or is that eyes"
var bos_page2_right = ""
var bos_page2_image_left = ""
var bos_page2_image_right = ""
var bos_page3_left = "I stand upon the rocky shore. To the west the sea sleeps calmly, it's secrets hidden below. To the east the vegetation rises green and healthy. What creature might is find in the place"
var bos_page3_right = ""
var bos_page3_image_left = ""
var bos_page3_image_right = ""
var bos_page4_left = "2, 3, 6, 5, 4"
var bos_page4_right = ""
var bos_page4_image_left = ""
var bos_page4_image_right = ""
var bos_page5_left = ""
var bos_page5_right = ""
var bos_page5_image_left = ""
var bos_page5_image_right = "res://Images/screen2.png"

var instr_1 = "This is your alter. It contains the tools for summoning.\r\nYou can drag them onto the points of the summoning circle"
var instr_2 = "This is the summoning circle. Place the correct item in the correct place to summon an entity"
var instr_3 = "This is the summoning button and power bar. Once your objects are in place. Hold down the button to power up the summoning circle."
var instr_4 = "If you want to remove an item form the summoning circle drag it away from the circle and it will retunr to the alter"
var instr_5 = "This is the book of shadows. Open it for your first hint. After each successful summons an new page is added to the book."
