abstract class Routes {
  // Auth
  static const String splash = '/';
  static const String firstTime = '/first-time';
  static const String watchDemo = '/watch-demo';
  static const String signup = '/signup';
  static const String verify = '/verify';

  // Main tabs
  static const String workout = '/workout';
  static const String aiCoach = '/ai-coach';
  static const String foodLog = '/food-log';
  static const String addFood = '/add-food';

  // Workout sub-routes
  static const String workoutDay = 'day/:dayId';
  static const String exerciseDetails = 'exercise/:exerciseId';
  static const String selectExercise = 'select-exercise';

  // Program
  static const String pickProgram = '/pick-program';
  static const String programCreate = '/program-create';
  static const String programChange = '/program-change';
  static const String programDetails = '/program-details/:programId';

  // Profile
  static const String profile = '/profile';
  static const String measurements = '/measurements';
  static const String uploads = '/uploads';
  static const String integrations = '/integrations';
  static const String help = '/help';
  static const String faqs = '/faqs';
  static const String contact = '/contact';
  static const String feedback = '/feedback';
  static const String notifications = '/notifications';
  static const String referFriend = '/refer-friend';
}
