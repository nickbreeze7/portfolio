import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/widgets/bar_chart.dart';

class HomeScreen extends StatefulWidget {
  

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildCategory(Category category , double totalAmountSpent){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color:Colors.black12,
              offset: Offset(0,2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
            Text(category.name ,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
            ),
            Text('\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount}',
             style: TextStyle(
               fontSize: 18.0,
               fontWeight: FontWeight.w600,
             ),
            ),
           ],
        )
    ]
    ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomScrollView(
        slivers:<Widget>[
          SliverAppBar(
            forceElevated: true,
            //floating: true,
            pinned: true,
            expandedHeight: 100.0,
            leading: IconButton(
              icon: Icon(Icons.settings),
              iconSize: 30.0,
              onPressed: (){},
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Simple Budget'),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 30.0,
                  onPressed: (){},
              ),
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context , int index){
                        if(index == 0) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: BarChart(weeklySpending),
                          );
                        }else{
                          final Category caterogy = categories[index -1];
                          double totalAmountSpent = 0;
                          caterogy.expenses.forEach((Expense expense){
                            totalAmountSpent += expense.cost;
                          });
                          return _buildCategory(caterogy, totalAmountSpent);
                        }
                  },
                childCount: 1 + categories.length,
              ),
          ),
        ],
      ),
    );
  }
}
