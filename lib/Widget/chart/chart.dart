import 'package:fitnessapp/Widget/chart/chartBar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({required this.burnedCalories, super.key});
  final List<double> burnedCalories;

  double get maxBurnedCalorie {
    double amount = 0;
    for (final i in burnedCalories) {
      if (i > amount) {
        amount = i;
      }
    }
    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 250,
      child: Card(
        color: Theme.of(context).cardColor,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bar_chart_rounded,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Calories Burned Graph",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (maxBurnedCalorie > 0)
                      for (final i in burnedCalories)
                        ChartBar(fill: i / maxBurnedCalorie),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final i in burnedCalories)
                    Text(
                      i.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
