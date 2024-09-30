extends Camera2D

var follow_player: bool = false
var current_room: int = 0
var speed = 500
var room_coord: Array = [Vector2(380,320), Vector2(1360, 440)]
@onready var player=$"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	position=room_coord[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if follow_player:
		position.x = move_toward(position.x, player.position.x, speed*delta)
		position.y = move_toward(position.y, player.position.y, speed*delta)
	else:
		position.x = move_toward(position.x, room_coord[current_room].x, speed*delta)
		position.y = move_toward(position.y, room_coord[current_room].y, speed*delta)


func _on_uscita_stanza_01_body_entered(body):
	if body.is_in_group("Player"):
		follow_player=true


func _on_entrata_stanza_0_body_entered(body):
	if body.is_in_group("Player"):
		follow_player=false
		current_room=0

func _on_entrata_stanza_1_body_entered(body):
	if body.is_in_group("Player"):
		follow_player=false
		current_room=1
