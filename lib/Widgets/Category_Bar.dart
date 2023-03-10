import 'package:assignment1/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoryBar extends StatelessWidget {
  final List<Transaction> recentTransactions;

  CategoryBar(this.recentTransactions, {Key? key}) : super(key: key);

  Map<String, double> get groupedTransactions {
    final Map<String, double> categoryTotal = {};
    for (final tx in recentTransactions) {
      if (categoryTotal.containsKey(tx.category)) {
        categoryTotal[tx.category] = categoryTotal[tx.category]! + tx.amount;
      } else {
        categoryTotal[tx.category] = tx.amount;
      }
    }
    return categoryTotal;
  }

  @override
  Widget build(BuildContext context) {
    final categoryTotal = groupedTransactions;

    if (recentTransactions.length < 2) {
      return const SizedBox(); // if there are less than two transactions, return an empty SizedBox
    }
    return LayoutBuilder(
      builder: (BuildContext , BoxConstraints ) {
        return Card(
          color: Colors.white70,
          margin: const EdgeInsets.all(20),
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(

                width: 150,
                  height: BoxConstraints.maxHeight * 0.5,

                child: PieChart(PieChartData(
                  centerSpaceRadius: 30,
                  centerSpaceColor: Colors.yellow,
                  borderData: FlBorderData(show: false),
                  sections: [
                    PieChartSectionData(
                      value: categoryTotal['Food'],
                      color: Colors.purple,



                    ),
                    PieChartSectionData(
                      value: categoryTotal['Travel'] ,
                      color: Colors.orange,

                    ),
                  ],
                )

                ),
              ),SizedBox(
                width: 150,
                height: BoxConstraints.maxHeight * 0.5,
                child: Column(
mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple,
                      ),

                    ),const
                    Center(child: Text('Food ',style:
                    TextStyle(color: Colors.black),)),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),


                    ),
                    const Center(child: Text('Travel ',style:
                    TextStyle(color: Colors.black),)),
                  ],
                ),
              )
            ],




          ),);
      },

    );
  }
}
