import 'package:flutter/material.dart';

import '../core/core.dart';

class ErrorHandlerUtils {
  static void handleErrors(dynamic error, BuildContext context) {
    if (error is ErrorResponse) {
      switch (error.error) {
        // ...
        // Please write cases that need to have customized actions here.
        // Note: Remember to add "break".
        case "not_read_object_in_odoo":
          print("[ERROR: $error]");
        // ...
        // Please write cases that need to show snack bar below like the statement above.
        default:
          _showErrorSnackBar("Something went wrong!", context);
          break;
      }
    }

    if (error is NetworkFailure) {
      _showErrorSnackBar(
        "No internet connection!",
        context,
        icon: Icon(Icons.network_check_outlined),
      );
      return;
    }

    if (error is String) {
      print("[ERROR: $error]");
      _showErrorSnackBar("Something went wrong!", context);
      return;
    }

    print("[ERROR: Unknown error!] - $error");
    _showErrorSnackBar("Something went wrong!", context);
  }

  static void _showErrorSnackBar(String message, BuildContext context,
      {Widget? icon}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                )
              ]),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 19),
          child: Row(
            children: [
              icon ??
                  Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red,
                  ),
              const SizedBox(width: 20),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.red),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
