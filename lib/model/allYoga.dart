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
          "\nStart by sitting on the floor with your knees bent and your feet flat on the ground. \nLean back slightly and engage your core muscles. \nLift your feet off the floor, bringing your shins parallel to the ground, with your knees bent at a 90-degree angle. \nExtend your arms straight forward at shoulder height, palms facing each other. \nKeep your back straight, avoiding rounding your spine, and engage your core to maintain balance. \nHold the position while breathing deeply, keeping your gaze forward.",
      second: 30),
  Yoga(
      name: "Ardha Navasana",
      image: Image.asset("images/Yoga/Ardha-Navasana.jpeg"),
      instructions:
          "\nStart by sitting on the floor with your knees bent and your feet flat on the ground. \nLean back slightly and engage your core muscles. \nLift your feet off the floor, bringing your shins parallel to the ground, with your knees bent at a 90-degree angle. \nExtend your arms straight forward at shoulder height, palms facing each other. \nKeep your back straight, avoiding rounding your spine, and engage your core to maintain balance. \nHold the position while breathing deeply, keeping your gaze forward.",
      second: 30),
];
