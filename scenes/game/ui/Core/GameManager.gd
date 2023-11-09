extends Node

var current_checkpoint : Checkpoint

var player : CharacterBody2D


func respawn_player():
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
