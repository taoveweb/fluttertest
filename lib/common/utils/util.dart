import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  GradientText(this.data,
      {required this.gradient,
      required this.style,
      this.textAlign = TextAlign.left});

  final String data;
  final Gradient gradient;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(Offset.zero & bounds.size);
      },
      child: Text(
        data,
        textAlign: textAlign,
        style: (style == null)
            ? TextStyle(color: Colors.white)
            : style.copyWith(color: Colors.white),
      ),
    );
  }
}

Size boundingTextSize(String text, TextStyle style,
    {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
  if (text == null || text.isEmpty) {
    return Size.zero;
  }
  final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: text, style: style),
      maxLines: maxLines)
    ..layout(maxWidth: maxWidth);
  return textPainter.size;
}
