import 'package:budget_buddy/presentaion/view_models/expense_provider.dart';
import 'package:budget_buddy/presentaion/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 1. 리버팟 패키지 임포트

// 2. ConsumerStatefulWidget으로 변경
class DailyListPage extends ConsumerStatefulWidget {
  DailyListPage({super.key});

  @override
  ConsumerState<DailyListPage> createState() => _DailyListPageState();
}

// 3. State 대신 ConsumerState로 변경
class _DailyListPageState extends ConsumerState<DailyListPage> {
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();
  TextEditingController itemTextEditingController = TextEditingController();
  TextEditingController itemPriceEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      bool isExpanded = scrollController.offset < (300 - kToolbarHeight);
      if (isExpanded != this.isExpanded) {
        setState(() {
          this.isExpanded = isExpanded;
        });
      }
    });
  }

  @override
  void dispose() {
    // 여담: 스크롤 컨트롤러는 메모리 누수(メモリリーク) 방지를 위해 꼭 dispose 해주는 게 좋아!
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 4. 여기서 ref.watch를 사용해서 프로바이더(プロバイダー)의 상태(状態)를 구독해!
    final _isar = ref.watch(expenseListProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addExpense,
        backgroundColor: Colors.yellow[400],
        foregroundColor: Colors.yellow[800],
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromRGBO(255, 245, 157, 1),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: isExpanded
                ? null
                : Text(
                    "today budget",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
            expandedHeight: 300,
            pinned: true,
            surfaceTintColor: Colors.yellow[200],
            backgroundColor: Colors.yellow[200],
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                width: double.infinity,
                child: Container(
                  color: Colors.yellow[600],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: kToolbarHeight),
                      Text(
                        "Test", // 예: myBudgetState.title
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        " 12,230 ￥", // 예: "${myBudgetState.amount} ￥"
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 40, // 예: myBudgetState.expenses.length
            itemBuilder: (context, index) {
              return ExpenseCard();
            },
          ),
        ],
      ),
    );
  }

  void addExpense() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[200],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: itemTextEditingController,
                decoration: InputDecoration(
                  hint: Text(
                    "item",
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
                  ),
                ),
              ),
              TextFormField(
                controller: itemPriceEditingController,
                decoration: InputDecoration(
                  hint: Text(
                    'price',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                itemTextEditingController.clear();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[400],
                foregroundColor: Colors.yellow[800],
              ),
              child: const Text(
                'Add',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
