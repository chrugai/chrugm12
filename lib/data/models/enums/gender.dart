enum Gender {
  male('Male'),
  female('Female'),
  other('Other'),
  preferNotToSay('Prefer not to say');

  final String displayName;
  const Gender(this.displayName);

  String toJson() => name;
  static Gender fromJson(String json) => values.byName(json);
}
