import 'package:fitnessapp/Widget/Exercise_Timer.dart';
import 'package:fitnessapp/model/yoga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Yogaview extends StatefulWidget {
  const Yogaview({required this.yoga, super.key});
  final Yoga yoga;

  @override
  State<Yogaview> createState() => _YogaviewState();
}

class _YogaviewState extends State<Yogaview> {
  final FlutterTts _flutterTts = FlutterTts();
  @override
  void initState() {
    _flutterTts.setVoice({"name": "es-us-x-sfb-local", "locale": "es-US"});
    _flutterTts.speak(widget.yoga.instructions);
    super.initState();
  }

  void stopTTS() {
    _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                stopTTS();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text(
              widget.yoga.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              widget.yoga.image,
              const SizedBox(height: 20),
              Text(
                widget.yoga.instructions,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              ExerciseTimer(minute: 0, seconds: widget.yoga.second),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
