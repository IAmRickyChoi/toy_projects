import 'package:sudoku/sudoku/model/sudoku_model.dart';
import 'package:sudoku/sudoku/vidw_model/sudoku_generator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sudoku_provider.g.dart'; // 코드 생성 파일 (コード生成ファイル)

@riverpod
class Sudoku extends _$Sudoku {
  @override
  SudokuState build() {
    // 초기값: 빈 보드 (빌드 시점에는 데이터가 없음)
    return SudokuState(board: []);
  }

  // 게임 시작 (Start Game / ゲーム開始)
  void startNewGame(int emptyCells) {
    final generator = SudokuGenerator();
    final rawBoard = generator.generate(emptyCells);

    final newBoard = List.generate(9, (r) {
      return List.generate(9, (c) {
        int val = rawBoard[r][c];
        return SudokuCell(value: val, isFixed: val != 0);
      });
    });

    state = state.copyWith(
      board: newBoard,
      selectedRow: null,
      selectedCol: null,
    );
  }

  // 셀 선택
  void selectCell(int row, int col) {
    state = state.copyWith(selectedRow: row, selectedCol: col);
  }

  // 숫자 입력 (Input / 入力)
  void updateValue(int num) {
    final r = state.selectedRow;
    final c = state.selectedCol;

    if (r == null || c == null || state.board[r][c].isFixed) return;

    // 새로운 보드 생성 (Deep Copy / ディープコピー)
    final newBoard = state.board.map((row) => [...row]).toList();
    newBoard[r][c] = SudokuCell(value: num, isFixed: false);

    state = state.copyWith(board: newBoard);
  }
}
