extends Node2D

var arm_peice = preload("res://Player/ArmPeice.tscn")
var peice_lenght := 2.0
var arm_peices := []
var rope_close_tolerance = 3.0

onready var arm_start = $ShoulderEnd
onready var arm_end = $HandEnd

func spawn_arm(start_pos:Vector2, end_pos:Vector2):
	arm_start.global_position = start_pos
	arm_end.global_position = end_pos
	start_pos = arm_start.get_node("Collision/Joint").global_position
	end_pos = arm_end.get_node("Collision/Joint").global_position
	var distance = start_pos.distance_to(end_pos)
	var segment_ammount = round(distance/peice_lenght)
	
	var spawn_angle = (end_pos - start_pos).angle() - PI/2
	create_arm(segment_ammount, arm_start, end_pos, spawn_angle)
	

		
func add_arm_peice(parent:Object, id:int, spawn_angle:float):
	var joint :PinJoint2D =  parent.get_node("Collision/Joint") as PinJoint2D
	var segment : Object = arm_peice.instance() as Object
	segment.position = joint.position
	segment.rotation = spawn_angle
	segment.parent = self
	segment.id = id
	add_child(segment)
	joint.node_a = parent.get_path()
	joint.node_b = segment.get_path()
	return segment

func _ready():
	spawn_arm($Shoulder.global_position, $SixShooter.global_position)


func create_arm(segment_number:int,  parent:Object, end_pos, spawn_angle:float)-> void:
	for i in segment_number:
		parent = add_arm_peice(parent, i, spawn_angle)
		parent.set_name("arm_peice"+str(i))
		arm_peices.append(parent)
		
		var joint_pos = parent.get_node("Collision/Joint").global_position
		if(joint_pos.distance_to(end_pos) < rope_close_tolerance):
			break
	arm_end.get_node("Collision/Joint").node_a = arm_end.get_path()
	arm_end.get_node("Collision/Joint").node_b = arm_peices[-1].get_path()
	
