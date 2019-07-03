/// doubly linked list
class _Node<E> {
  _Node<E> prev, next;
  E data;
  _Node({this.prev, this.next, this.data});
}

class DoublyLinkedList<E> {
  _Node<E> header, tailer;
  int length;
  DoublyLinkedList() {
    tailer = _Node(data: null, prev: header, next: null);
    header = _Node(data: null, prev: null, next: tailer);
    header.next = tailer;
    tailer.prev = header;
    length = 0;
  }
  bool isEmpty() => length == 0;
  E first() => header.next.data;
  E last() => tailer.prev.data;

  addBetween(E data, _Node prev, _Node next) {
    _Node<E> n = _Node<E>(data: data, next: next, prev: prev);
    prev.next = n;
    next.prev = n;
    length++;
  }

  removeBetween(_Node prev, _Node next) {
    prev.next = next;
    next.prev = prev;
    length--;
  }

  addFirst(E data) {
    addBetween(data, header, header.next);
  }

  addLast(E data) {
    addBetween(data, tailer.prev, tailer);
  }

  removeFirst() {
    removeBetween(header, header.next.next);
  }

  removeLast() {
    removeBetween(tailer.prev.prev, tailer);
  }

  @override
  String toString() {
    var result = "[ ";
    _Node iterator = this.header;
    while (iterator.next != tailer) {
      result += iterator.next.data.toString() + " ";
      iterator = iterator.next;
    }
    result += "]";
    return result;
  }

  bool equals(DoublyLinkedList dll) {
    bool result = true;
    result &= (this.length == dll.length);
    if (result) {
      _Node n1 = header;
      _Node n2 = dll.header;
      while (n1 != this.tailer) {
        if (n1.data != n2.data) {
          return false;
        }
        n1 = n1.next;
        n2 = n2.next;
      }
    }
    return result;
  }

  List<E> toList() {
    List<E> result = [];
    _Node iterator = this.header.next;
    while (iterator != this.tailer) {
      result.add(iterator.data);
      iterator = iterator.next;
    }
    return result;
  }

  DoublyLinkedList<E> clone() {
    DoublyLinkedList<E> result = DoublyLinkedList<E>();
    List<E> data = toList();
    data.forEach((E) {
      result.addLast(E);
    });
    return result;
  }

/// 3.8 Describe a method for finding the middle node of a doubly linked list with header
/// and trailer sentinels by “link hopping,” and without relying on explicit knowledge
/// of the size of the list. In the case of an even number of nodes, report the node
/// slightly left of center as the “middle.” What is the running time of this method?

  E middleNodeData() {
    _Node left = header;
    _Node right = tailer;

    while (right != left) {
      right = right.prev;
      if (right == left) return right.data;
      left = left.next;
      if (left == right) return left.data;
    }
    return null;
  }
}

main(List<String> args) {
  DoublyLinkedList<int> d = DoublyLinkedList<int>();

  d.addFirst(5);
  print(d);
  d.addLast(6);
  print(d);
  d.addFirst(7);
  print(d);
  d.addFirst(8);
  print(d);
/*  d.addLast(99);
  print(d);
  d.removeFirst();
  print(d);
  d.removeLast();
  print(d);
  d.removeLast();
  print(d);*/

  print(d.middleNodeData());
}
