extends BTNode

class_name SequenceNode

var children = []

func execute() -> NodeState:
	for child in children:
		var result = child.execute()
		if result != NodeState.SUCCESS:
			return result
	return NodeState.SUCCESS
