extends Item
class_name Potion

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	set_item_name("Potion")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
