import 'package:flutter/material.dart';
import 'package:third_app/widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_Transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Quicksand'),
      home: const _MyHomePage(),
    );
  }
}

//------------------------------------------------------------------------//

class _MyHomePage extends StatefulWidget {
  const _MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<Transaction> get _lastWeekTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = false;

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   599.99,
    //   't1',
    //   DateTime.now(),
    //   'New Mobile',
    // ),
    // Transaction(
    //   19.99,
    //   't2',
    //   DateTime.now(),
    //   'Mobile Cover',
    // ),
  ];
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx =
        Transaction(txAmount, DateTime.now().toString(), chosenDate, txTitle);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
          // bottom: Radius.circular(25),
        ),
      ),
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

    final landScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title:
          const Text('Pocket Money', style: TextStyle(fontFamily: 'OpenSans')),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_box),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar,
      body: SingleChildScrollView(
          child: landScape
              ? Column(
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('Show Chart'),
                      Switch(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          }),
                    ]),
                    _showChart
                        ? SizedBox(
                            height: (mediaQuery.size.height -
                                    appBar.preferredSize.height -
                                    mediaQuery.padding.top) *
                                0.65,
                            child: Chart(_lastWeekTransaction))
                        : SizedBox(
                            height: (mediaQuery.size.height -
                                    appBar.preferredSize.height -
                                    mediaQuery.padding.top) *
                                0.75,
                            child: TransactionList(
                                _userTransactions, _deleteTransaction),
                          ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    SizedBox(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.25,
                        child: Chart(_lastWeekTransaction)),
                    SizedBox(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.75,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction),
                    ),
                  ],
                )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
