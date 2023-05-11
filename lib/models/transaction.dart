// ignore_for_file: invalid_required_positional_param

import 'package:flutter/foundation.dart';

class Transaction {
  late final String id;
  late final String title;
  late final double amount;
  DateTime date;
  Transaction(@required this.amount, @required this.id, @required this.date,
      @required this.title);
}
