import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgRu extends StatelessWidget {
  const SvgRu({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/svg/ru.svg');
  }
}

class SvgUk extends StatelessWidget {
  const SvgUk({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/svg/uk.svg');
  }
}
