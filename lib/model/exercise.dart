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
  });
  final String name;
  final List<AreasOfTheBody> focusArea;
  final String instructions;
}
