import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/Screens/category_screen.dart';
import 'package:flutter_budget_ui/Widgets/bar_chart.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/helpers/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category, double totalAmounthSpent) {
    return GestureDetector(
      onTap: () {
        return Navigator.push(context,
            MaterialPageRoute(builder: (_) => CategoryScraan(category: category,)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        height: 100.0,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category.name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600)),
                Text(
                    '\$${(category.maxAmount - totalAmounthSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constrains) {
                final double maxBarWidth = constrains.maxWidth;
                final double percent =
                    (category.maxAmount - totalAmounthSpent) /
                        category.maxAmount;
                double barWidth = percent * maxBarWidth;
                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    Container(
                      width: barWidth,
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: getColor(context, percent),
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            forceElevated: true,
            expandedHeight: 100.0,
            // floating: true,
            pinned: true,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Simple Budget',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            if (index == 0) {
              return Container(
                margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      )
                    ]
                    ),
                child: BarChart(weeklySpending),
              );
            } else {
              final Category category = categories[index - 1];
              double totalAmounthSpent = 0;
              category.expenses.forEach((Expense expense) {
                totalAmounthSpent += expense.cost;
              });
              return _buildCategory(category, totalAmounthSpent);
            }
          }, childCount: 1 + categories.length))
        ],
      ),
    );
  }
}
