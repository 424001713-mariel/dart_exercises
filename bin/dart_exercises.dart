void main() {
  // Explicit variable declarations (String, int, double, bool)
  String studentName = 'Mariel Bernardino';
  int completedModules = 8;
  double moduleScoreAverage = 92.5;
  bool hasSubmittedAllTasks = true;

  // Arithmetic operations (+, *, ~/, %)
  double totalScorePoints = completedModules * moduleScoreAverage;
  int completedWeeks = completedModules ~/ 2; // Integer division for extra credit
  int remainingModules = completedModules % 3; // Modulo operator for extra credit

  // Comparison operations (>=, ==)
  bool isEligibleForHonors = totalScorePoints >= 700.0;
  bool isPerfectSubmission = hasSubmittedAllTasks && (completedModules == 8);

  // Output using string interpolation
  print('========================================');
  print('   STUDENT ACADEMIC PERFORMANCE REPORT  ');
  print('========================================');
  print('Student Name: $studentName');
  print('Completed Modules: $completedModules');
  print('Average Module Score: $moduleScoreAverage%');
  print('Has Submitted All Tasks: $hasSubmittedAllTasks');
  print('----------------------------------------');
  print('Total Points Earned: $totalScorePoints');
  print('Completed Weeks (2 modules/wk): $completedWeeks');
  print('Remaining Modules (Mod 3): $remainingModules');
  print('----------------------------------------');
  print('Eligible for Honors (>= 700 pts)? $isEligibleForHonors');
  print('Perfect Submission Status? $isPerfectSubmission');
  print('========================================');
}
