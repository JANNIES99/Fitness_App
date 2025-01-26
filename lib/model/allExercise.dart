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
        second: 30),
    Exercise.withRepetition(
        name: "Push-Ups",
        focusArea: [AreasOfTheBody.chest, AreasOfTheBody.triceps],
        instructions:
            "Start in a plank position with your hands slightly wider than shoulder-width apart, and your body in a straight line from head to heels. Lower your body until your chest almost touches the ground, keeping your elbows at a 45-degree angle. Push back up to the starting position.",
        repetition: 15),
  ]
];

Exercise abdominalCrunches = Exercise.withRepetition(
  name: "Abdominal Crunches",
  focusArea: [AreasOfTheBody.abs],
  instructions:
      "Lie on your back with your knees bent and feet flat on the floor, hip-width apart.\n Cross your arms over your chest with your palms just below your shoulders.\n Engage your core by drawing your belly button and waist towards your spine.\n Tuck your chin in slightly, as if holding a tennis ball between your chin and chest.\n Slowly tense your upper abdominals to lift your head, then neck, then shoulders and upper back off the floor as you reach forwards and up with your hands.\n Keep your lower back on the floor and avoid arching it away from the floor.\n From the top position, slowly lower your upper back, then shoulders, then neck and head back to the starting position.",
  repetition: 16,
);

Exercise jumpingJacks = Exercise.withTimer(
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
      "Stand in a straight position with your feet together, arms fully extended by your sides, and toes pointed forward.\n Jump while raising your arms overhead and simultaneously spreading your legs to the sides.\n Land on your forefeet with your legs apart and your arms overhead.\n Jump again to lower your arms and return your legs to the starting position, where your feet are together and your arms are by your sides.",
  minute: 0,
  second: 30,
);

Exercise flutterKick = Exercise.withTimer(
  name: "Flutter Kick",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.hamstrings],
  instructions:
      "Lie flat on your back.\n Keep your legs straight and lift them a little off the ground (about 6 inches).\n Kick your legs up and down in a small, controlled motion, alternating legs.\n Keep your core tight and your back flat against the floor.\n Do it for the given time.",
  minute: 0,
  second: 30,
);

Exercise cobraStretch = Exercise.withTimer(
  name: "Cobra Stretch",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.shoulders],
  instructions:
      "Lie face down on the floor, with your legs straight and the tops of your feet on the ground.\n Place your hands flat on the floor, directly under your shoulders.\n Press into your hands and slowly lift your chest up, extending your arms as much as you can without forcing it.\n Look up or slightly forward, keeping your elbows soft.\n Then gently lower back down.",
  minute: 0,
  second: 30,
);

Exercise armCircle = Exercise.withTimer(
  name: "Arm Circle",
  focusArea: [AreasOfTheBody.shoulders],
  instructions:
      "Stand up straight with your feet shoulder-width apart.\n Extend your arms straight out to the sides, parallel to the ground.\n Make small circles with your arms, moving forward or backward.\n Gradually make the circles bigger as you go, if you feel comfortable.\n Then switch directions forward to backward or vice versa.",
  minute: 0,
  second: 30,
);

Exercise jumpSquat = Exercise.withRepetition(
  name: "Jump Squat",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.hamstrings],
  instructions:
      "Stand with your feet shoulder-width apart and your toes pointing slightly outward.\n Bend your knees and lower your body into a squat position, keeping your chest up and your back straight.\n Push through your heels and jump up as high as you can, swinging your arms to help with momentum.\n Land softly with your knees slightly bent to absorb the impact, then immediately lower back into the squat position to repeat.",
  repetition: 16,
);

Exercise glutesKickback = Exercise.withRepetition(
  name: "Glutes Kickback",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.hamstrings],
  instructions:
      "Start on all fours with your hands under your shoulders and knees under your hips.\n Engage your core to keep your back straight and stable.\n Lift one leg behind you, keeping the knee bent at about 90 degrees. Push through your heel as you lift your leg toward the ceiling, focusing on squeezing your glutes.",
  repetition: 15,
);

Exercise singleLegCalfRaise = Exercise.withRepetition(
  name: "Single Leg Calf Raise",
  focusArea: [AreasOfTheBody.hamstrings],
  instructions:
      "Stand tall with your feet hip-width apart, and hold onto something for balance if needed like a wall or chair.\n Lift one foot off the ground, so you're standing on just one leg.\n Slowly raise your heel as high as you can, lifting your body up using the calf muscle.\n Lower back down slowly and repeat.",
  repetition: 15,
);

Exercise lunge = Exercise.withRepetition(
  name: "Lunge",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.hamstrings],
  instructions:
      "Stand tall with your feet hip-width apart.\n Step one foot forward about 2 feet, keeping your chest up and your core engaged. Lower your body by bending both knees. Your back knee should almost touch the floor, and your front knee should be directly above your ankle (not beyond your toes).\n Push through the heel of your front foot to stand back up and return to the starting position.\n Then switch to the other leg.",
  repetition: 12,
);

Exercise bridge = Exercise.withTimer(
  name: "bridge",
  focusArea: [AreasOfTheBody.glutes],
  instructions:
      "Lie on your back with your knees bent and feet flat on the floor, hip-width apart.\n Place your arms at your sides with your palms facing down.\n Engage your core and press through your heels to lift your hips up, forming a straight line from your shoulders to your knees.\n Squeeze your glutes at the top and hold for a second or two.\n Lower your hips back down slowly to the floor.",
  minute: 0,
  second: 30,
);
