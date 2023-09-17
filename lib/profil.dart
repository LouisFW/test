import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nama: Louis Fernando Winata',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'NIM: 825210078',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}