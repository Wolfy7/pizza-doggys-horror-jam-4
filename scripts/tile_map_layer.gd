extends TileMapLayer

func get_tile_info(tile: Vector2i) -> TileInfo:
	print("Test")
	var data = get_cell_tile_data(tile)
	print(tile, data)
	if data:
		var tile_info: TileInfo = data.get_custom_data("Test")
		if tile_info:
			print(tile_info.drillable)
			return  tile_info
	return null

func can_move_to(tile: Vector2i) -> bool:
	# TODO
	return get_cell_atlas_coords(tile) == Vector2i(0,2)
	
func delete_tile(tile: Vector2i) -> void:
	set_cell(tile, 1, Vector2i(0,2), 0)	
	update_internals()
