import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openMaps(Coords coord, {String? destinationTitle, bool isUseDefault = true}) async {
  final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

  if (isUseDefault) {
    launchUrl(
      Uri.parse(
          'geo:${coord.latitude},${coord.longitude}?q=${coord.latitude},${coord.longitude}($destinationTitle)'),
      mode: LaunchMode.externalApplication,
    );
  } else {
    return showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Maps',
          style: TextStyle(fontSize: 14),
        ),
        message: Text(
          'Select your favourite navigation',
          style: TextStyle(fontSize: 12),
        ),
        actions: [
          for (AvailableMap map in availableMaps)
            CupertinoActionSheetAction(
              onPressed: () =>
                  {map.showDirections(destination: coord, destinationTitle: destinationTitle)},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    map.icon,
                    height: 30.0,
                    width: 30.0,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(map.mapName),
                ],
              ),
            )
        ],
      ),
    );
  }
}
