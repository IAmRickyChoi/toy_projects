import 'package:budget_buddy/data/models/expense_model.dart';
import 'package:budget_buddy/presentaion/view_models/expense_provider.dart';
import 'package:budget_buddy/presentaion/views/insight_page.dart';
import 'package:budget_buddy/presentaion/widgets/calendar_dialog.dart';
import 'package:budget_buddy/presentaion/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final expense = ref.watch(expenseListProvider);
    final now = ref.watch(selectedDateProvider);
    final String date =
        "${now.year.toString().substring(2)}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}";

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addExpense,
        backgroundColor: Colors.yellow[400],
        foregroundColor: Colors.yellow[800],
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromRGBO(255, 245, 157, 1),
      body: expense.when(
        data: (expenseList) {
          final totalToday = expenseList.fold<double>(
            0,
            (prev, element) => prev + element.price,
          );
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                title: isExpanded
                    ? null
                    : Text(
                        "${totalToday.toStringAsFixed(0)} ￥",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
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
                            date,
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${totalToday.toStringAsFixed(0)} ￥", // 예: "${myBudgetState.amount} ￥"
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
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return InsightPage();
                          },
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.bar_chart_outlined,
                      color: Colors.yellow[900],
                      size: 40,
                    ),
                  ),
                ],
              ),

              expenseList.isEmpty
                  ? SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(height: 25),
                          Text(
                            "No Budget today",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SliverList.builder(
                      itemCount: expenseList
                          .length, // 예: myBudgetState.expenses.length
                      itemBuilder: (context, index) {
                        return ExpenseCard(
                          item: expenseList[index].title,
                          price: expenseList[index].price,
                          datetime: expenseList[index].datetime,
                          onDelete: () => ref
                              .read(expenseListProvider.notifier)
                              .deleteExpense(expenseList[index].id),
                        );
                      },
                    ),
            ],
          );
        },

        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('에러: $err')),
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
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                final expense = ExpenseModel()
                  ..title = itemTextEditingController.text
                  ..price =
                      double.tryParse(itemPriceEditingController.text) ?? 0.0;
                ref.read(expenseListProvider.notifier).addExpense(expense);
                itemTextEditingController.clear();
                itemPriceEditingController.clear();
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
