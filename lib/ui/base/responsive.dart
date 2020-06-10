import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';



abstract class ResponsivePage{
  Widget buildDesktop(BuildContext context);
  Widget buildTablet(BuildContext context);
  Widget buildMobile(BuildContext context);

  Widget buildUi(BuildContext context){
    return ResponsiveBuilder(builder: (context, sizeInfo) {
      if (sizeInfo.deviceScreenType == DeviceScreenType.Desktop) {
        return buildDesktop(context);
      } else if (sizeInfo.deviceScreenType == DeviceScreenType.Tablet) {
        return buildTablet(context);
      } else if (sizeInfo.deviceScreenType == DeviceScreenType.Mobile) {
        return buildMobile(context);
      }
      return Center(
        child: Text(
          "UI's support for this size!"
        ),
      );
    });
  }
}