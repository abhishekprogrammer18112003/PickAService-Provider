class Validators {
  static String? firstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required.';
    }
    return null;
  }

  static String? lastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Last name is required.';
    }
    return null;
  }

  static String? states(int count) {
    if (count == 0) {
      return 'Registered states is required.';
    }
    return null;
  }

  static String? gender(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Gender is required.';
    }
    return null;
  }

  static String? currentLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Current location is required.';
    }
    return null;
  }

  static String? preferredLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Preferred location is required.';
    }
    return null;
  }

  static String? age(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required.';
    }
    if (int.parse(value) <= 0) {
      return 'Age must be positive.';
    }
    return null;
  }

  static String? joiningInDays(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Earliest joining is required.';
    }
    if (int.parse(value) <= 0) {
      return 'Value must be positive.';
    }
    return null;
  }

  static String? experience(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Experience is required.';
    }
    if (int.parse(value) <= 0) {
      return 'Value must be positive.';
    }
    return null;
  }

  static String? language(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Language is required.';
    }
    return null;
  }

  static String? degree(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Degree is required.';
    }
    return null;
  }

  static String? specialization(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Specialization is required.';
    }
    return null;
  }

  static String? percentile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Percentage is required.';
    }
    return null;
  }

  static String? institute(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Institute is required.';
    }
    return null;
  }

  static String? eCtc(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Expected CTC is required.';
    }
    return null;
  }

  static String? ctc(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Current CTC is required.';
    }
    return null;
  }

  static String? skills(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Skills is required.';
    }
    return null;
  }

  static String? jobTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Job is required.';
    }
    return null;
  }

  static String? company(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Company is required.';
    }
    return null;
  }

  static String? startDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required.';
    }
    return null;
  }

  static String? endDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required.';
    }
    return null;
  }

  static String? description(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required.';
    }
    return null;
  }

  // static String? workedNabhHospital(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Value is required.';
  //   }
  //   return null;
  // }

  static String? certName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required.';
    }
    return null;
  }

  static String? certOrg(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Organization is required.';
    }
    return null;
  }

  static String? certIssueDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required.';
    }
    return null;
  }

  static String? recommName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required.';
    }
    return null;
  }

  static String? recommOrg(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Organization is required.';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    final bool isMatch =
        RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
            .hasMatch(value.trim());
    if (!isMatch) {
      return 'Invalid email.';
    }
    return null;
  }

  static String? recommRelation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Relation is required.';
    }
    return null;
  }

  static String? prefSalary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Salary is required.';
    }
    return null;
  }

  static String? internshipTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required.';
    }
    return null;
  }

  static String? internshipCompany(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Company is required.';
    }
    return null;
  }

  static String? internshipStartDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required.';
    }
    return null;
  }

  static String? internshipEndDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required.';
    }
    return null;
  }

  static String? feedback(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Feedback is required.';
    }
    return null;
  }
}
