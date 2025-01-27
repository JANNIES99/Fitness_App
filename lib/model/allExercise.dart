import 'package:fitnessapp/model/Exercise.dart';
import 'package:flutter/material.dart';

List<List<Exercise>> absEasyExercise = [
  [
    abdominalCrunches,
    jumpingJacks,
    pushUp,
    squats,
    mountainClimber,
  ]
];

Exercise abdominalCrunches = Exercise.withRepetition(
  name: "Abdominal Crunches",
  focusArea: [AreasOfTheBody.abs],
  instructions:
      "Lie on your back with your knees bent and feet flat on the floor, hip-width apart.\n Cross your arms over your chest with your palms just below your shoulders.\n Engage your core by drawing your belly button and waist towards your spine.\n Tuck your chin in slightly, as if holding a tennis ball between your chin and chest.\n Slowly tense your upper abdominals to lift your head, then neck, then shoulders and upper back off the floor as you reach forwards and up with your hands.\n Keep your lower back on the floor and avoid arching it away from the floor.\n From the top position, slowly lower your upper back, then shoulders, then neck and head back to the starting position.",
  repetition: 16,
  image: Image.asset("images/exercise/abdominal_crunches.gif"),
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
  image: Image.asset("images/exercise/jumping_jack.gif"),
);

Exercise flutterKick = Exercise.withTimer(
  name: "Flutter Kick",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.hamstrings],
  instructions:
      "Lie flat on your back.\n Keep your legs straight and lift them a little off the ground (about 6 inches).\n Kick your legs up and down in a small, controlled motion, alternating legs.\n Keep your core tight and your back flat against the floor.\n Do it for the given time.",
  minute: 0,
  second: 30,
  image: Image.asset("images/exercise/flutter_kick.gif"),
);

Exercise cobraStretch = Exercise.withTimer(
  name: "Cobra Stretch",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.shoulders],
  instructions:
      "Lie face down on the floor, with your legs straight and the tops of your feet on the ground.\n Place your hands flat on the floor, directly under your shoulders.\n Press into your hands and slowly lift your chest up, extending your arms as much as you can without forcing it.\n Look up or slightly forward, keeping your elbows soft.\n Then gently lower back down.",
  minute: 0,
  second: 30,
  image: Image.asset("images/exercise/cobra.gif"),
);

Exercise armCircle = Exercise.withTimer(
  name: "Arm Circle",
  focusArea: [AreasOfTheBody.shoulders],
  instructions:
      "Stand up straight with your feet shoulder-width apart.\n Extend your arms straight out to the sides, parallel to the ground.\n Make small circles with your arms, moving forward or backward.\n Gradually make the circles bigger as you go, if you feel comfortable.\n Then switch directions forward to backward or vice versa.",
  minute: 0,
  second: 30,
  image: Image.asset("images/exercise/arm_cirles.gif"),
);

Exercise jumpSquat = Exercise.withRepetition(
  name: "Jump Squat",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.hamstrings],
  instructions:
      "Stand with your feet shoulder-width apart and your toes pointing slightly outward.\n Bend your knees and lower your body into a squat position, keeping your chest up and your back straight.\n Push through your heels and jump up as high as you can, swinging your arms to help with momentum.\n Land softly with your knees slightly bent to absorb the impact, then immediately lower back into the squat position to repeat.",
  repetition: 16,
  image: Image.asset("images/exercise/jump_squat.gif"),
);

Exercise glutesKickback = Exercise.withRepetition(
  name: "Glutes Kickback",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.hamstrings],
  instructions:
      "Start on all fours with your hands under your shoulders and knees under your hips.\n Engage your core to keep your back straight and stable.\n Lift one leg behind you, keeping the knee bent at about 90 degrees. Push through your heel as you lift your leg toward the ceiling, focusing on squeezing your glutes.",
  repetition: 15,
  image: Image.asset("images/exercise/glute_kickback.gif"),
);

Exercise singleLegCalfRaise = Exercise.withRepetition(
  name: "Single Leg Calf Raise",
  focusArea: [AreasOfTheBody.hamstrings],
  instructions:
      "Stand tall with your feet hip-width apart, and hold onto something for balance if needed like a wall or chair.\n Lift one foot off the ground, so you're standing on just one leg.\n Slowly raise your heel as high as you can, lifting your body up using the calf muscle.\n Lower back down slowly and repeat.",
  repetition: 15,
  image: Image.asset("images/exercise/single_leg_calf_raise.gif"),
);

Exercise lunge = Exercise.withRepetition(
  name: "Lunge",
  focusArea: [AreasOfTheBody.glutes, AreasOfTheBody.hamstrings],
  instructions:
      "Stand tall with your feet hip-width apart.\n Step one foot forward about 2 feet, keeping your chest up and your core engaged. Lower your body by bending both knees. Your back knee should almost touch the floor, and your front knee should be directly above your ankle (not beyond your toes).\n Push through the heel of your front foot to stand back up and return to the starting position.\n Then switch to the other leg.",
  repetition: 12,
  image: Image.asset("images/exercise/lunge.gif"),
);

Exercise bridge = Exercise.withTimer(
  name: "Bridge",
  focusArea: [AreasOfTheBody.glutes],
  instructions:
      "Lie on your back with your knees bent and feet flat on the floor, hip-width apart.\n Place your arms at your sides with your palms facing down.\n Engage your core and press through your heels to lift your hips up, forming a straight line from your shoulders to your knees.\n Squeeze your glutes at the top and hold for a second or two.\n Lower your hips back down slowly to the floor.",
  minute: 0,
  second: 30,
  image: Image.asset("images/exercise/bridge.gif"),
);

