import 'package:flutter/material.dart';

const Color buttonColor = Color(0x1FFFFFFF);
const Color appBorderColor = Color(0xFFD9D9D9);

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final Color? overlayColor;
  final bool enabled;
  final EdgeInsets? contentPadding;

  const PrimaryButton({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor = buttonColor,
    this.foregroundColor = Colors.white,
    this.borderColor = appBorderColor,
    this.overlayColor,
    this.enabled = true,
    this.contentPadding,
  });

  ButtonStyle getStyle() {
    return ButtonStyle(
      enableFeedback: true,
      overlayColor: MaterialStateColor.resolveWith(
          (states) => overlayColor ?? const Color(0xFFF2F2F2).withOpacity(0.2)),
      padding: MaterialStateProperty.all(
        contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
          side: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade300;
        }
        return backgroundColor; // Defer to the widget's default.
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        }
        return foregroundColor; // Defer to the widget's default.
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: TextButton(
          style: getStyle(),
          onPressed: enabled
              ? () {
                  onTap?.call();
                }
              : null,
          child: child,
        )),
      ],
    );
  }
}
