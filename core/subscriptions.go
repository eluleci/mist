package mist

type (
	subscriptions interface {
		Add([]string)
		Remove([]string)
		Match([]string) bool
		ToSlice() []string
	}
)

type (
	// Node ...
	Node struct {
		keyMap map[string]bool
	}
)

func newNode() (node *Node) {

	node = &Node{
		keyMap: map[string]bool{},
	}

	return
}

// Adds keys to the node
func (node *Node) Add(keys []string) {
	if len(keys) == 0 {
		return
	}

	for _, key := range keys {
		node.keyMap[key] = true
	}
}

// Removes keys from node
func (node *Node) Remove(keys []string) {

	if len(keys) == 0 {
		return
	}

	for _, key := range keys {
		delete(node.keyMap, key)
	}
}

// Match checks if the key exists in the node
func (node *Node) Match(keys []string) bool {
	return node.match(keys)
}

// ​match ...
func (node *Node) match(keys []string) bool {
	if len(keys) == 0 {
		return false
	}

	// iterate through each key looking for a leaf, if found it's a match
	for _, key := range keys {
		if node.keyMap[key] {
			return true
		}
	}

	return false
}

// ToSlice recurses down an entire node returning a list of all branches and leaves
// as a slice of slices
func (node *Node) ToSlice() (list []string) {

	for k := range node.keyMap {
		list = append(list, k)
	}

	return
}
