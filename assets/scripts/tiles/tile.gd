@tool

class_name Tile
extends TextureRect

const CHECK = preload("res://assets/scripts/utils/check.gd")

var __CAN_CONNECT_TOP: bool
var __CAN_CONNECT_LEFT: bool
var __CAN_CONNECT_RIGHT: bool
var __CAN_CONNECT_BOTTOM: bool
var __TYPE: String

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _loadTexture(path: String) -> void:
	CHECK.fileExtension(path, "png")
	texture = load(path)

func canConnectTop() -> bool:
	return __CAN_CONNECT_TOP
	
func canConnectBottom() -> bool:
	return __CAN_CONNECT_BOTTOM
	
func canConnectLeft() -> bool:
	return __CAN_CONNECT_LEFT
	
func canConnectRight() -> bool:
	return __CAN_CONNECT_RIGHT
	
func getType() -> String:
	return __TYPE
