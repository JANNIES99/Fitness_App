import 'package:fitnessapp/Widget/Exercise_Details.dart';
import 'package:fitnessapp/Widget/Exercise_Timer.dart';
import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DoingExercise extends StatefulWidget {
  const DoingExercise(
      {required this.switchPrevious,
      required this.switchView,
      required this.exercise,
      required this.goBack,
      required this.buff,
      super.key});
  final void Function() switchPrevious;
  final void Function() switchView;
  final void Function() goBack;
  final double buff;
  final Exercise exercise;

  @override
  State<DoingExercise> createState() => _DoingExerciseState();
}

class _DoingExerciseState extends State<DoingExercise> {
  final FlutterTts _flutterTts = FlutterTts();
  @override
  void initState() {
    print("hello");
    _flutterTts.setVoice({"name": "es-us-x-sfb-local", "locale": "es-US"});
    _flutterTts.speak(widget.exercise.instructions);
    super.initState();
  }

  void stopTTS() {
    _flutterTts.stop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                stopTTS();
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Quit"),
                          content: const Text("Are you sure"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                widget.goBack();
                              },
                              child: const Text("Quit"),
                            )
                          ],
                        ));
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text(
              widget.exercise.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            widget.exercise.image,
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.exercise.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (BuildContext ctx) {
                          return ExerciseDetails(exercise: widget.exercise);
                        },
                      );
                    },
                    icon: const Icon(Icons.question_mark)),
              ],
            ),
            if (widget.exercise.isRepetition)
              Text(
                  "x${widget.exercise.repetition! + (widget.exercise.repetition! * widget.buff).round()}"),
            if (widget.exercise.isTimer)
              ExerciseTimer(
                minute: widget.exercise.minute as int,
                seconds: widget.exercise.second! +
                    (widget.exercise.second! * widget.buff).round(),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      stopTTS();
                      widget.switchPrevious();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.skip_previous_outlined),
                        Text("Previous"),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      stopTTS();
                      widget.switchView();
                    },
                    child: const Row(
                      children: [
                        Text("Skip"),
                        Icon(Icons.skip_next_outlined),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
