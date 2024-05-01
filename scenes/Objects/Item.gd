extends Interactable
class_name Item

static var holdingItem : Item

var itemColor : Color = Color()

@export var itemCollisionParent : Node

@export var itemActionsApplied = []

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	give_random_color()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	print(self.name)
	if !mouseRay.is_empty():
		holding_item_logic()


func give_random_color():
	itemColor.r = randf()
	itemColor.g = randf()
	itemColor.b = randf()
	var mat : Material = itemCollisionParent.get_parent().get_surface_override_material(0)
	mat.albedo_color = itemColor
	itemCollisionParent.get_parent().set_surface_override_material(0, mat)


func holding_item_logic():
	if holdingItem == null:
		position = position
	elif holdingItem == self:
		if (Station.hoveringStation == null):
			position = mouseRay["position"]
		else:
			position = Station.hoveringStation.itemSpotMarker.global_position
		if Input.is_action_just_pressed("action"):
			var hitNode = mouseRay["collider"].get_parent()
			if hitNode is Item:
				item_interact(hitNode)
			elif hitNode.get_parent() is Item:
				item_interact(hitNode.get_parent())
			holdingItem = null
			itemCollisionParent.get_node("CollisionShape3D").set_deferred("disabled", false)


func item_interact(itemHit : Item):
	pass

func on_just_left_clicked():
	print("Hi there!")
	print(mouseRay["collider"])
	print(itemCollisionParent)
	var colNode : CollisionShape3D = itemCollisionParent.get_node("CollisionShape3D")
	if !mouseRay.is_empty():
		if (mouseRay["collider"] == itemCollisionParent):
			colNode.set_deferred("disabled", true)
			if (holdingItem == null):
				holdingItem = self
			elif (holdingItem == self):
				print("Self!")
			else:
				print("Mix!")
	print(holdingItem)


func on_just_right_clicked():
	pass
