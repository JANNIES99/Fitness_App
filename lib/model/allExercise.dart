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
    Exercise.withTimer(
        name: "High Knees",
        focusArea: [AreasOfTheBody.quadriceps, AreasOfTheBody.calves],
        instructions:
            "Stand tall with your feet hip-width apart. Run in place, bringing your knees as high as possible towards your chest. Keep your core engaged and arms bent at a 90-degree angle as you alternate lifting your knees.",
        minute: 0,
        second: 30),
    Exercise.withRepetition(
        name: "Squats",
        focusArea: [AreasOfTheBody.quadriceps, AreasOfTheBody.glutes],
        instructions:
            "Stand with your feet shoulder-width apart and your toes pointing forward. Lower your body as if you are sitting back into a chair, keeping your knees behind your toes. Go as low as possible while keeping your chest up. Push through your heels to return to standing.",
        repetition: 20),
    Exercise.withTimer(
        name: "Mountain Climbers",
        focusArea: [
          AreasOfTheBody.shoulders,
          AreasOfTheBody.quadriceps,
          AreasOfTheBody.abs
        ],
        instructions:
            "Start in a push-up position, keeping your hands directly under your shoulders. Quickly alternate bringing your knees to your chest, as if you're running in place while maintaining a plank position.",
        minute: 0,
        second: 30),
    Exercise.withRepetition(
        name: "Lunges",
        focusArea: [AreasOfTheBody.quadriceps, AreasOfTheBody.glutes],
        instructions:
            "Step forward with one leg, lowering your hips until both knees are bent at a 90-degree angle. The back knee should nearly touch the floor, and the front knee should not extend past your toes. Push through the front heel to return to standing, then repeat on the other leg.",
        repetition: 15),
    Exercise.withTimer(
        name: "Plank",
        focusArea: [AreasOfTheBody.abs],
        instructions:
            "Get into a push-up position, but with your forearms on the floor instead of your hands. Keep your body in a straight line from head to heels, engaging your core and holding for the designated time.",
        minute: 0,
        second: 30),
    Exercise.withRepetition(
        name: "Tricep Dips",
        focusArea: [AreasOfTheBody.triceps],
        instructions:
            "Place your hands on a bench or chair behind you, with your fingers facing forward and your legs extended in front. Lower your body by bending your elbows to a 90-degree angle, then push back up to the starting position.",
        repetition: 12),
    Exercise.withTimer(
        name: "Jump Rope",
        focusArea: [
          AreasOfTheBody.shoulders,
          AreasOfTheBody.calves,
          AreasOfTheBody.quadriceps
        ],
        instructions:
            "Jump over the rope as it swings beneath you, keeping your jumps smooth and controlled. You can alternate between two-feet jumps and single-leg jumps for variation.",
        minute: 0,
        second: 30),
    Exercise.withRepetition(
        name: "Leg Raises",
        focusArea: [AreasOfTheBody.abs],
        instructions:
            "Lie flat on your back with your legs extended and your arms by your sides. Lift both legs towards the ceiling while keeping them straight, then lower them slowly without letting them touch the floor.",
        repetition: 15),
    Exercise.withTimer(
        name: "Burpees",
        focusArea: [
          AreasOfTheBody.shoulders,
          AreasOfTheBody.quadriceps,
          AreasOfTheBody.chest
        ],
        instructions:
            "Start standing, then squat down and place your hands on the floor. Jump your feet back into a plank position, perform a push-up, then jump your feet back towards your hands and jump upwards.",
        minute: 0,
        second: 30),
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
    Exercise.withTimer(
        name: "High Knees",
        focusArea: [AreasOfTheBody.quadriceps, AreasOfTheBody.calves],
        instructions:
            "Stand tall with your feet hip-width apart. Run in place, bringing your knees as high as possible towards your chest. Keep your core engaged and arms bent at a 90-degree angle as you alternate lifting your knees.",
        minute: 0,
        second: 30)
  ]
];
