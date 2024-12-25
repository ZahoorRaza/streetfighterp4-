extends BTNode

class_name ActionNode

var action: Callable

func set_action(_action: Callable) -> ActionNode:
	action = _action
	return self

func execute() -> NodeState:
	action.call()
	return NodeState.SUCCESS
