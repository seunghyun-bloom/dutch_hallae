import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModifiableAvatar extends StatelessWidget {
  ImageProvider image;
  ModifiableAvatar({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: image,
      backgroundColor: Colors.grey.shade300,
      foregroundColor: Colors.white,
      child: const FaIcon(FontAwesomeIcons.edit),
      radius: 50,
    );
  }
}
