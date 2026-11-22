import 'dart:async';

/// ABSTRACT CLASS: Defines a standard contract for any learning item that can be finished.
/// Why: Ensures every course or lesson implements a consistent completion behavior.
abstract class Completable {
  void markAsDone();
}

/// MIXIN: Provides reusable offline download functionality without forcing inheritance.
/// Why: Allows unrelated classes (like VideoLesson and StudyGuide) to share download logic cleanly.
mixin Downloadable {
  void download(String itemName) {
    print('⬇️ Downloading "$itemName" for offline use...');
  }
}

/// STANDALONE CLASS: Represents supplementary PDF notes outside the main course hierarchy.
/// Why: Demonstrates how a Mixin shares behavior across different object types.
class StudyGuide with Downloadable {
  String topic;

  // Constructor initializes the guide's topic upon creation.
  StudyGuide(this.topic);
}

/// BASE CLASS: Models a core Coursera course with encapsulation and async cloud syncing.
/// Why: Serves as the parent blueprint so specialized course types avoid duplicating common fields.
class CourseraCourse implements Completable {
  String title;
  String instructor;
  
  // Private field (_isCompleted) protects the completion state from accidental external edits.
  bool _isCompleted = false;

  // Constructor sets the required title and instructor when instantiating a course.
  CourseraCourse(this.title, this.instructor);

  // Public getter provides safe, read-only access to the private _isCompleted state.
  bool get isCompleted => _isCompleted;

  // Updates the encapsulated state to completed and notifies the user.
  @override
  void markAsDone() {
    _isCompleted = true;
    print('✅ Completed Course: $title');
  }

  // Displays basic course details; designed to be overridden by child classes.
  void showInfo() {
    print('📘 Course: $title by $instructor | Done: $_isCompleted');
  }

  /// ASYNC METHOD: Simulates saving course progress to a remote Coursera server.
  /// Why: Uses Future and async/await so network latency (2 seconds) does not freeze the app.
  Future<String> syncProgressToCloud() async {
    await Future.delayed(Duration(seconds: 2));
    return '☁️ Server Sync Complete: "$title" (Completed: $_isCompleted) saved to Coursera Cloud.';
  }
}

/// DERIVED CLASS 1: Extends CourseraCourse for video-based modules and adds offline capability.
/// Why: Inherits core course properties while adding video duration and offline downloads.
class VideoLesson extends CourseraCourse with Downloadable {
  int durationMinutes;

  // Uses 'super' to pass shared properties to the parent constructor while setting duration.
  VideoLesson(super.title, super.instructor, this.durationMinutes);

  // POLYMORPHISM: Overrides showInfo() to display video-specific duration details.
  @override
  void showInfo() {
    print('🎥 Video Lesson: $title ($durationMinutes mins) | Done: $isCompleted');
  }
}

/// DERIVED CLASS 2: Extends CourseraCourse for graded assessments.
/// Why: Specializes a course module by requiring a passing score threshold.
class QuizAssessment extends CourseraCourse {
  int passingScore;

  // Passes title and instructor to the base class and initializes passingScore.
  QuizAssessment(super.title, super.instructor, this.passingScore);

  // POLYMORPHISM: Overrides showInfo() to highlight the required passing grade.
  @override
  void showInfo() {
    print('📝 Quiz: $title (Passing: $passingScore%) | Done: $isCompleted');
  }
}

/// MAIN ENTRY POINT: Marked async to handle non-blocking server operations cleanly.
Future<void> main() async {
  print('=== COURSERA APP (MILESTONE 2 CODE WALKTHROUGH) ===\n');

  // Instantiate specialized child objects from the CourseraCourse hierarchy.
  var video = VideoLesson('Async & Await in Dart', 'Google Dev', 15);
  var quiz = QuizAssessment('Dart Concurrency Quiz', 'NTC Faculty', 80);

  // Execute mixin and inherited methods immediately (synchronous).
  video.download(video.title);
  video.markAsDone();
  video.showInfo();

  print('');

  // Print status before 'await' to prove the main thread remains non-blocking.
  print('⏳ Saving "${video.title}" progress to server... (App is still responsive!)');

  // Pause only this async operation until the 2-second simulated server sync finishes.
  String serverResponse = await video.syncProgressToCloud();
  print(serverResponse);

  print('\n--- Next Task ---');
  quiz.markAsDone();
  quiz.showInfo();
  print('⏳ Syncing "${quiz.title}"...');
  print(await quiz.syncProgressToCloud());
}
