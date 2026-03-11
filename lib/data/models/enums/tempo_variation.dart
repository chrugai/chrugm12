enum TempoVariation {
  normal('Normal'),
  slowEccentric('Slow Eccentric'),
  paused('Paused');

  final String displayName;
  const TempoVariation(this.displayName);

  String toJson() => name;
  static TempoVariation fromJson(String json) => values.byName(json);
}
