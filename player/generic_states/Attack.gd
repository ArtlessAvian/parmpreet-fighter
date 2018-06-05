extends "../PlayerState.gd"

#export (bool) var is_overhead = false;
#export (bool) var is_low = false;
#export (int) var damage = 0;
#export (Array, int) var launchers = [];
export (int) var hitstun = 10;
export (int) var hitlag = 5;
#export ()

func run(controller):
	if (get_parent().get_node("AnimationPlayer").current_animation == ""):
		get_parent().subject.grounded_check(controller)

