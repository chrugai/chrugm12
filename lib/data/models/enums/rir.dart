enum RIR {
  zero(0, 'All out'),
  one(1, '1 rep left'),
  two(2, '2 reps left'),
  three(3, '3+ reps left');

  final int value;
  final String displayName;
  const RIR(this.value, this.displayName);

  String toJson() => value.toString();
  static RIR fromJson(String json) =>
      RIR.values.firstWhere((e) => e.value.toString() == json);
}
