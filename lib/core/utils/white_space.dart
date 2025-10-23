import 'package:flutter/cupertino.dart';

extension Spacing on num {
  Widget get spaceVertical {
    return SizedBox(height: toDouble());
  }

  Widget get spaceHorizontal {
    return SizedBox(width: toDouble());
  }
}
