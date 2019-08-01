/// Linked List Section
class _Node<T> {
  T value;
  _Node<T> next, previous;
  _Node({value, next, previous})
      : value = value,
        next = next,
        previous = previous;
  hasNext() => next != null;
  hasPrevious() => previous != null;
}

/// LinkedList
class LinkedList<T> {
  bool _circular;
  _Node<T> head, tail;
  int length = 0;
  LinkedList.fromList({List<T> list, circular = false, doubly = false})
      : _circular = circular {
    list.forEach((item) {
      addItem(item);
    });
  }
  LinkedList({circular = false}) : _circular = circular;

  isCircular() => this._circular;

  addItem(T item) {
    if (length == 0) {
      head = _Node(value: item);
      tail = head;
      head.next = tail;
    } else {
      _Node temp = this.tail;
      tail = _Node(value: item, previous: temp);
      temp.next = tail;
    }
    tail.next = (_circular) ? head : null;
    length++;
  }

  addFirst(T item) {
    _Node<T> temp = _Node<T>(value: item);
    temp.next = this.head;
    head = temp;
    if (length == 0) {
      this.tail = temp;
      this.head = temp;
    }
    length++;
  }

  @override
  String toString() {
    String result = "[";
    _Node iterator = this.head;
    int counter = 0;
    while (iterator != null && iterator.hasNext()) {
      if (iterator == this.head && counter == 1) {
        result += "...";
        return result;
      } else if (iterator == this.head && counter == 0) {
        counter++;
      }
      result +=
          "${iterator.value}: previous= ${iterator.hasPrevious() ? iterator.previous.value : "null"}, next= ${iterator.hasNext() ? iterator.next.value : "null"}\n";
      iterator = iterator.next;
    }
    result +=
        "${tail != null ? "${tail.value}: previous= ${tail.previous.value}, next= null" : ""}]";
    return result;
  }

  operator +(LinkedList<T> next) {
    this.tail.next = next.head;
  }

  void removeFirst() {
    _Node<T> temp = this.head.next;
    if (temp != null) temp.previous = null;
    this.head = temp;
    if (isCircular()) this.tail.next = this.head;
    length--;
  }

  void moveHeadOneStep() {
    if (isCircular()) {
      _Node<T> temp = this.head;
      this.head = this.head.next;
      temp.previous = this.tail;
      temp.next = this.head;
      this.tail = temp;
    } else {
      head = head.next;
    }
  }
}

abstract class Stack<T> {
  push(T item);
  T pop();
  int length;
  T get top;
  bool isEmpty();

  /// returns a reversed stack
  Stack<T> reversed();
  void transfer(Stack<T> T);
}

class LinkedListBasedStack<T> implements Stack<T> {
  LinkedList<T> core = LinkedList<T>();
  int length = 0;
  @override
  bool isEmpty() => length == 0;
  LinkedListBasedStack();
  LinkedListBasedStack.fromList(List<T> list) {
    this.core = LinkedList.fromList(list: list.reversed.toList());
    length = list.length;
  }

  @override
  T get top => core.head.value;

  @override
  T pop() {
    if (length != 0) {
      length--;
      T returnedValue = core.head.value;
      core.removeFirst();
      return returnedValue;
    } else {
      return null;
    }
  }

  @override
  void push(T item) {
    core.addFirst(item);
    length++;
  }

  @override
  Stack<T> reversed() {
    Stack<T> result = LinkedListBasedStack<T>();
    while (!this.isEmpty()) {
      result.push(this.pop());
    }
    return result;
  }

  String toString() {
    String result = "";
    _Node<T> iterator = core.head;
    while (iterator != null && iterator.hasNext()) {
      result += "${iterator.value} ";
      iterator = iterator.next;
    }
    result += iterator != null ? "${iterator.value}" : "";
    return result;
  }

  @override
  void transfer(Stack<T> T) {
    T = this.reversed();
  }

  LinkedListBasedStack<T> getAcopy() {
    LinkedListBasedStack<T> result = LinkedListBasedStack();
    result.core = this.core;
    result.length = this.length;
    return result;
  }
}

abstract class Queue<T> {
  enqueue(T element);
  T dequeue();
  _Node<T> first;
  int length;
  isEmpty();
}

class LinkedListBasedQueue<T> implements Queue<T> {
  LinkedList<T> core;
  LinkedListBasedQueue({circular = false}) {
    core = LinkedList<T>(circular: circular);
  }
  LinkedListBasedQueue.fromList(List<T> list, {circular = false}) {
    core = LinkedList<T>.fromList(list: list, circular: circular);
    first = core.head;
    length = list.length;
  }
  @override
  int length = 0;
  var first = _Node<T>();
  @override
  T dequeue() {
    if (length == 0)
      return null;
    else if (length == 1) {
      _Node<T> temp = this.first;
      first = null;
      core.head = core.tail = null;
      length--;
      return temp.value;
    }
    _Node<T> tempNode = this.first;
    first = tempNode.next;
    core.removeFirst();
    length--;
    return tempNode.value;
  }

  @override
  void enqueue(T element) {
    core.addItem(element);
    if (length == 0) first = core.head;
    length++;
  }

  @override
  bool isEmpty() {
    return length == 0;
  }

