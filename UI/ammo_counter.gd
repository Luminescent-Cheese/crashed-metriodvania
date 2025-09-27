extends Control
@onready var BarrelUI = $BarrelUI
@onready var BarrelUIAnimation = $BarrelUIAnimationPlayer

var AmmoUIPart = preload("res://UI/ammo_ui_part.tscn")

var maxAmmo = 0
var currentAmmo = 0
var lastCurrentAmmo = 0

var distanceFromTop = 40

func _load_Ammo_UI():
	for i in range(maxAmmo):
		var newAmmoUI = AmmoUIPart.instantiate()
		newAmmoUI.name = "AmmoUIPart" + str(i)
		#newAmmoUI.position.y = (i * 15) + distanceFromTop
		newAmmoUI.global_position = get_child(0).get_child(i).global_position
		add_child(newAmmoUI)

func _reset_Ammo_UI():
	BarrelUI.rotation = 0
	lastCurrentAmmo = maxAmmo
	BarrelUIAnimation.play("spin")

func _spin_Ammo_UI():
	var rotationTween = get_tree().create_tween()
	rotationTween.tween_property(BarrelUI, "rotation",BarrelUI.rotation-1.0472,0.1)
	
func _process(delta: float) -> void:
	if currentAmmo != lastCurrentAmmo:
		_spin_Ammo_UI()
	for i in range(maxAmmo):
		if currentAmmo > i:
			get_node("AmmoUIPart" + str(i)).currentState = true
		else:
			get_node("AmmoUIPart" + str(i)).currentState = false
		get_node("AmmoUIPart" + str(maxAmmo - 1 -i)).global_position = get_child(0).get_child(i).global_position
	lastCurrentAmmo = currentAmmo
