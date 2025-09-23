extends Control
var AmmoUIPart = preload("res://UI/ammo_ui_part.tscn")

var maxAmmo = 0
var currentAmmo = 0

var distanceFromTop = 40

func _load_Ammo_UI():
	for i in range(maxAmmo):
		var newAmmoUI = AmmoUIPart.instantiate()
		newAmmoUI.name = "AmmoUIPart" + str(i)
		newAmmoUI.position.y = (i * 15) + distanceFromTop
		add_child(newAmmoUI)
	
func _process(delta: float) -> void:
	for i in range(maxAmmo):
		if currentAmmo > i:
			get_node("AmmoUIPart" + str(i)).currentState = true
		else:
			get_node("AmmoUIPart" + str(i)).currentState = false
