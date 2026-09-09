enum Grade {
  excellent,
  good,
  satisfactory,
  bad,
}

class Student {
  String name;
  int score;

  Student(this.name, this.score);

  Grade getGrade() {
    if (score >= 90) {
      return Grade.excellent;
    } else if (score >= 75) {
      return Grade.good;
    } else if (score >= 60) {
      return Grade.satisfactory;
    } else {
      return Grade.bad;
    }
  }

  void printInfo() {
    print('$name: $score баллов, оценка: ${getGrade().title}');
  }
}

extension GradeExtension on Grade {
  String get title {
    switch (this) {
      case Grade.excellent:
        return 'Отлично';
      case Grade.good:
        return 'Хорошо';
      case Grade.satisfactory:
        return 'Удовлетворительно';
      case Grade.bad:
        return 'Плохо';
    }
  }
}

Future<void> loadStudents() async {
  await Future.delayed(const Duration(seconds: 10));

  List<Student> students = [
    Student('Анна', 95),
    Student('Иван', 82),
    Student('Мария', 67),
    Student('Пётр', 45),
  ];

  print('Список студентов:');

  for (Student student in students) {
    student.printInfo();
  }

  print('\nСтуденты, набравшие больше 70 баллов:');

  students
      .where((student) => student.score > 70)
      .forEach((student) => print(student.name));
}

void main() {
  loadStudents();
}