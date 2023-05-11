import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendAmount, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: [
            SizedBox(
              height: constrains.maxHeight * .15,
              child: FittedBox(
                child: Text(
                  '\$ ${spendAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            SizedBox(
              height: constrains.maxHeight * .60,
              width: 20,
              child: Stack(children: [
                // ---------------important-----------------------------
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside),
                    color: const Color.fromRGBO(220, 220, 220, 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            SizedBox(
                height: constrains.maxHeight * .15,
                child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
