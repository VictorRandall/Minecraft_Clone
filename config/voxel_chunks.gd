extends Spatial

class_name VoxelChunk

var vsize = 4
var mesh_instance
var noise_seed
var x
var z
var chunk_size
var should_remove = true
var data = {}
var faces = {
	top = {
		v1 = Vector3(0,4,0),
		v2 = Vector3(4,4,0),
		v3 = Vector3(0,4,4),
		
		v4 = Vector3(0,4,4),
		v5 = Vector3(4,4,0),
		v6 = Vector3(4,4,4),
	},
	botton = {
		v1 = Vector3(0,0,4),
		v2 = Vector3(4,0,0),
		v3 = Vector3(0,0,0),
		
		v4 = Vector3(4,0,4),
		v5 = Vector3(4,0,0),
		v6 = Vector3(0,0,4),
	},
	left = {
		v1 = Vector3(4,0,0),
		v2 = Vector3(4,0,4),
		v3 = Vector3(4,4,0),
		
		v4 = Vector3(4,0,4),
		v5 = Vector3(4,4,4),
		v6 = Vector3(4,4,0),
	},
	right = {
		v1 = Vector3(4,4,0),
		v2 = Vector3(4,0,4),
		v3 = Vector3(4,0,0),
		
		v4 = Vector3(4,4,0),
		v5 = Vector3(4,0,4),
		v6 = Vector3(4,4,4),
	},
	front = {
		v1 = Vector3(),
		v2 = Vector3(),
		v3 = Vector3(),
		
		v4 = Vector3(),
		v5 = Vector3(),
		v6 = Vector3(),
	},
	back = {
		v1 = Vector3(),
		v2 = Vector3(),
		v3 = Vector3(),
		
		v4 = Vector3(),
		v5 = Vector3(),
		v6 = Vector3(),
	},
}

func _init(noise_seed, x, z, chunk_size):
	self.x = x
	self.z = z
	self.chunk_size = chunk_size
	self.noise_seed = noise_seed

func _ready():
	generate_chunk()
#	generate_water()
	

func generate_chunk():
	var st = SurfaceTool.new()
	var mat = preload("res://resouces/materials/blocks.tres")
	st.set_material(mat)
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
#	st.add_color(Color(255,0,0))
	st.add_uv(Vector2(0,0))
#	st.add_uv(Vector2(0.25,1))
#	st.add_vertex(Vector3(4, 4, 0))
#	st.add_vertex(Vector3(4, 0, 4))
#	st.add_vertex(Vector3(4, 0, 0))
#
#	st.add_vertex(Vector3(4, 4, 4))
#	st.add_vertex(Vector3(4, 0, 4))
#	st.add_vertex(Vector3(4, 4, 0))
	cube_faces(st,vsize)
	
#	st.add_vertex(Vector3(0,0,4))
#	st.add_vertex(Vector3(4,0,0))
#	st.add_vertex(Vector3(0,0,0))
#
#	st.add_vertex(Vector3(4,0,4))
#	st.add_vertex(Vector3(4,0,0))
#	st.add_vertex(Vector3(0,0,4))
	
	var mesh_instance = MeshInstance.new()
	mesh_instance.mesh = st.commit()
	mesh_instance.create_trimesh_collision()
	
	add_child(mesh_instance)

func cube_faces(st: SurfaceTool,s):
	#top
	st.add_vertex(Vector3(0,s,0))
	st.add_vertex(Vector3(s,s,0))
	st.add_vertex(Vector3(0,s,s))
	
	st.add_vertex(Vector3(0,s,s))
	st.add_vertex(Vector3(s,s,0))
	st.add_vertex(Vector3(s,s,s))
	#botton
	st.add_vertex(Vector3(0,0,s))
	st.add_vertex(Vector3(s,0,0))
	st.add_vertex(Vector3(0,0,0))
	
	st.add_vertex(Vector3(s,0,s))
	st.add_vertex(Vector3(s,0,0))
	st.add_vertex(Vector3(0,0,s))
	#left
	st.add_vertex(Vector3(s,0,0))
	st.add_vertex(Vector3(s,0,s))
	st.add_vertex(Vector3(s,s,0))
	
	st.add_vertex(Vector3(s,0,s))
	st.add_vertex(Vector3(s,s,s))
	st.add_vertex(Vector3(s,s,0))
	#right
	st.add_vertex(Vector3(s-s,s,0))
	st.add_vertex(Vector3(s-s,0,s))
	st.add_vertex(Vector3(s-s,0,0))

	st.add_vertex(Vector3(s-s,s,s))
	st.add_vertex(Vector3(s-s,0,s))
	st.add_vertex(Vector3(s-s,s,0))



func generate_water():
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(chunk_size, chunk_size)
	
	# you may need to change to water.tres if that is your material extension
	
	var mesh_instance = MeshInstance.new()
	mesh_instance.mesh = plane_mesh
	
	add_child(mesh_instance)

func set_block(x,y,z,id):
	pass

func get_block(x,y,z):
	var id = 0
	return id
