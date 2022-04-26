import 'package:flutter/material.dart';

class TextButtonCustomV1 extends StatelessWidget {
  final String text;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor, textColor, borderColor;
  final double? textSize;
  final VoidCallback? onPressed;
  final bool isOutlineType;
  const TextButtonCustomV1({
    Key? key,
    required this.text,
    this.width,
    this.margin,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.textSize = 16,
    this.onPressed,
    this.isOutlineType = false,
    this.borderColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      margin: this.margin,
      child: TextButton(
        onPressed: this.onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: this.backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: this.isOutlineType ? BorderSide(
              color: this.borderColor!,
              width: 1,
              style: BorderStyle.solid,
            ) : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              this.text,
              style: TextStyle(
                color: this.textColor,
                fontWeight: FontWeight.bold,
                fontSize: this.textSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
