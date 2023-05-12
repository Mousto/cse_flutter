import 'package:flutter/material.dart';

class BilletsNotification extends Notification {
  final int id;
  final int billetAdulte;
  final int billetEnfant;

  BilletsNotification({
    required this.id,
    required this.billetAdulte,
    required this.billetEnfant,
  });
}
