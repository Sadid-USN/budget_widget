import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart(this.expenses);
  final List<double> expenses;
  @override
  Widget build(BuildContext context) {
    double moustExpensive = 0;
    expenses.forEach((double prise) {
      if (prise > moustExpensive) {
        moustExpensive = prise;
      }
    });
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            'Weekly Spending',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: Colors.blueGrey,
                  )),
              Text(
                'Nov 1, 2021 - Now 6, 2021',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 25,
                    color: Colors.blueGrey,
                  )),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                  lable: 'Su',
                  amounthSpent: expenses[0],
                  moustExpensive: moustExpensive),
              Bar(
                  lable: 'Mo',
                  amounthSpent: expenses[1],
                  moustExpensive: moustExpensive),
              Bar(
                  lable: 'Tu',
                  amounthSpent: expenses[2],
                  moustExpensive: moustExpensive),
              Bar(
                  lable: 'We',
                  amounthSpent: expenses[3],
                  moustExpensive: moustExpensive),
              Bar(
                  lable: 'Th',
                  amounthSpent: expenses[4],
                  moustExpensive: moustExpensive),
              Bar(
                  lable: 'Fr',
                  amounthSpent: expenses[5],
                  moustExpensive: moustExpensive),
              Bar(
                  lable: 'Sa',
                  amounthSpent: expenses[6],
                  moustExpensive: moustExpensive),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String lable;
  final double amounthSpent;
  final double moustExpensive;
  final double _maxBarHeight = 150.0;
  const Bar({this.lable, this.amounthSpent, this.moustExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeitght = amounthSpent / moustExpensive * _maxBarHeight;
    return Column(
      children: [
        Text(
          '\$${amounthSpent.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: barHeitght,
          width: 18.0,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(6.0)),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          lable,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
