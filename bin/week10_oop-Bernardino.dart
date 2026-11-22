// 1. ABSTRACT CLASS (25 pts)
abstract class Completable {
  void markAsDone();
}

// 2. MIXIN (25 pts) - Shared behavior using 'with'
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

// 3. BASE CLASS (From Week 9 CourseraCourse)
class CourseraCourse implements Completable {
  String title;
  String instructor;
  bool _isCompleted = false; // Encapsulation from Week 9

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
}

// 4. DERIVED CLASS 1: Inheritance + Polymorphism + Mixin (25 + 25 pts)
class VideoLesson extends CourseraCourse with Downloadable {
  int durationMinutes;

  VideoLesson(super.title, super.instructor, this.durationMinutes);

  // Polymorphism: Overriding showInfo()
  @override
  void showInfo() {
    print('🎥 Video Lesson: $title ($durationMinutes mins) | Done: $isCompleted');
  }
}

// 5. DERIVED CLASS 2: Inheritance + Polymorphism (25 + 25 pts)
class QuizAssessment extends CourseraCourse {
  int passingScore;

  QuizAssessment(super.title, super.instructor, this.passingScore);

  // Polymorphism: Overriding showInfo()
  @override
  void showInfo() {
    print('📝 Quiz: $title (Passing: $passingScore%) | Done: $isCompleted');
  }
}

void main() {
  // Create instances of derived classes
  var video = VideoLesson('Dart Basics', 'Google Dev', 15);
  var quiz = QuizAssessment('OOP Mastery Quiz', 'NTC Faculty', 80);

  // Test Mixin inside and outside the hierarchy
  video.download(video.title);
  var guide = StudyGuide('Week 10 Cheatsheet');
  guide.download(guide.topic);

  print('');

  // Test Polymorphism using a List of the base class
  List<CourseraCourse> lessons = [video, quiz];
  for (var item in lessons) {
    item.markAsDone();
    item.showInfo(); // Calls each subclass's overridden method
  }
}