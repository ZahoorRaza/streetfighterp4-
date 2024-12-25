extends BTNode

class_name SelectorNode

var children = []

func execute() -> NodeState:
	for child in children:
		var result = child.execute()
		if result == NodeState.SUCCESS:
			return NodeState.SUCCESS
	return NodeState.FAILURE
