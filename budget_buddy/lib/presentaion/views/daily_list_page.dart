import 'package:budget_buddy/presentaion/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class DailyListPage extends StatefulWidget {
  DailyListPage({super.key});

  @override
  State<DailyListPage> createState() => _DailyListPageState();
}

class _DailyListPageState extends State<DailyListPage> {
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                        "Test",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        " 12,230 ￥",
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
            itemCount: 40,
            itemBuilder: (context, index) {
              return ExpenseCard();
            },
          ),
        ],
      ),
    );
  }
}
