import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<String> popularSeries = [
  //GOT
  'tt0944947',
  //  Breaking bad
  'tt0903747',
  //  Walking dead
  'tt1520211',
  //  Vikings
  'tt2306299',
  // See
  'tt7949218',
  //  MR.robot
  'tt4158110',
  //  Prison break
  'tt0455275',
  // //Star Wars: Visions
  // 'tt13622982',
  // //  Doom Patrol
  // 'tt8416494',
];

final kImageContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 4,
      offset: const Offset(10, 6), // Shadow position
    ),
  ],
  borderRadius: const BorderRadius.all(Radius.circular(10)),
);
