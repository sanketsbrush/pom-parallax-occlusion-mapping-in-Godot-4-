@tool
extends MultiMeshInstance3D
@export var update:bool=false
@export var POM_layers:int=10
@export var gap_between_layers:float=0.01
@export var mesh:Mesh=PlaneMesh.new()

func _ready():
	do_POM()

func _process(delta):
	if update:
		do_POM()
		update=false

func do_POM():
	
	if mesh==null:mesh=PlaneMesh.new()
	
	cast_shadow=0
	multimesh=MultiMesh.new()
	multimesh.transform_format=MultiMesh.TRANSFORM_3D
	multimesh.use_colors=true
	multimesh.mesh=mesh
	multimesh.instance_count=POM_layers
	
	for i in POM_layers:
		var layer_origin=Vector3(0,(POM_layers*gap_between_layers)-(i*gap_between_layers),0)
		var layer_transform=Transform3D(Vector3(1,0,0),Vector3(0,1,0),Vector3(0,0,1),layer_origin)
		multimesh.set_instance_transform(i,layer_transform)
		var instance_alpha=(float(i)/float(POM_layers))
		multimesh.set_instance_color(i,Color(Color(instance_alpha,instance_alpha,instance_alpha),instance_alpha))
