import 'package:fitnessapp/model/Exercise.dart';

List<List<Exercise>> absEasyExercise = [
  [
    Exercise.withRepetition(
        name: "Abdominal Crunches",
        focusArea: [AreasOfTheBody.abs],
        instructions:
            "Lie on your back with your knees bent and feet flat on the floor, hip-width apart. Cross your arms over your chest with your palms just below your shoulders. Engage your core by drawing your belly button and waist towards your spine. Tuck your chin in slightly, as if holding a tennis ball between your chin and chest.\n Slowly tense your upper abdominals to lift your head, then neck, then shoulders and upper back off the floor as you reach forwards and up with your hands. Keep your lower back on the floor and avoid arching it away from the floor. From the top position, slowly lower your upper back, then shoulders, then neck and head back to the starting position.",
        repetition: 16),
    Exercise.withTimer(
        name: "Jumping Jacks",
        focusArea: [
          AreasOfTheBody.shoulders,
          AreasOfTheBody.quadriceps,
          AreasOfTheBody.adductors,
          AreasOfTheBody.glutes,
          AreasOfTheBody.calves,
          AreasOfTheBody.chest
        ],
        instructions:
            "Stand in a straight position with your feet together, arms fully extended by your sides, and toes pointed forward. Jump while raising your arms overhead and simultaneously spreading your legs to the sides. Land on your forefeet with your legs apart and your arms overhead. Jump again to lower your arms and return your legs to the starting position, where your feet are together and your arms are by your sides.",
        minute: 0,
        second: 30)
  ]
];
