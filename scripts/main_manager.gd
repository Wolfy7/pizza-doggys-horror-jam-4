extends Node2D

@onready var speech_bubble: MarginContainer = $Player2/SpeechBubble
@onready var player_2: Area2D = $Player2
@onready var texture_progress_bar: TextureProgressBar = $CanvasLayer/TextureProgressBar

enum GameState {INTRO, RUNNING, GAME_OVER, WINNING}

var move_counter: int = 0
var drill_counter: int = 0
var drill_bits_collected: int = 0
var game_state: GameState = GameState.INTRO
var drill_durability: int = 70 # in percent

func _ready() -> void:
	player_2.set_process_unhandled_input(false)
	texture_progress_bar.value = drill_durability

func _on_player_2_moved() -> void:
	move_counter += 1
	# TODO trigger events
	if move_counter == 1:
		speech_bubble._on_event_received("Look at you! 
Moving!
I’m so proud I could reboot.", 3)
	#print(move_counter)


func _on_player_2_drilled(usage: Variant) -> void:
	drill_counter += 1
	# TODO trigger events
	if drill_counter == 1:
		speech_bubble._on_event_received("Nice!
You made a hole!
That’s… surprisingly competent.", 3)
	# TODO decrease and check drill_durability
	drill_durability -= usage
	if drill_durability > 70 && drill_durability <= 80:
		speech_bubble._on_event_received("Careful!
Your drill bits are wearing 
down faster than your optimism.", 3.5)
	elif drill_durability > 20 && drill_durability <= 30:
		speech_bubble._on_event_received("Warning: drill durability critical!
[shake rate=20.0 level=5 connected=1]I recommend screaming internally.[/shake]", 3.5)
	elif drill_durability <= 0:
		game_over()

	texture_progress_bar.value = drill_durability
	#print(drill_counter, drill_durability)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "wake_up":
		game_state = GameState.RUNNING 
		player_2.set_process_unhandled_input(true)
		

func game_over() -> void:
	game_state = GameState.GAME_OVER 
	player_2.set_process_unhandled_input(false)
	speech_bubble._on_event_received("Your drill is dead.
And so are our chances.
Great teamwork!", 3.5)
	player_2.game_over()


func _on_player_2_drillbit_collected(strength: Variant) -> void:
	drill_bits_collected += 1
	# TODO trigger events
	if drill_bits_collected == 1:
		speech_bubble._on_event_received("Great
More durability! 
Now you can break me even slower.", 3)
	drill_durability = min(100, drill_durability+strength)
	if drill_durability == 100:
		speech_bubble._on_event_received("Back to 100%.
Let’s hope it lasts longer than the last time… 
or the last survivor.", 3)

	texture_progress_bar.value = drill_durability
