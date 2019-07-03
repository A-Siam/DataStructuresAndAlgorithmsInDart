//ex 3.2
import 'dart:collection';
import 'dart:math';

rendomlyRemove(List l) {
  while (l.length != 0) {
    print(l);
    l.removeAt(Random(DateTime.now().millisecondsSinceEpoch).nextInt(l.length));
  }
}
/*
main(List<String> args) {
  rendomlyRemove([1,2,3,5,6,789]);
}*/

/// c-3.17:
/// Let A be an array of size n ≥ 2 containing integers from 1 to n − 1 inclusive, one
/// of which is repeated. Describe an algorithm for finding the integer in A that is
/// repeated.

int repeatedNumber(List<int> list) {
  int s = getSumOf(number: list.length - 1);
  int sumOfList = getSumOf(list: list);
  return abs(s - sumOfList);
}

int abs(int input) => input >= 0 ? input : -1 * input;
int getSumOf({List<int> list = null, int number = null}) {
  if (number == null) {
    int result = 0;
    list.forEach((x) {
      result += x;
    });
    return result;
  } else {
    int result = 0;
    while (number >= 1) {
      result += number;
      number--;
    }
    return result;
  }
}
/*
main(List<String> args) {
  print(repeatedNumber([1,2,3,4,5,6,7,8,8]));
}*/

/// Let B be an array of size n ≥ 6 containing integers from 1 to n − 5 inclusive, five
/// of which are repeated. Describe an algorithm for finding the five integers in B
/// that are repeated.

List<int> repeatedNumbers(List<int> B) {
  List<bool> l = new List(B.length - 1);
  List<int> repeated = [];
  B.forEach((x) {
    if (l[x - 1] != null) {
      repeated.add(x);
    } else {
      l[x - 1] = true;
    }
  });
  for (int i = 1; i < repeated.length; i++) {
    if (repeated[i] == repeated[i - 1]) {
      repeated.removeAt(i - 1);
      i--;
    }
  }
  return repeated;
}
/*
main(List<String> args) {
  print(repeatedNumbers([1,3,5,6,7,7,7,7,5,5,5,5,3,6,6,6,6,1,1,1,1]));
}*/

/*Write a method, shuffle(A), that rearranges the elements of array A so that every
possible ordering is equally likely. You may rely on the nextInt(n) method of
the java.util.Random class, which returns a random number between 0 and n − 1
inclusive.
*/

List<String> shuffle(List<String> list) {
  List<String> result = List(list.length);
  Random r = Random(DateTime.now().millisecondsSinceEpoch);
  final contant = list.length;
  var index = list.length;
  for (var i = 0; i < contant; i++) {
    int x = r.nextInt(index);
    result[i] = list[x];
    index--;
    list.removeAt(x);
  }
  return result;
}
/*
main(List<String> args) {
  print(shuffle(["list","list5","lisy8","lst89","list750"]));
} */

class TimeTable {
  List<int> players;
  List<int> resultsTable;
  HashSet<Meeting> meetings;
  TimeTable({this.players}) {
    resultsTable = List<int>(players.length);
    for (int v = 0; v < players.length; v++) {
      resultsTable[v] = 0;
    }
    meetings = HashSet<Meeting>();
  }

  meet(int i, int j) {
    if (i == j) throw Exception("a player cannot play aganist himself");
    int oldsize = meetings.length;
    Meeting m = Meeting(player1: i, player2: j);
    print(m.hashCode);
    meetings.add(m);
    resultsTable[i - 1] += (meetings.length - oldsize);
    resultsTable[j - 1] += (meetings.length - oldsize);
  }

  int winner() {
    for (var i = 0; i < players.length; i++) {
      if (resultsTable[i] >= players.length + 1) return i + 1;
    }
    return -1;
  }
}

class Meeting {
  int player1, player2;
  Meeting({this.player1, this.player2});
  @override
  get hashCode => (((player1 * player2) + (player2 + player1)));
}

main(List<String> args) {
  TimeTable t = TimeTable(players: [1, 2, 3, 4, 5, 6]);
/*  t.meet(1, 5); //1 5
  t.meet(6, 1); //1 6
  t.meet(1, 2); //1 2
  t.meet(3, 1); //1 3
  t.meet(1, 6); //1 6
  t.meet(2, 3);
  t.meet(1, 4);
  t.meet(1, 3); //1 3 */
  print(t.winner() != -1 ? "player ${t.winner()} WIN!" : "DRAW!");
}

