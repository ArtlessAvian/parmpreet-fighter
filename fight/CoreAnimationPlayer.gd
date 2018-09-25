extends AnimationPlayer

onready var hitboxes = get_node("../Hitboxes")
onready var hurtboxes = get_node("../Hurtboxes")

# Observer / Facade
func set_state(current_state):
	var name = current_state.name
	if (current_state.has_method("animation_name")):
		name = current_state.animation_name()
	reset_and_play(name)

# Actual Methods
func reset_and_play(anim_name):
	self.play("Rest")
	self.advance(1)
	self.play(anim_name)

	for hitbox in hitboxes.get_children():
		hitbox.set_disabled(true)
		hitbox.scale.x = 0
		hitbox.scale.y = 0
#	for hurtbox in hurtboxes.get_children():
#		hurtbox.set_disabled(true)