extends CanvasLayer

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_nodes_in_group("myPlayer")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(player.bullets)
	$Label2.text = str(player.sac_bullets)
