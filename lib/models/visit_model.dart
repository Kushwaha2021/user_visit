import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum VisitStatus {
  notStarted,
  inProgress,
  completed,
}

extension VisitStatusDisplay on VisitStatus {
  String get displayTitle {
    switch (this) {
      case VisitStatus.notStarted:
        return 'Not Started';
      case VisitStatus.inProgress:
        return 'In Progress';
      case VisitStatus.completed:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case VisitStatus.notStarted:
        return Colors.grey.shade300;
      case VisitStatus.inProgress:
        return Colors.orange.shade100;
      case VisitStatus.completed:
        return Colors.green.shade100;
    }
  }

  Color get textColor {
    switch (this) {
      case VisitStatus.notStarted:
        return Colors.grey.shade700;
      case VisitStatus.inProgress:
        return Colors.orange.shade800;
      case VisitStatus.completed:
        return Colors.green.shade800;
    }
  }
}

enum VisitType {
  loan,
  dc,
  goldStorage,
  release,
}

extension VisitTypeDisplay on VisitType {
  String get displayTitle {
    switch (this) {
      case VisitType.loan:
        return 'Loan';
      case VisitType.dc:
        return 'DC';
      case VisitType.goldStorage:
        return 'Gold Storage';
      case VisitType.release:
        return 'Release';
    }
  }
}


class Visit {
  final String id;
  final DateTime dateTime;
  final VisitStatus status;
  final String customerName;
  final VisitType type;

  Visit({
    required this.id,
    required this.dateTime,
    required this.status,
    required this.customerName,
    required this.type,
  });
}


extension DateTimeFormat on DateTime {
  String formatVisitDateTime() {
    return DateFormat('dd MMM, yyyy | hh:mm a').format(this);
  }
}