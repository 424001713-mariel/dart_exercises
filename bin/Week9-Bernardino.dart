/// Base class representing a Coursera Course (Foundation for Week 10 Inheritance)
class CourseraCourse {
  // Public properties (fields)
  final String courseId;
  String title;
  String instructor;
  int totalModules;

  // 1. ENCAPSULATION: Private fields using underscore (_)
  int _completedModules;
  bool _isEnrolled;

  // 2. CONSTRUCTOR: Sets initial values when a new object is created
  CourseraCourse({
    required this.courseId,
    required this.title,
    required this.instructor,
    required this.totalModules,
    int completedModules = 0,
    bool isEnrolled = false,
  })  : _completedModules = completedModules,
        _isEnrolled = isEnrolled;

  // Getters to safely read private fields
  int get completedModules => _completedModules;
  bool get isEnrolled => _isEnrolled;

  // Calculated property (Behavior/Getter)
  double get progressPercentage {
    if (totalModules == 0) return 0.0;
    return (_completedModules / totalModules) * 100;
  }

  // Methods (Behaviors) that safely update private fields
  void enroll() {
    if (!_isEnrolled) {
      _isEnrolled = true;
      print(' Successfully enrolled in "$title" by $instructor.');
    } else {
      print(' You are already enrolled in "$title".');
    }
  }

  void completeModule() {
    if (!_isEnrolled) {
      print(' Cannot complete module. Please enroll in "$title" first.');
      return;
    }

    if (_completedModules < totalModules) {
      _completedModules++;
      print(
          'Progress updated for "$title": $_completedModules/$totalModules modules (${progressPercentage.toStringAsFixed(1)}%).');
    } else {
      print(' Congratulations! You have already completed all modules in "$title".');
    }
  }

  void displayCourseDetails() {
    print('''
--------------------------------------------------
Course ID   : $courseId
Title       : $title
Instructor  : $instructor
Status      : ${_isEnrolled ? "Enrolled" : "Not Enrolled"}
Progress    : $_completedModules / $totalModules modules (${progressPercentage.toStringAsFixed(1)}%)
--------------------------------------------------''');
  }
}

void main() {
  print('=== COURSERA LEARNING PLATFORM (WEEK 9 OOP) ===\n');

  // 3. CREATE & TEST OBJECTS: Creating instances of CourseraCourse
  final cyberSecurityCourse = CourseraCourse(
    courseId: 'CS-101',
    title: 'Introduction to Cybersecurity',
    instructor: 'IBM Skills Network',
    totalModules: 4,
  );

  final cppCourse = CourseraCourse(
    courseId: 'CPP-202',
    title: 'Introduction to C++',
    instructor: 'University of London',
    totalModules: 5,
    completedModules: 2,
    isEnrolled: true,
  );

  final pythonCourse = CourseraCourse(
    courseId: 'PY-303',
    title: 'Python for Everybody',
    instructor: 'Dr. Charles Severance',
    totalModules: 3,
  );

  // 4. LIST USAGE: Storing a collection of CourseraCourse objects in a List
  List<CourseraCourse> courseCatalog = [
    cyberSecurityCourse,
    cppCourse,
    pythonCourse,
  ];

  // Testing behaviors & encapsulation on individual objects
  cyberSecurityCourse.completeModule(); // Should warn because not enrolled yet
  cyberSecurityCourse.enroll();         // Updates private _isEnrolled to true
  cyberSecurityCourse.completeModule(); // Updates private _completedModules to 1

  print('');
  cppCourse.completeModule();           // Updates from 2 to 3 modules

  // Iterating through the List to display all courses
  print('\n=== ALL AVAILABLE COURSES IN CATALOG (${courseCatalog.length}) ===');
  for (var course in courseCatalog) {
    course.displayCourseDetails();
  }

  // Bonus: Using a Map to organize courses by Course ID for quick lookup
  Map<String, CourseraCourse> courseDirectory = {
    for (var course in courseCatalog) course.courseId: course
  };

  print('Quick Lookup via Map [CS-101]: ${courseDirectory['CS-101']?.title}');
}
