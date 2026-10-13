import 'dart:io';

import 'package:baseX/Core/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

Future<void> openXPlatformMaps({
  required double latitude,
  required double longitude,
  String? destinationTitle,
}) async {
  await _openMaps(
    coords: LocationCoords(latitude, longitude, title: destinationTitle),
    usePlatformMap: true,
  );
}

Future<void> openXGoogleMaps({
  required double latitude,
  required double longitude,
  String? destinationTitle,
}) async {
  await openXMaps(
    coords: LocationCoords(latitude, longitude, title: destinationTitle),
    mapType: MapApp.google,
  );
}

Future<void> openXAppleMaps({
  required double latitude,
  required double longitude,
  String? destinationTitle,
}) async {
  await openXMaps(
    coords: LocationCoords(latitude, longitude, title: destinationTitle),
    mapType: MapApp.apple,
  );
}

Future<void> openXWazeMaps({
  required double latitude,
  required double longitude,
  String? destinationTitle,
}) async {
  await openXMaps(
    coords: LocationCoords(latitude, longitude, title: destinationTitle),
    mapType: MapApp.waze,
  );
}

Future<void> openXMaps({required LocationCoords coords, required MapApp mapType}) async {
  await _openMaps(coords: coords, mapType: mapType);
}

Future<void> _openMaps({
  required LocationCoords coords,
  bool usePlatformMap = false,
  MapApp? mapType,
}) async {
  if (usePlatformMap) {
    if (Platform.isIOS) {
      await MapLauncher.directions(coords).show(map: MapApp.apple);
    } else if (Platform.isAndroid) {
      await MapLauncher.directions(coords).show(map: MapApp.google);
    }
  } else {
    try {
      await MapLauncher.directions(coords).show(map: mapType!);
    } on Exception catch (e) {
      XLogger.error('$e', className: 'x_open_map');
      openXPlatformMaps(
        latitude: coords.lat,
        longitude: coords.lng,
        destinationTitle: coords.title,
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
  final DirectionsRequest request = MapLauncher.directions(
    LocationCoords(latitude, longitude, title: destinationTitle),
  );
  final List<SupportedMap> availableMaps = (await request.getSupportedMaps(MapApp.all))
      .where((map) => map.isInstalled)
      .toList();

  return showCupertinoModalPopup(
    context: Get.context!,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: title != null ? Text(title, style: TextStyle(fontSize: 14)) : null,
      message: message != null ? Text(message, style: TextStyle(fontSize: 12)) : null,
      actions: [
        for (SupportedMap map in availableMaps)
          CupertinoActionSheetAction(
            onPressed: () => map.show(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.memory(map.iconBytes, height: 30, width: 30),
                SizedBox(width: 12),
                Text(map.name),
              ],
            ),
          ),
      ],
    ),
  );
}
