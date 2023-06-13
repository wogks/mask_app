import 'package:mask_app/model/stat_model.dart';
import 'package:mask_app/model/status_model.dart';

class StatAndStatusModel {
  final ItemCode itemCode;
  final StatusModel status;
  final StatModel stat;

  StatAndStatusModel({
    required this.itemCode,
    required this.status,
    required this.stat,
  });
}
