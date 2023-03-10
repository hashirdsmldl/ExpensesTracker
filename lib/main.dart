import 'package:assignment1/Widgets/Category_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';
import './widgets/chart.dart';
import './model/transaction.dart';

void main() {


  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget  {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return  MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData.dark(useMaterial3:true ),








      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.dateTime.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate,String newCategory) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      dateTime: chosenDate,
      category: newCategory,

      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    final chart1Height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top) *
        0.3;
    final chart2Height = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top) *
        0.3;

    final txListHeight = (mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top) *
        0.4;
    return Scaffold(
      appBar: appBar,

      body: SingleChildScrollView(

        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(
                height: chart1Height,
                child: Chart(_recentTransactions)),
            SizedBox(
              height: chart2Height,
                child:
            CategoryBar(_recentTransactions)),

            Center(
              child: SizedBox(
                height: txListHeight,
                  child: TransactionList(_userTransactions, _deleteTransaction)),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}