enum AreasOfTheBody {
  abs,
  adductors,
  shoulders,
  quadriceps,
  glutes,
  calves,
  chest,
  triceps,
  back,
  hamstrings,
  biceps,
}

class Exercise {
  Exercise({
    required this.name,
    required this.focusArea,
    required this.instructions,
    required this.isTimer,
    required this.timer,
    required this.isRepetition,
    required this.repetition,
  });

  final String name;
  final List<AreasOfTheBody> focusArea;
  final String instructions;
  final int? timer;
  final bool isTimer;
  final bool isRepetition;
  final int? repetition;

  Exercise.withRepetition({
    required this.name,
    required this.focusArea,
    required this.instructions,
    required this.repetition,
  })  : isRepetition = true,
        isTimer = false,
        timer = null;
}
