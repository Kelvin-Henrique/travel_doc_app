import 'package:flutter/material.dart';

class SuccessAnimatedDialog extends StatefulWidget {
  final String message;
  const SuccessAnimatedDialog({Key? key, required this.message}) : super(key: key);

  @override
  State<SuccessAnimatedDialog> createState() => _SuccessAnimatedDialogState();
}

class _SuccessAnimatedDialogState extends State<SuccessAnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 160,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 900),
              builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: value,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0A4DA1)),
                        strokeWidth: 6,
                      ),
                    ),
                    if (value > 0.95)
                      Icon(Icons.check_circle, color: Color(0xFF0A4DA1), size: 54),
                  ],
                );
              },
            ),
            const SizedBox(height: 18),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
