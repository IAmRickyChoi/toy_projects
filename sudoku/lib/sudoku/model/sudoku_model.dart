// sudoku_state.dart
class SudokuCell {
  final int value;
  final bool isFixed;

  SudokuCell({required this.value, this.isFixed = false});
}

class SudokuState {
  final List<List<SudokuCell>> board;
  final int? selectedRow;
  final int? selectedCol;

  SudokuState({required this.board, this.selectedRow, this.selectedCol});

  // 상태 변경을 위한 copyWith 함수 (불변성 유지 / 不変性の維持)
  SudokuState copyWith({
    List<List<SudokuCell>>? board,
    int? selectedRow,
    int? selectedCol,
  }) {
    return SudokuState(
      board: board ?? this.board,
      selectedRow: selectedRow ?? this.selectedRow,
      selectedCol: selectedCol ?? this.selectedCol,
    );
  }
}
