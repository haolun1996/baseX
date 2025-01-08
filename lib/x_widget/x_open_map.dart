import 'dart:io';

import 'package:baseX/Core/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

Future<void> openXPlatformMaps({
  required double latitude,
  required double longitude,
  String? destinationTitle,
}) async {
  await _openMaps(
    coords: Coords(latitude, longitude),
    destinationTitle: destinationTitle,
    usePlatformMap: true,
  );
}

Future<void> openXGoogleMaps({
  required double latitude,
  required double longitude,
  String? destinationTitle,
}) async {
  await openXMaps(
    coords: Coords(latitude, longitude),
    destinationTitle: destinationTitle,
    mapType: MapType.google,
  );
}

Future<void> openXAppleMaps({
  required double latitude,
  required double longitude,
  String? destinationTitle,
}) async {
  await openXMaps(
    coords: Coords(latitude, longitude),
    destinationTitle: destinationTitle,
    mapType: MapType.apple,
  );
}

Future<void> openXWazeMaps({
  required double latitude,
  required double longitude,
  String? destinationTitle,
}) async {
  await openXMaps(
    coords: Coords(latitude, longitude),
    destinationTitle: destinationTitle,
    mapType: MapType.waze,
  );
}

Future<void> openXMaps({
  required Coords coords,
  required MapType mapType,
  String? destinationTitle,
}) async {
  await _openMaps(
    coords: coords,
    destinationTitle: destinationTitle,
    mapType: mapType,
  );
}

Future<void> _openMaps({
  required Coords coords,
  String? destinationTitle,
  bool usePlatformMap = false,
  MapType? mapType,
}) async {
  if (usePlatformMap) {
    if (Platform.isIOS) {
      await MapLauncher.showDirections(
        mapType: MapType.apple,
        destination: coords,
        destinationTitle: destinationTitle,
      );
    } else if (Platform.isAndroid) {
      await MapLauncher.showDirections(
        mapType: MapType.google,
        destination: coords,
        destinationTitle: destinationTitle,
      );
    }
  } else {
    try {
      await MapLauncher.showDirections(
        mapType: mapType!,
        destination: coords,
        destinationTitle: destinationTitle,
      );
    } on PlatformException catch (e) {
      XLogger.error('${e.code}: ${e.message}', className: 'x_open_map');
      openXPlatformMaps(
        latitude: coords.latitude,
        longitude: coords.longitude,
        destinationTitle: destinationTitle,
      );
    }
  }
}

Future<void> showXMapSelection({
  required double latitude,
  required double longitude,
  String? destinationTitle,
  String? title = 'Maps',
  String? message = 'Select your favourite navigation',
}) async {
  final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;

  return showCupertinoModalPopup(
    context: Get.context!,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: title != null
          ? Text(
              title,
              style: TextStyle(fontSize: 14),
            )
          : null,
      message: message != null
          ? Text(
              message,
              style: TextStyle(fontSize: 12),
            )
          : null,
      actions: [
        for (AvailableMap map in availableMaps)
          CupertinoActionSheetAction(
            onPressed: () => {
              map.showDirections(
                  destination: Coords(latitude, longitude), destinationTitle: destinationTitle)
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  map.icon,
                  height: 30,
                  width: 30,
                ),
                SizedBox(width: 12),
                Text(map.mapName),
              ],
            ),
          )
      ],
    ),
  );
}
