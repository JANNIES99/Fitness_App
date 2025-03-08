import 'package:fitnessapp/model/yoga.dart';
import 'package:flutter/material.dart';

List<Yoga> allYoga = [
  Yoga(
      name: "Adho Mukha Svanasana",
      image: Image.asset("images/Yoga/Adho-Mukha-Svanasana.jpg"),
      instructions:
          "Lift your hips toward the ceiling, forming an upside-down V. \nStraighten your legs, keeping a slight bend if necessary. \nRelax your neck and let your head hang naturally. \nEngage your core muscles to support your spine. \nBreathe deeply, inhaling as you lengthen your spine and exhaling to deepen the stretch. \nHold the pose for the given time then bend your knees and return to tabletop.\nDepending on your experience and comfort level, you can hold it longer—up to 1 minute or more",
      second: 30),
  Yoga(
      name: "Goddess",
      image: Image.asset("images/Yoga/goddess.jpg"),
      instructions:
          "Start by standing with your feet wide apart, about 3–4 feet. \nTurn your toes out at a 45-degree angle. \nBend your knees deeply, keeping them in line with your toes. \nLower your hips so your thighs are parallel to the floor (or as low as you can comfortably go). \nKeep your chest lifted, shoulders relaxed, and arms bent at 90 degrees. \nReach your arms out parallel to the floor with palms facing forward. \nPress your feet into the mat, engaging your core and inner thighs.",
      second: 60),
  Yoga(
      name: "Plank",
      image: Image.asset("images/Yoga/plank.jpg"),
      instructions:
          "Start in a tabletop position with your wrists directly under your shoulders and knees under your hips. \nStep your feet back, one at a time, until your body forms a straight line from head to heels. \nEngage your core, keeping your body in a straight line (avoid letting your hips sag or rise). \nKeep your hands pressed firmly into the mat, fingers spread wide. \nEnsure your shoulders are directly over your wrists. \nLook slightly forward, keeping your neck neutral. \nHold the pose with steady breathing, keeping your body stable and engaged.",
      second: 30),
  Yoga(
      name: "Tree",
      image: Image.asset("images/Yoga/tree.jpg"),
      instructions:
          "Start by standing tall with your feet hip-width apart. \n Shift your weight onto one foot (e.g., left foot). \nBend the opposite knee and place the sole of that foot on the inner thigh, calf, or ankle of the standing leg (avoid the knee). \nPress your foot into the leg and your leg into the foot for stability. \nBring your hands to a prayer position at your chest, or extend them overhead with palms facing each other. \nKeep your hips squared forward and your gaze focused on a fixed point to help with balance. \nEngage your core and hold the position.",
      second: 30),
  Yoga(
      name: "Warrior2",
      image: Image.asset("images/Yoga/warrior2.jpg"),
      instructions:
          "Start by standing tall with your feet hip-width apart. \n Shift your weight onto one foot (e.g., left foot). \nBend the opposite knee and place the sole of that foot on the inner thigh, calf, or ankle of the standing leg (avoid the knee). \nPress your foot into the leg and your leg into the foot for stability. \nBring your hands to a prayer position at your chest, or extend them overhead with palms facing each other. \nKeep your hips squared forward and your gaze focused on a fixed point to help with balance. \nEngage your core and hold the position.",
      second: 30),
  Yoga(
      name: "Adho Mukha Vrksasana",
      image: Image.asset("images/Yoga/Adho-Mukha-Vrksasana.png"),
      instructions:
          "Start in a Downward Dog position with your feet hip-width apart and your hands shoulder-width apart. \nEngage your core and kick one leg up towards the ceiling, keeping the other leg grounded. \nUse your core and shoulders to support your weight as you shift your hips over your shoulders. \nAs you kick up, try to find balance by lifting both feet off the ground, coming into a handstand. \nOnce in the handstand, keep your body in a straight line from head to toes. \nPress firmly into the ground with your hands and engage your core to maintain balance. \nLook slightly between your hands to keep your neck neutral.",
      second: 10),
  Yoga(
      name: "Anjaneyasana",
      image: Image.asset("images/Yoga/Anjaneyasana.png"),
      instructions:
          "Start in a standing position (Tadasana), then step one foot back about 3–4 feet. \nBend your front knee to 90 degrees, ensuring the knee is directly over the ankle. \nKeep your back leg straight and your back heel lifted off the floor. \nEngage your core to stabilize your body. \nReach your arms overhead with your palms facing each other or bring your hands to a prayer position at your chest. \nKeep your chest lifted and your gaze forward. \nPress your feet into the mat for stability, with the back leg strong and straight.",
      second: 30),
  Yoga(
      name: "Ardha Chandrasana",
      image: Image.asset("images/Yoga/Ardha-Chandrasana.png"),
      instructions:
          "Start in Triangle Pose (Trikonasana) with your feet wide apart. \nBend your front knee, reaching your front hand to the floor or a block (just inside your front foot). \nShift your weight onto your front leg and lift your back leg parallel to the floor, keeping it straight. \nStack your hips and shoulders, opening your chest toward the ceiling. \nExtend your top arm straight up, with the palm facing forward. \nEngage your core and focus on a steady point to help with balance.",
      second: 30),
  Yoga(
      name: "Ardha Matsyendrasana",
      image: Image.asset("images/Yoga/Ardha-Matsyendrasana.png"),
      instructions:
          "Start by sitting on the floor with your legs extended straight in front of you. \nBend your right knee and place your right foot flat on the floor, crossing it over your left leg. \nBring your left leg's foot toward your right hip, keeping your left knee on the floor. \nInhale, lengthen your spine, and sit up tall. \nExhale and twist your torso to the right, placing your left elbow on the outside of your right knee. \nBring your right hand to the floor behind you, fingers pointing away from your body. \nKeep your spine long and your chest open, deepening the twist with each exhale. \nGaze over your right shoulder or keep your neck relaxed in a neutral position.",
      second: 30),
  Yoga(
      name: "Ardha Navasana",
      image: Image.asset("images/Yoga/Ardha-Navasana.jpeg"),
      instructions:
          "Start by sitting on the floor with your knees bent and your feet flat on the ground. \nLean back slightly and engage your core muscles. \nLift your feet off the floor, bringing your shins parallel to the ground, with your knees bent at a 90-degree angle. \nExtend your arms straight forward at shoulder height, palms facing each other. \nKeep your back straight, avoiding rounding your spine, and engage your core to maintain balance. \nHold the position while breathing deeply, keeping your gaze forward.",
      second: 30),
  Yoga(
      name: "Baddha Konasana",
      image: Image.asset("images/Yoga/Baddha-Konasana.png"),
      instructions:
          "Sit on the floor with your legs extended straight in front of you. \nBend your knees and bring the soles of your feet together, allowing your knees to fall open to the sides. \nHold your feet with your hands, keeping your spine straight and your chest open. \nGently press your knees down toward the floor while maintaining the stretch. \nBreathe deeply and hold the pose for 30 seconds to a few minutes.",
      second: 60),
  Yoga(
      name: "Bakasana",
      image: Image.asset("images/Yoga/Bakasana.png"),
      instructions:
          "Start in a squat position with your feet hip-width apart and your knees bent. \nPlace your hands on the floor in front of you, shoulder-width apart, with your fingers spread wide. \nShift your weight forward, lifting your hips and bending your elbows slightly. \nBring your knees toward your upper arms, keeping your gaze forward. \nEngage your core and slowly begin to lift your feet off the ground, balancing on your hands. \nHold the pose for a few breaths, then gently lower your feet back to the floor.",
      second: 15),
  Yoga(
      name: "Balasana",
      image: Image.asset("images/Yoga/Balasana.png"),
      instructions:
          "Begin in a kneeling position with your big toes touching and knees spread apart. \nSit back onto your heels, lowering your torso toward the floor. \nExtend your arms in front of you, placing your forehead on the mat. \nRelax your neck, face, and shoulders, allowing your body to release tension. \nBreathe deeply and hold the position",
      second: 180),
  Yoga(
      name: "Bitilasana",
      image: Image.asset("images/Yoga/Bitilasana.png"),
      instructions:
          "Start on your hands and knees in a tabletop position, with your wrists directly under your shoulders and knees under your hips. \nInhale as you arch your back, dropping your belly towards the floor, and lifting your chest and tailbone toward the sky. \nKeep your shoulders relaxed and away from your ears. \nGaze gently upward, without straining your neck. \nHold the pose for a few breaths, then exhale as you move into Marjaryasana (Cat Pose).",
      second: 30),
  Yoga(
      name: "Camatkarasana",
      image: Image.asset("images/Yoga/Camatkarasana.png"),
      instructions:
          "Start in a tabletop position with your wrists directly under your shoulders and knees under your hips. \nOn an inhale, reach your right arm forward and your left leg back, keeping your body in a straight line. \nAs you exhale, bend your right elbow and left knee, bringing them toward each other while lifting your left leg and opening your chest to the left side. \nExtend your right arm up and over your head, reaching for the back leg. \nGently arch your back and open your chest, looking toward your lifted hand. \nHold the pose for 3-5 breaths, then slowly release and repeat on the other side.",
      second: 30),
  Yoga(
      name: "Dhanurasana",
      image: Image.asset("images/Yoga/Dhanurasana.png"),
      instructions:
          "Start by lying flat on your stomach with your arms by your sides and your legs extended. \nBend your knees and bring your heels toward your glutes, reaching back with your hands to grasp your ankles. \nInhale as you lift your chest, head, and thighs off the floor, pressing your feet into your hands. \nKeep your gaze forward or slightly up, and open your chest while drawing your shoulder blades toward each other. \nHold the pose with breathing deeply and evenly. \nTo release, gently lower your chest, head, and legs back to the floor.",
      second: 30),
  Yoga(
      name: "Eka Pada Rajakapotasana",
      image: Image.asset("images/Yoga/Eka-Pada-Rajakapotasana.png"),
      instructions:
          "Start in a tabletop position and bring your right knee forward, placing it behind your right wrist. \nExtend your left leg straight behind you, keeping your hips square to the floor. \nInhale and lengthen your spine, then exhale as you fold forward, lowering your chest toward the floor. \nReach your arms forward or place them beside your body for support. \nFor a deeper stretch, you can bend your left leg and reach back with your hand to grasp the left foot. \nHold the pose with breathing deeply and relaxing into the stretch. \nTo release, slowly come back up and repeat on the other side.",
      second: 60),
  Yoga(
      name: "Halasana",
      image: Image.asset("images/Yoga/Halasana.png"),
      instructions:
          "Begin by lying flat on your back with your arms by your sides and your legs extended. \nInhale and lift your legs overhead, bringing them toward the floor behind you while keeping them straight. \nPress your arms into the floor for support, and keep your feet active, reaching toward the ground. \nEngage your core to help stabilize your spine and avoid strain in the neck. \nKeep your neck long, avoiding compression, and gaze toward the ceiling or close your eyes for a deeper relaxation. \nHold the pose with breathing deeply. \nTo release, slowly roll your spine back down and return to the starting position.",
      second: 30),
  Yoga(
      name: "Hanumanasana",
      image: Image.asset("images/Yoga/Hanumanasana.png"),
      instructions:
          "Begin by lying flat on your back with your arms by your sides and your legs extended. \nInhale and lift your legs overhead, bringing them toward the floor behind you while keeping them straight. \nPress your arms into the floor for support, and keep your feet active, reaching toward the ground. \nEngage your core to help stabilize your spine and avoid strain in the neck. \nKeep your neck long, avoiding compression, and gaze toward the ceiling or close your eyes for a deeper relaxation. \nHold the pose with breathing deeply. \nTo release, slowly roll your spine back down and return to the starting position.",
      second: 30),
  Yoga(
      name: "Hanumanasana",
      image: Image.asset("images/Yoga/Hanumanasana.png"),
      instructions:
          "Begin by lying flat on your back with your arms by your sides and your legs extended. \nInhale and lift your legs overhead, bringing them toward the floor behind you while keeping them straight. \nPress your arms into the floor for support, and keep your feet active, reaching toward the ground. \nEngage your core to help stabilize your spine and avoid strain in the neck. \nKeep your neck long, avoiding compression, and gaze toward the ceiling or close your eyes for a deeper relaxation. \nHold the pose with breathing deeply. \nTo release, slowly roll your spine back down and return to the starting position.",
      second: 30),
  Yoga(
      name: "Malasana",
      image: Image.asset("images/Yoga/Malasana.png"),
      instructions:
          "Begin by standing with your feet slightly wider than hip-width apart. \nTurn your toes out and bend your knees deeply, bringing your hips down toward the floor. \nKeep your chest lifted and your spine long. \nBring your palms together in a prayer position in front of your chest. \nPress your elbows against the inside of your knees to open your hips further. \nKeep your weight evenly distributed on your feet, pressing your heels down. \nHold the position, breathing deeply and maintaining the stretch in your hips and groin. \nTo release, slowly straighten your legs and return to a standing position.",
      second: 60),
  Yoga(
      name: "Navasana",
      image: Image.asset("images/Yoga/Navasana.jpeg"),
      instructions:
          "Start by sitting on the floor with your legs extended in front of you. \nBend your knees and place your feet flat on the floor, keeping them hip-width apart. \nLean back slightly, engaging your core, and lift your feet off the floor. \nStraighten your legs so that your body forms a V shape. \nKeep your spine straight and your chest open, avoiding rounding your back. \nExtend your arms parallel to the floor, palms facing each other. \nHold the pose, keeping your core engaged and breathing deeply. \nTo release, slowly lower your legs and come back to a seated position.",
      second: 30),
  Yoga(
      name: "Padmasana",
      image: Image.asset("images/Yoga/Padmasana.png"),
      instructions:
          "Sit on the floor with your legs extended straight in front of you. \nBend your right knee and bring your right foot towards your left thigh, placing it on your left hip crease. \nBend your left knee and bring your left foot on top of your right thigh, placing it near your right hip crease. \nKeep your spine straight and shoulders relaxed. \nRest your hands on your knees with your palms facing upward or in a mudra of your choice. \nClose your eyes and focus on your breath, maintaining a calm and steady posture. \nHold the position, ensuring your body stays aligned and balanced. \nTo release, gently unwind your legs and come back to a seated position.",
      second: 300),
  Yoga(
      name: "Salamba Bhujangasana",
      image: Image.asset("images/Yoga/Salamba-Bhujangasana.png"),
      instructions:
          "Begin by lying on your stomach with your legs extended straight behind you and the tops of your feet pressing into the floor. \nPlace your elbows directly beneath your shoulders, and keep your forearms parallel to each other on the ground. \nPress your palms gently into the floor, engaging your forearms and upper arms to lift your chest. \nKeep your elbows slightly bent and draw your shoulder blades down your back, opening the chest. \nLift your chest upward, keeping your lower body grounded on the mat. \nEngage your core and thighs, avoiding any arching in the lower back. \nHold the position, breathing deeply and relaxing your neck and face. \nTo release, slowly lower your chest back down to the mat.",
      second: 60),
  Yoga(
      name: "Supta Kapotasana",
      image: Image.asset("images/Yoga/Supta-Kapotasana.jpeg"),
      instructions:
          "Begin by lying flat on your back with your legs extended and arms by your sides. \nBend your right knee and bring it toward your chest. \nCross your right ankle over your left thigh, just above the knee, to form a figure-four shape with your legs. \nThread your right hand through the space created by your right leg and interlace your fingers behind your left thigh or shin. \nGently draw your left leg toward your chest while keeping your head and shoulders relaxed on the floor. \nKeep your left foot flexed to protect your knee and avoid straining. \nHold the position, breathing deeply and relaxing into the stretch. \nTo release, gently lower your left leg and uncross your right ankle. Repeat on the other side.",
      second: 60),
  Yoga(
      name: "Urdhva Mukha Svsnssana",
      image: Image.asset("images/Yoga/Urdhva-Mukha-Svsnssana.png"),
      instructions:
          "Start by lying on your stomach with your legs extended behind you and the tops of your feet pressing into the floor. \nPlace your hands on the mat, palms down, directly beneath your shoulders with your fingers spread wide. \nPress into your hands and begin to straighten your arms, lifting your chest and upper body off the ground. \nRoll your shoulders back and down, away from your ears, opening your chest. \nEngage your legs, lifting your thighs off the floor and pressing the tops of your feet into the mat. \nKeep your arms straight and gaze slightly forward or upward, ensuring your neck stays long and relaxed. \nLift your hips slightly, but avoid arching the lower back excessively. \nHold the position, breathing deeply and keeping your core engaged.",
      second: 30),
  Yoga(
      name: "Ustrasana",
      image: Image.asset("images/Yoga/Ustrasana.png"),
      instructions:
          "Begin by kneeling on the mat with your knees hip-width apart and your thighs perpendicular to the floor. \nPlace your hands on your hips, with your fingers pointing downward. \nInhale and gently lift your chest, lengthening your spine. \nExhale and slowly begin to lean back, reaching your hands one at a time to your heels. \nPress your hips forward as you arch your back, keeping your chest open and your head neutral or gently allowing your head to drop back. \nKeep your thighs engaged and avoid letting your lower back collapse. \nHold the position, breathing deeply and maintaining length in your spine. \nTo release, slowly bring your hands back to your hips, engage your core, and lift your chest back up to a neutral position.",
      second: 30),
  Yoga(
      name: "Utthita Hasta Padangusthasana",
      image: Image.asset("images/Yoga/Utthita-Hasta-Padangusthasana.png"),
      instructions:
          "Begin by standing tall in Mountain Pose with your feet together and arms by your sides. \nShift your weight onto your left leg and engage your core for balance. \nSlowly lift your right leg, keeping it straight, and hold your right big toe with your right hand. \nExtend your left arm out to the side for balance or place it on your waist. \nKeep your right leg straight and your torso upright as you open your right leg to the side. \nKeep your chest open, shoulders relaxed, and gaze forward or toward your raised foot. \nHold the position, breathing deeply, and engage your core to maintain stability. \nTo release, slowly lower your right leg back down to the ground and return to standing.",
      second: 30),
  Yoga(
      name: "Utthita Parsvakonasana",
      image: Image.asset("images/Yoga/Utthita-Parsvakonasana.png"),
      instructions:
          "Start in a standing position with your feet about 3-4 feet apart. \nTurn your right foot out 90 degrees and your left foot slightly inward. \nBend your right knee, making sure it is directly above your right ankle. \nExtend your arms out to the sides, parallel to the floor, with your palms facing down. \nExhale and reach your right hand forward, then lower it to the floor or a block beside your right foot. \nExtend your left arm straight up toward the ceiling, keeping both arms in one straight line. \nOpen your chest and rotate your torso slightly upward, gazing up at your left hand. \nEngage your legs and core, ensuring your left leg is strong and straight, and your hips remain open. \nHold the pose, breathing deeply and maintaining balance and stability. \nTo release, press into your feet and come back to standing, then repeat on the other side.",
      second: 60),
];
