import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

AnimatedSnackBar? _snackBar;

/// A custom and re-usable snackbar to show error, success, info and warning messages
snackBarHelper(BuildContext context,
    {required String message, AnimatedSnackBarType type = AnimatedSnackBarType.success}) {
  if (_snackBar != null) _snackBar?.remove();

  _snackBar = AnimatedSnackBar.material(
    message,
    type: type,
    mobileSnackBarPosition: MobileSnackBarPosition.top,
    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    duration: const Duration(seconds: 5),
  );
  _snackBar?.show(context);
}
