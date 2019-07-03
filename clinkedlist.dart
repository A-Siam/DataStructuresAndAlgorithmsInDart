
class _Node<E> {
  _Node next;
  E data;
  _Node({this.next, this.data});
}

class LinkedList<E> {
  _Node<E> tail;
  int length = 0;
  LinkedList() {
    tail = _Node<E>();
  }
  bool isEmpty() => length == 0;

  addFirst(E data) {
    _Node<E> node = _Node(data: data);
    if (isEmpty()) {
      _initNode(node: node);
    } else {
      node.next = tail.next;
      tail.next = node;
    }
    length++;
  }

  addLast(E data) {
    addFirst(data);
    tail = tail.next;
  }

  void removeFirst() {
    tail.next = tail.next.next;
    length--;
  }

  _initNode({node}) {
    tail = node;
    tail.next = tail;
  }

  @override
  String toString() {
    String result = "";
    _Node node = this.tail.next;
    while (node != tail) {
      result += node.data.toString() + " ";
      node = node.next;
    }
    result += tail.data.toString();
    return result;
  }

  bool containTheSameSequence(LinkedList<E> input) {
    _Node iterator = this.tail.next;
    _Node tempIterator = input.tail.next;
    if (this.length!=input.length) return false;
    for(var i=0 ; i<input.length ;i++){
      if(tempIterator.data==iterator.data) break;
      if(i==input.length-1) return false;
      tempIterator = tempIterator.next;
    }
    for(var i=0 ;i<this.length;i++){
      if(iterator.data!=tempIterator.data) return false;
      tempIterator = tempIterator.next;
      iterator = iterator.next;
    }
    return true;
  }
  List<LinkedList> split(int n){
    if(this.length%n != 0) return null;
    _Node iteratorNode = this.tail.next;
    List<LinkedList<int>> result = List<LinkedList<int>>(n);
    for(var i =0 ;i<n ; i++){
      result[i] = new LinkedList<int>();
    }
    for(var i =0 ,j =0 ; i<length ; j=(++i)%(length/n)==0?j+1:j){
    /*print("value of i = $i\nvalue of j = $j");*/
      result[j].addLast(iteratorNode.data);
      iteratorNode=iteratorNode.next;
    }
    return result;
  }
}

main(List<String> args) {
  LinkedList<int> ll = LinkedList<int>();
  ll.addFirst(5);
  ll.addLast(55);
  ll.addFirst(555);
  ll.addLast(6);
  ll.addLast(66);
  ll.addFirst(666);
  ll.removeFirst();
  ll.removeFirst();
  LinkedList<int> l = LinkedList<int>();
  l.addFirst(55);
  l.addLast(6);
  l.addFirst(655);
  l.addLast(66);
  l.addLast(5);
  l.addLast(5);
  l.addLast(5);
  l.addFirst(666);
  l.removeFirst();
  l.removeFirst();
  print(ll.toString());
  print(l.toString());
  print(l.length);
  List<LinkedList> resulting = l.split(3);
  resulting.forEach((x){
    print("${x.toString()}");
    print("---------");
  });
/*  for(var x = 0, y = 0 ; x<4 ; y=(++x)%2==0?y+1:y){
    print("value of x = $x\nvalue of y = $y");
  }
*/
}
