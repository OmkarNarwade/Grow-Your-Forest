class Tree {
  final int species;
  int currentStage;
  final int maxStages;

  Tree({required this.species, this.currentStage = 1})
      : maxStages = _speciesStages[species]!;

  bool get isFullyGrown => currentStage >= maxStages;

  void grow() {
    if (!isFullyGrown) currentStage++;
  }

  static final Map<int, int> _speciesStages = {
    1: 2, // Species 1 has 2 stages
    2: 3, // Species 2 has 3 stages
    3: 4, // Species 3 has 4 stages
  };
}
