extends Control
var AmmoUIPart = preload("res://UI/ammo_ui_part.tscn")

var maxAmmo = 0
var currentAmmo = 0

func _load_Ammo_UI():
	for i in range(maxAmmo):
		var newAmmoUI = AmmoUIPart.instantiate()
		newAmmoUI.name = "AmmoUIPart" + str(i)
		newAmmoUI.position.y = i * 30
		add_child(newAmmoUI)
		print(get_children())
	
func _process(delta: float) -> void:
	for i in range(maxAmmo):
		if currentAmmo > i:
			get_node("AmmoUIPart" + str(i)).currentState = true
		else:
			get_node("AmmoUIPart" + str(i)).currentState = false
