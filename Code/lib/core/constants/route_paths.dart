/// Route paths for go_router. Use these instead of raw strings.
/// (If the setup script already created route constants, merge them here.)
class RoutePaths {
  RoutePaths._();

  // Entry
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String newStudents = '/new-students';

  // Bottom tabs
  static const String home = '/';
  static const String schedule = '/schedule';
  static const String news = '/news';
  static const String styles = '/styles';
  static const String school = '/school';

  // Detail / other
  static const String settings = '/settings';
  static const String styleDetail = '/styles/:id';
  static const String newsDetail = '/news/:id';
  static const String rules = '/school/rules';
  static const String staff = '/school/staff';
  static const String masters = '/school/masters';
  static const String howToGetHere = '/school/how-to-get-here';
  static const String newStudentChecklist = '/new-students/checklist';
  static const String outsideTraining = '/school/outside-training';
}
