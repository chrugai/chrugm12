class FaqEntry {
  final String question;
  final String answer;
  const FaqEntry({required this.question, required this.answer});
}

List<FaqEntry> getFaqs() => const [
  FaqEntry(question: 'Can I edit my profile details later?', answer: 'Yes! Go to your Profile from the sidebar and tap any field to edit it. Changes are saved automatically.'),
  FaqEntry(question: "What if I can't find an exercise in the list?", answer: 'Use the search bar on the Select Exercise screen to filter by name. If the exercise still doesn\'t appear, you can create a custom exercise from the same screen.'),
  FaqEntry(question: 'How do I log my workouts?', answer: 'Navigate to your workout day, tap an exercise, then use the Add Set button to log your reps, weight, and other details. Sets are saved automatically.'),
  FaqEntry(question: 'How does Pick a Program work?', answer: 'Pick a Program lets you browse pre-made training programs. Tap one to preview its structure, then select it to make it your active program.'),
  FaqEntry(question: 'How does Create New Program work?', answer: 'Tap Create New Program, give it a name, then add days and assign exercises to each day. You can reorder exercises by dragging them.'),
  FaqEntry(question: 'Can I adjust rest times?', answer: 'Yes. On the Exercise Details screen, tap the rest timer pill to change your rest period. The default is 3 minutes.'),
  FaqEntry(question: 'Can I edit a program after creating it?', answer: 'Absolutely. Go to your program, tap a day to view exercises, and you can add, remove, or reorder exercises at any time.'),
];
