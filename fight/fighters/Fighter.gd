extends Node2D
signal got_hit(health, enemy_combo)
signal combo_escape()
signal im_dead(who)

export (PackedScene) var my_core = null
export (PackedScene) var my_state_machine = null

var enemyTeam = null
var enemy_combo = 0
func get_enemy():
	return enemyTeam.get_child(0)

var vel = Vector2(0,0)
var grounded = true
var air_action = 2

var motions = {
	"214" : "TATSUMAKISEMPUYAKU",
	"236" : "HADOOOOOOKEN"
}

var sound_bank = [
	preload("res://res/bleh/Swing.wav")
]

func _ready():
	$Core.replace_by_instance(my_core)
	$StateMachine.replace_by_instance(my_state_machine)
	$StateMachine.connect("new_state", $Core, "_on_StateMachine_new_state")
	
	$Core/AnimationPlayer.playback_active = false
	$StateMachine.set_physics_process(false)

func _physics_process(delta):
	if ($Core.hitstop > 0):
		if (enemy_combo > 0):
			$Core.modulate.g = 1.0 / $Core.hitstop
			$Core.modulate.b = 1.0 / $Core.hitstop
		$Core.hitstop -= 1
		$Core/AnimationPlayer.advance(0)
		return
	
#	TODO: Disable this method, and have an external object call these in the same order
	$StateMachine._physics_process(delta)
	$Core/AnimationPlayer.advance(1.0/60)
	move(delta)
	adjust()
	check_hit()
	get_hit()

func move(delta):
	position += vel
	if (!grounded):
		vel.y += 0.5
		if (position.y > 0):
			grounded = true
			position.y = 0
			vel.y = 0
			air_action = 2
			
			var goto_state = "Stand"
			if ($StateMachine.current_state.has_method("on_land")):
				goto_state = $StateMachine.current_state.on_land(self, $StateMachine.controller)
			if (goto_state != ""):
				$StateMachine.set_state(goto_state)

func adjust():
#	I guess it doesn't matter what order who does this, because itll be symmetrical?	
	if (self.grounded and get_enemy().grounded):
		var relat_vec = get_enemy().position.x - self.position.x
		if (abs(relat_vec) < 40):
#			var distance = min((40 - abs(relat_vec))/2, 1) bad gameplay choice ig
			var distance = (40 - abs(relat_vec))/2
			self.position.x += -distance * sign(relat_vec)
			get_enemy().position.x += distance * sign(relat_vec)

func check_hit():
	var hits = []
	var highest_priority = {"priority":-999}
	
	for hit in $Core.queued_hits:
		var data = $Core.queued_hits[hit]
		
		data["hitter"].have_hit = true;
		$Core.hitstop = 7
		data["hitter"].hitstop = 7
		
		# holding back and (in the air or (holding down on a low) or (not holding down on an overhead) or is mid)
#		if ($StateMachine.current_state):
		if ($StateMachine.current_state.can_block):
			if (-1 + 2 * ($StateMachine.controller.dir() % 3) == self.scale.x):
				if (!self.grounded or (!data["low"] and !data["high"]) or ($StateMachine.controller.dir() <= 3 and data["low"]) or ($StateMachine.controller.dir() > 3 and data["high"])):
					$Core.queued_hits.erase(hit)
					$StateMachine.set_state("BlockStun", data)
					CommonSounds.play("block")
					continue;
		
		hits.push_back(hit)
		if (data["priority"] > highest_priority["priority"]):
			highest_priority = data
		enemy_combo += 1
		
		$Core.health -= data["damage"]
		
		emit_signal("got_hit", $Core.health, enemy_combo)
	
	if (!hits.empty()):
		if ($Core.health <= 0):
			$StateMachine.set_state("Dead", highest_priority)
		else:
			$StateMachine.set_state("Reel", highest_priority)
	
	for hit in hits:
		$Core.queued_hits.erase(hit)
	

func get_hit():
#	if (hit_promise != -1):
#		hit_promise = -1
	pass
