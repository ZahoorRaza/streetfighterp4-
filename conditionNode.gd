extends BTNode

class_name ConditionNode

var condition: Callable

func set_condition(_condition: Callable) -> ConditionNode:
	condition = _condition
	return self

func execute() -> NodeState:
	if condition.call():
		return NodeState.SUCCESS
	return NodeState.FAILURE
