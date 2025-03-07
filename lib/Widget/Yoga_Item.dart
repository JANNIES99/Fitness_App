import 'package:fitnessapp/model/yoga.dart';
import 'package:flutter/material.dart';

class YogaItem extends StatelessWidget {
  const YogaItem({required this.yoga, super.key});
  final Yoga yoga;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(image: yoga.image.image, fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              color: Colors.white54,
              child: Text(
                yoga.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
