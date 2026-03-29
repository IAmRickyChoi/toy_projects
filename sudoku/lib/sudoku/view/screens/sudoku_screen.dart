import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sudoku/sudoku/model/sudoku_model.dart';
import 'package:sudoku/sudoku/view/providers/sudoku_provider.dart';

class SudokuScreen extends ConsumerWidget {
  // 클래스명이 중복될 수 있어 SudokuScreen으로 권장
  const SudokuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태(State) 구독
    final sudokuState = ref.watch(sudokuProvider);
    // 노티파이어(Notifier / ノーティファイア) 가져오기
    final notifier = ref.read(sudokuProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Master'),
        actions: [
          PopupMenuButton<int>(
            onSelected: (holes) => notifier.startNewGame(holes),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 30, child: Text('초급 (初級)')),
              const PopupMenuItem(value: 45, child: Text('중급 (中級)')),
              const PopupMenuItem(value: 55, child: Text('고급 (上級)')),
            ],
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // 1. 스도쿠 보드 영역
          _buildSudokuBoard(sudokuState, notifier),
          const Spacer(),
          // 2. 숫자 패드 영역
          _buildNumberPad(notifier),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // 노티파이어 타입을 Sudoku(클래스명)로 지정해야 합니다.
  Widget _buildSudokuBoard(SudokuState state, Sudoku notifier) {
    if (state.board.isEmpty) {
      return const Center(child: Text("상단의 설정 버튼을 눌러 게임을 시작하세요!"));
    }

    return Container(
      // height: 358,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 81,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          int r = index ~/ 9;
          int c = index % 9;
          final cell = state.board[r][c];
          final isSelected = state.selectedRow == r && state.selectedCol == c;

          return GestureDetector(
            onTap: () => notifier.selectCell(r, c),
            child: Container(
              decoration: BoxDecoration(
                color: _getCellColor(isSelected, cell.isFixed),
                border: Border(
                  bottom: BorderSide(width: (r % 3 == 2 && r != 8) ? 2 : 0.5),
                  right: BorderSide(width: (c % 3 == 2 && c != 8) ? 2 : 0.5),
                  top: const BorderSide(width: 0.5),
                  left: const BorderSide(width: 0.5),
                ),
              ),
              child: Center(
                child: Text(
                  cell.value == 0 ? "" : "${cell.value}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: cell.isFixed
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: cell.isFixed ? Colors.black : Colors.blueAccent,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNumberPad(Sudoku notifier) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          ...List.generate(9, (index) => index + 1).map((num) {
            return SizedBox(
              width: 60,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => notifier.updateValue(num),
                child: Text("$num", style: const TextStyle(fontSize: 24)),
              ),
            );
          }),
          SizedBox(
            width: 130,
            height: 60,
            child: OutlinedButton.icon(
              onPressed: () => notifier.updateValue(0),
              icon: const Icon(Icons.backspace_outlined),
              label: const Text("지우기"),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCellColor(bool isSelected, bool isFixed) {
    if (isSelected) return Colors.yellow.withOpacity(0.3);
    if (isFixed) return Colors.grey.withOpacity(0.1);
    return Colors.white;
  }
}
