import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar({this.label, this.spendingAmount, this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * .05),
            Container(
              height: constraints.maxHeight * .6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(
                        color: Color.fromARGB(220, 220, 220, 1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * .05,
            ),
            Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
