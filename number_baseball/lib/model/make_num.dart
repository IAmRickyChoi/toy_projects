class MakeNum {
  List<int> gameNumbers = [];

  void generateNumbers() {
    List<int> ranNum = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

    ranNum.shuffle();

    gameNumbers = ranNum.sublist(0, 3);
  }
}