  @override
  String toString() {
    return core.toString();
  }

  ///rotates the front element of tree to the back
  void rotate() {
    if (core.isCircular()) {
      first = core.head.next;
      core.moveHeadOneStep();
    }
  }
}

main(List<String> args) {
  /*List<int> value = [2, 5, 6, 7, 8, 8];*/
  /*LinkedListBasedQueue<int> llbq = LinkedListBasedQueue.fromList([5,6,7,8,9,7,10],circular: true);
  llbq.enqueue(5);
  llbq.enqueue(7);
  llbq.enqueue(9);
  llbq.rotate();
  llbq.rotate();
  llbq.dequeue();
  print(llbq.toString());*/
  /*Stopwatch stopwatch = Stopwatch()..start();
  print("the winner is: ${theJosephusProblem(11)}");
  print("the whole problem took ${stopwatch.elapsed}");*/

  /*LinkedListBasedStack<int> llbs = LinkedListBasedStack();
  llbs.push(5);
  llbs.push(6);
  llbs.push(556);
  print(llbs.toString());
  removeAllElementsOfStackRecursively(llbs);
  print(llbs.toString());*/
  result("8 * 5/7 - 10");
}

int theJosephusProblem(int nos) {
  Stopwatch stopwatch = Stopwatch()..start();
  List<int> los = List.generate(nos, (index) => index + 1);
  print("list generation took ${stopwatch.elapsed}");
  LinkedListBasedQueue<int> llbq =
      LinkedListBasedQueue.fromList(los, circular: true);
  while (llbq.length != 1) {
    llbq.rotate();
    llbq.dequeue();
  }
  return llbq.dequeue();
}

removeAllElementsOfStackRecursively(Stack stack) {
  if (stack.length == 0) return;
  stack.pop();
  removeAllElementsOfStackRecursively(stack);
}

double operation(String x, String y, String operation) {
  double result = 0;
  switch (operation) {
    case "+":
      result = double.parse(x) + double.parse(y);
      break;
    case "-":
      result = double.parse(x) - double.parse(y);
      break;
    case "*":
      result = double.parse(x) * double.parse(y);
      break;
    case "/":
      result = double.parse(x) / double.parse(y);
      break;
  }
  return result;
}

double result(String expr) {
  double res = 0;
  // print("trimmed string: ${expr.replaceAll(RegExp(r" "), "")}");
  List<String> operators = expr.replaceAll(RegExp(r" "), "").split(RegExp(r"\d+\.*\d*"));
  for (var i = 0; i < operators.length; i++) {
    if (operators[i].isEmpty) operators.removeAt(i);
  }
  List<String> summation = expr.replaceAll(RegExp(r" "), "").split(RegExp(r"[\++\-+\*\/]"));
  print(operators);
  print(summation);
  evaluatePostfix(toPostfix(operators, summation));
  return res;
}

String toPostfix(List<String> operations, List<String> numbers) {
  String result = "${numbers[0]} ";
  LinkedListBasedStack<String> operationsStack = LinkedListBasedStack();
  operationsStack.push(operations[0]);
  for (var i = 1; i <= operations.length; i++) {
    result += "${numbers[i]} ";

    ///if top higher than incput pop top and push input
    ///else just push
    if (hasHigherPresedence(operationsStack.top,
            operations[i < operations.length ? i : i - 1]) ||
        hasSamePresedence(operations[i < operations.length ? i : i - 1],
            operationsStack.top)) {
      //result+="${operationsStack.pop()} ";
      while (!operationsStack.isEmpty()) result += "${operationsStack.pop()} ";
      operationsStack.push(operations[i < operations.length ? i : i - 1]);
    } else {
      operationsStack.push(operations[i < operations.length ? i : i - 1]);
    }
  }
  print(result);
  return result;
}

bool hasHigherPresedence(String a, String b) =>
    (a == "*" || a == "/") && (b == "+" || b == "-");

bool hasSamePresedence(String a, String b) =>
    ((a == "*" || a == "/") && (b == "*" || b == "/")) ||
    ((a == "+" || a == "-") && (b == "+" || b == "-"));

double evaluatePostfix(String postfix) {
  double result;
  List<String> operations = postfix.split(RegExp(r"[0-9\s\.]+"));
  for (var i = 0; i < operations.length; i++) {
    if (operations[i].isEmpty) operations.removeAt(i);
  }
  List<String> numbers = postfix.split(RegExp(r"[\/\*\+\-\s]+"));
  for (var i = 0; i < numbers.length; i++) {
    if (numbers[i].isEmpty) numbers.removeAt(i);
  }
  print(operations);
  LinkedListBasedStack<String> operationsStack =
      LinkedListBasedStack.fromList(operations);
  operationsStack = operationsStack.reversed();
  LinkedListBasedStack<String> numbersStack =
      LinkedListBasedStack.fromList(numbers);
  numbersStack = numbersStack.reversed();
  print(numbersStack);
  while (numbersStack.length>1) {
    numbersStack.push(
        operation(numbersStack.pop(), numbersStack.pop(), operationsStack.pop())
            .toString());
  }
  result = double.parse(numbersStack.pop());
  print(result);
  return result;
}
