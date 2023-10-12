import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:go_router/go_router.dart';

import '../../logic/movie_class.dart';

class MapsPage extends StatelessWidget {
  Movie? movie;
  MapsPage({super.key, this.movie});

  LatLng initialPos = const LatLng(59.3293, 18.0686);

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: Platform.isAndroid ? "XXXXXXXXXXXXXXXXX" : "XXXXXXXXXXXX-e1TaqA",
      onPlacePicked: (result) {
        context.goNamed("create_event_page",
            extra: movie, queryParams: {'location': result.formattedAddress});
      },

      useCurrentLocation: true,
      resizeToAvoidBottomInset: false,
      initialPosition:
          initialPos, // only works in page mode, less flickery, remove if wrong offsets
    );
  }
}
