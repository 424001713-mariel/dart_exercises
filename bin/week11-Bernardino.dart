import 'dart:async';

// 1. ABSTRACT CLASS (From Week 10)
abstract class Completable {
  void markAsDone();
}

// 2. MIXIN (From Week 10)
mixin Downloadable {
  void download(String itemName) {
    print('⬇️ Downloading "$itemName" for offline use...');
  }
}

// Class OUTSIDE the main hierarchy using the Mixin
class StudyGuide with Downloadable {
  String topic;
  StudyGuide(this.topic);
}

// 3. BASE CLASS (From Week 9–10, now with an ASYNC method for Week 11)
class CourseraCourse implements Completable {
  String title;
  String instructor;
  bool _isCompleted = false;

  CourseraCourse(this.title, this.instructor);

  bool get isCompleted => _isCompleted;

  @override
  void markAsDone() {
    _isCompleted = true;
    print('✅ Completed Course: $title');
  }

  void showInfo() {
    print('📘 Course: $title by $instructor | Done: $_isCompleted');
  }

  // NEW WEEK 11 ASYNC METHOD: Simulates saving course progress to a cloud server
  Future<String> syncProgressToCloud() async {
    await Future.delayed(Duration(seconds: 2)); // 2-second realistic delay
    return '☁️ Server Sync Complete: "$title" (Completed: $_isCompleted) saved to Coursera Cloud.';
  }
}

// 4. DERIVED CLASS 1 (From Week 10)
class VideoLesson extends CourseraCourse with Downloadable {
  int durationMinutes;

  VideoLesson(super.title, super.instructor, this.durationMinutes);

  @override
  void showInfo() {
    print('🎥 Video Lesson: $title ($durationMinutes mins) | Done: $isCompleted');
  }
}

// 5. DERIVED CLASS 2 (From Week 10)
class QuizAssessment extends CourseraCourse {
  int passingScore;

  QuizAssessment(super.title, super.instructor, this.passingScore);

  @override
  void showInfo() {
    print('📝 Quiz: $title (Passing: $passingScore%) | Done: $isCompleted');
  }
}

// MAIN FUNCTION MARKED AS ASYNC
Future<void> main() async {
  print('=== COURSERA APP (WEEK 11 ASYNC OOP) ===\n');

  var video = VideoLesson('Async & Await in Dart', 'Google Dev', 15);
  var quiz = QuizAssessment('Dart Concurrency Quiz', 'NTC Faculty', 80);

  // Synchronous actions (runs immediately)
  video.download(video.title);
  video.markAsDone();
  video.showInfo();

  print('');

  // PROVING IT'S NON-BLOCKING:
  // Step A: Print message immediately BEFORE the await
  print('⏳ Saving "${video.title}" progress to server... (App is still responsive!)');

  // Step B: Call the Future-returning method using await
  String serverResponse = await video.syncProgressToCloud();

  // Step C: Print the result only AFTER the 2-second delay completes
  print(serverResponse);

  print('\n--- Next Task ---');
  quiz.markAsDone();
  quiz.showInfo();
  print('⏳ Syncing "${quiz.title}"...');
  print(await quiz.syncProgressToCloud());
}