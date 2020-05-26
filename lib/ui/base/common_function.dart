


import 'dart:math';

import 'package:flutter/material.dart';

 Color randomColorNotBW(){
  Random ran = Random();
  int red, blue, green = -1;
  while (true) {
      red = ran.nextInt(254);
      blue = ran.nextInt(254);
      green = ran.nextInt(254);
      if(red != 0 && blue != 0 &&  green != 0){
        break;
      }
  }
  return Color.fromARGB(100, red, blue, green);
}