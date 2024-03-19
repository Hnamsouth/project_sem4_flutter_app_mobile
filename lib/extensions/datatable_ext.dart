import 'package:flutter/material.dart';

extension DataTableExt on DataTable {
  // set rows

  Widget get withBorder {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: this,
    );
  }
}
