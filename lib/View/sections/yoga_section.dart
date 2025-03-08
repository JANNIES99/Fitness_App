import 'package:fitnessapp/View/YogaView.dart';
import 'package:fitnessapp/Widget/Yoga_Item.dart';
import 'package:fitnessapp/model/allYoga.dart';
import 'package:flutter/material.dart';

class YogaSection extends StatelessWidget {
  const YogaSection({super.key});

  @override
  Widget build(BuildContext context) {
    int len = allYoga.length;
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: ListView.builder(
          itemCount: len,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Yogaview(yoga: allYoga[index])));
                  },
                  child: YogaItem(yoga: allYoga[index]),
                ),
              ],
            );
          }),
    );
  }
}
