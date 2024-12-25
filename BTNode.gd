extends Node

class_name BTNode

enum NodeState { SUCCESS, FAILURE, RUNNING }

func execute() -> NodeState:
	# Base method to be overridden
	return NodeState.SUCCESS
