import 'package:flutter_riverpod/flutter_riverpod.dart';

final departmenSelectorProvider = StateProvider<String>((ref) {
  return selectedDepartment ?? departments.first;
});

List<String> departments = [
  'CSE',
  'CE',
  'EC',
  'EX',
  'IT',
  'ME',
  'MBA',
  'MCA',
];

String? selectedDepartment;
