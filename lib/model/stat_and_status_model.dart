import 'package:flutter_mise/model/stat_model.dart';
import 'package:flutter_mise/model/status_model.dart';

class StatAndStatusModel {
  final ItemCode itemCode;
  final StatusModel status;
  final StatModel stat;

  StatAndStatusModel({
    required this.status,
    required this.stat,
    required this.itemCode,
  });
}