Exercise mountainClimber = Exercise.withTimer(
  name: "Mountain Climber",
  focusArea: [
    AreasOfTheBody.abs,
    AreasOfTheBody.shoulders,
    AreasOfTheBody.triceps,
    AreasOfTheBody.adductors,
    AreasOfTheBody.glutes,
  ],
  instructions:
      "Start in a plank position with your hands shoulder-width apart, and your feet hip-width apart.\n Bring one knee towards your chest, keeping your foot flexed, then quickly switch to the other knee, mimicking the motion of running in place.\n Keep your core engaged, back straight, and body in a straight line from head to heels.",
  minute: 0,
  second: 30,
  image: Image.asset("images/exercise/mountain_climber.gif"),
);

Exercise calfRaise = Exercise.withRepetition(
  name: "Calf Raise",
  focusArea: [AreasOfTheBody.calves],
  instructions:
      "Stand on a step or platform with your heels hanging off the edge.\n Slowly raise up onto your tiptoes, then lower back down to the starting position.\n Keep your knees straight and only lift your heels.",
  repetition: 20,
  image: Image.asset("images/exercise/calf_raise.gif"),
);

Exercise reverseCrunch = Exercise.withRepetition(
  name: "Reverse Crunch",
  focusArea: [AreasOfTheBody.abs],
  instructions:
      "Lie on your back with your knees bent and feet flat on the floor.\n Lift your hips off the ground, squeezing your glutes and lower back muscles as you lift.\n Focus on lifting your hips, rather than just your lower back.\n Slowly lower your hips back down to the starting position.",
  repetition: 16,
  image: Image.asset("images/exercise/reverse_crunch.gif"),
);

Exercise squats = Exercise.withRepetition(
  name: "Squats",
  focusArea: [
    AreasOfTheBody.quadriceps,
    AreasOfTheBody.hamstrings,
    AreasOfTheBody.glutes
  ],
  instructions:
      "Stand with your feet shoulder-width apart.\n Slowly lower your body down into a seated position, keeping your back straight and your knees behind your toes.\n Pause for a moment at the bottom of the movement.\n Then, push through your heels to return to standing.",
  repetition: 16,
  image: Image.asset("images/exercise/squats.gif"),
);

Exercise sitUp = Exercise.withRepetition(
  name: "Sit Up",
  focusArea: [AreasOfTheBody.abs],
  instructions:
      "Lie on your back with your knees bent and feet flat on the floor.\n Engage your core muscles by drawing your belly button towards your spine.\n Slowly lift your shoulders off the ground, curling up towards your knees.\n Focus on lifting your shoulders, rather than just your upper body.",
  repetition: 14,
  image: Image.asset("images/exercise/sit_up.gif"),
);

Exercise legRaise = Exercise.withRepetition(
  name: "Leg Raise",
  focusArea: [AreasOfTheBody.abs, AreasOfTheBody.obliques],
  instructions:
      "Lie on your back with your arms extended overhead and legs straight.\n Lift one leg up towards the ceiling, keeping it straight.\n Focus on using your lower abs to lift your leg.\n Slowly lower your leg back down to the starting position.\n Repeat with the other leg.",
  repetition: 14,
  image: Image.asset("images/exercise/leg_raise.gif"),
);

Exercise plank = Exercise.withTimer(
  name: "Plank",
  focusArea: [AreasOfTheBody.core, AreasOfTheBody.shoulders],
  instructions:
      "Start in a push-up position with your hands shoulder-width apart.\n Instead of lowering your body down towards the ground, hold yourself up in a straight line from head to heels.\n Engage your core muscles by drawing your belly button towards your spine.\n Hold this position for as long as possible..",
  minute: 0,
  second: 30,
  image: Image.asset("images/exercise/plank.gif"),
);

Exercise pushUp = Exercise.withRepetition(
  name: "Push-up",
  focusArea: [AreasOfTheBody.chest, AreasOfTheBody.triceps],
  instructions:
      "Start in a plank position with your hands shoulder-width apart.\n Lower your body down until your chest nearly touches the ground.\n Push back up to the starting position and repeat.",
  repetition: 12,
  image: Image.asset("images/exercise/push_up.gif"),
);

Exercise superman = Exercise.withTimer(
  name: "Superman",
  focusArea: [
    AreasOfTheBody.back,
    AreasOfTheBody.shoulders,
    AreasOfTheBody.glutes,
  ],
  instructions:
      "Start in a plank position with your hands shoulder-width apart, and your feet hip-width apart.\n Lift your left arm and right leg off the ground, keeping them straight, and hold for a brief moment.\n Lower back down to the starting position and repeat on the other side, lifting your right arm and left leg.",
  minute: 0,
  second: 30,
  image: Image.asset("images/exercise/superman.gif"),
);

Exercise tricepsSideStretch = Exercise.withRepetition(
  name: "Triceps Side Stretch",
  focusArea: [AreasOfTheBody.triceps],
  instructions:
      "Hold your arm straight out to the side at shoulder height.\n Bend your elbow and bring your hand towards your shoulder.\nUse your other hand to gently pull your hand further towards your shoulder.\nHold for a few seconds, then release.\nRepeat on the other side.",
  repetition: 10,
  image: Image.asset("images/exercise/triceps_side_stretch.gif"),
);

Exercise tricepPushup = Exercise.withRepetition(
  name: "Tricep Push-up",
  focusArea: [AreasOfTheBody.triceps, AreasOfTheBody.chest],
  instructions:
      "Start in a plank position with your hands shoulder-width apart.\n Lower your body down until your arms are bent at a 90-degree angle, keeping your upper arms still and only moving your forearms to lower the rest of your body towards the ground. Then push back up to the starting position and repeat.",
  repetition: 10,
  image: Image.asset("images/exercise/tricep_push_up.gif"),
);
