class _Node<E> {
  _Node next;
  E data;
  _Node({this.next, this.data});
}

class LinkedList<E> {
  _Node<E> head, tail;
  int length = 0;
  LinkedList() {
    head = tail = _Node<E>();
  }
  bool isEmpty() => length == 0;
  addFirst(E data) {
    _Node<E> node = _Node(data: data);
    if (isEmpty()) {
      _initNode(node: node);
    } else {
      node.next = head;
      head = node;
    }
    length++;
  }

  addLast(E data) {
    _Node<E> node = _Node(data: data);
    if (isEmpty()) {
      _initNode(node: node);
    } else {
      tail.next = node;
      tail = node;
    }
    length++;
  }

  void removeFirst() {
    head = head.next;
    length--;
  }

  _initNode({node}) {
    node.next = null;
    head = tail = node;
  }

  @override
  String toString() {
    String result = "";
    _Node node = this.head;
    while (node != tail) {
      result += node.data.toString() + " ";
      node = node.next;
    }
    result += tail.data.toString();
    return result;
  }

  reverse(){
    List<_Node> currentState = [null,this.head];
    while(currentState[1] != null){
      currentState = _rev(currentState[0], currentState[1]);
    }
    //swapping head and tail
    _Node temp = this.head;
    this.head = this.tail;
    this.tail = temp;
  }
  List<_Node> _rev(prev,current){
    _Node next = current.next;
    _Node pre = current;
    current.next = prev;
    return [pre, next];
  }
}

main(List<String> args) {
  LinkedList<int> ll = LinkedList<int>();
  ll.addFirst(5);
  ll.addLast(55);
  ll.addFirst(555);
  ll.reverse();
  print(ll.toString());
}
