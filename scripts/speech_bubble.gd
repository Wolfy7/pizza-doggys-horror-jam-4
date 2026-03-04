extends MarginContainer

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

func _ready() -> void:
	hide()
	rich_text_label.text = ""
	#_on_event_received("Das ist ein Tests")

#TODO: Queue
func _on_event_received(text: String, time: float = 2) -> void:
	rich_text_label.text = text
	show()
	await get_tree().create_timer(time).timeout
	hide()
	rich_text_label.text = ""
