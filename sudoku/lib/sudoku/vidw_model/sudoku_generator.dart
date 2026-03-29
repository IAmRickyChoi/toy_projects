import 'dart:math';

class SudokuGenerator {
  final int _size = 9;
  final List<List<int>> _board = List.generate(9, (_) => List.filled(9, 0));
  final Random _random = Random();

  // 메인 함수: 완성된 판을 만들고 난이도에 맞게 구멍을 뚫습니다.
  List<List<int>> generate(int emptyCells) {
    _fillBoard(); // 1. 완성된 보드 생성 (Backtracking)
    _removeCells(emptyCells); // 2. 난이도에 따른 숫자 제거
    return _board;
  }

  // 보드 채우기 (Backtracking / バックトラッキング)
  bool _fillBoard() {
    for (int row = 0; row < _size; row++) {
      for (int col = 0; col < _size; col++) {
        if (_board[row][col] == 0) {
          List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]..shuffle();
          for (int num in numbers) {
            if (_isValid(_board, row, col, num)) {
              _board[row][col] = num;
              if (_fillBoard()) return true;
              _board[row][col] = 0; // 유효하지 않으면 다시 0으로 (Backtracking)
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  // 규칙 검사 (Validation / 妥当性確認)
  bool _isValid(List<List<int>> board, int row, int col, int num) {
    // 가로, 세로 검사
    for (int i = 0; i < _size; i++) {
      if (board[row][i] == num || board[i][col] == num) return false;
    }
    // 3x3 박스 검사
    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[startRow + i][startCol + j] == num) return false;
      }
    }
    return true;
  }

  // 난이도에 따라 숫자 제거 (Cell Removal / セル削除)
  void _removeCells(int count) {
    int removed = 0;
    while (removed < count) {
      int row = _random.nextInt(_size);
      int col = _random.nextInt(_size);
      if (_board[row][col] != 0) {
        _board[row][col] = 0;
        removed++;
      }
    }
  }
}
