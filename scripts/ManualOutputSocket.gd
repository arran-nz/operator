extends Node2D

@onready var output_socket := $Socket
@onready var manual_emmiter := $MorseButton

func _ready():
	manual_emmiter.pulse.connect(output_socket.emit_pulse)
