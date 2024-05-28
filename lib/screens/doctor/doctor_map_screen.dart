import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/constants/consts.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/models/destination/destination_model.dart';
import 'package:smart_ambulance/models/hospital/hospital_model.dart';
import 'package:smart_ambulance/providers/destination_provider.dart';
import 'package:smart_ambulance/providers/paramedic_destinations_provider.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorMapScreen extends StatefulWidget {
  const DoctorMapScreen({super.key});

  @override
  State<DoctorMapScreen> createState() => _DoctorMapScreenState();
}

class _DoctorMapScreenState extends State<DoctorMapScreen> {
  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  static const LatLng _initialPos = LatLng(45.75337, 21.22804);
  LatLng? _currentPos;

  Timer? timer;

  Map<PolylineId, Polyline> polylines = {};

  final Set<Marker> markers = {};

  static const List<double> markerColors = [
    BitmapDescriptor.hueAzure,
    BitmapDescriptor.hueBlue,
    BitmapDescriptor.hueCyan,
    BitmapDescriptor.hueMagenta,
    BitmapDescriptor.hueOrange,
    BitmapDescriptor.hueRose,
    BitmapDescriptor.hueViolet,
    BitmapDescriptor.hueYellow
  ];

  static List<MaterialColor> polylineColors = [];

  late final ParamedicDestinationsProvider paramedicDestinationsProvider;

  @override
  void initState() {
    super.initState();

    paramedicDestinationsProvider = context.read<ParamedicDestinationsProvider>();

    var azure = getMaterialColor(const Color.fromARGB(200, 0, 127, 255));
    var magenta = getMaterialColor(const Color.fromARGB(200, 250, 45, 208));
    var rose = getMaterialColor(const Color.fromARGB(200, 194, 30, 86));
    var violet = getMaterialColor(const Color.fromARGB(200, 149, 0, 255));
    polylineColors = [
      azure,
      Colors.blue,
      Colors.cyan,
      magenta,
      Colors.orange,
      rose,
      violet,
      Colors.yellow
    ];

    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => updateLocations());

    getDestinations().then((_) => {
      getLocationUpdates().then((_) => updateLocations())
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.paramedic_map, backButton: true),
      body: _currentPos == null ? const Center(child: Text("Loading..."),) : 
      Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: ((GoogleMapController controller) => _mapController.complete(controller)),
            initialCameraPosition: const CameraPosition(target: _initialPos, zoom: 13),
            markers: markers,
            polylines: Set<Polyline>.of(polylines.values),
          ),
        ]
      )
    );
  }

  Future<void> getDestinations() async {
    await paramedicDestinationsProvider.getHospitals;
    await paramedicDestinationsProvider.getDestinations;
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();

    if (!mounted) return;

    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    if (!mounted) return;

    permissionGranted = await _locationController.hasPermission();

    if (!mounted) return;

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    if (!mounted) return;

    _locationController.onLocationChanged.listen((LocationData currentLocation) { 
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        if (!mounted) return;
        setState(() {
          _currentPos = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

  Future <List<LatLng>> getPolylinePoints(DestinationModel destination) async {
    List<LatLng> polylineCoordinates = [];

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY, 
      PointLatLng(destination.latStart, destination.lngStart), 
      PointLatLng(destination.latDestination, destination.lngDestination), 
      travelMode: TravelMode.driving
    );

    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
       });
    }

    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polyLineCoordinates, DestinationModel destination, MaterialColor color) async {
    PolylineId id = PolylineId("poly${destination.uid}"); // distinct polygonid for each polylines
    Polyline polyline = Polyline(polylineId: id, color: color, points: polyLineCoordinates, width: 6);

    if (!mounted) return;
    setState(() {
      polylines[id] = polyline;
    });
  }

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  void updateLocations() async {
    await paramedicDestinationsProvider.getDestinations;

    for (var hospital in paramedicDestinationsProvider.hospitals) {
      markers.add(Marker(
        markerId: MarkerId("Hospital_${hospital.name}"), 
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), 
        position: LatLng(hospital.lat, hospital.lng),
        infoWindow: InfoWindow(
          title: hospital.name,
          snippet: hospital.address
        )
      ));
    }

    if (_currentPos != null) {
      markers.add(Marker(markerId: const MarkerId("_currentLocation"), icon: BitmapDescriptor.defaultMarker, position: _currentPos!));
    }

    for (var i = 0; i < paramedicDestinationsProvider.destinations.length; i++) {
      DestinationModel destination = paramedicDestinationsProvider.destinations[i];
      Random random = Random();
      int randomNumber = random.nextInt(markerColors.length);

      var randomHue = markerColors[randomNumber];
      MaterialColor color = polylineColors[randomNumber];

      markers.add(
        Marker(
          markerId: MarkerId("Paramedic_${destination.userUid}"),
          icon: BitmapDescriptor.defaultMarkerWithHue(randomHue),
          position: LatLng(destination.latCurrent, destination.lngCurrent),
          infoWindow: InfoWindow(
            title: destination.paramedicName
          )
        )
      );

      getPolylinePoints(destination).then((coordinates) => generatePolyLineFromPoints(coordinates, destination, color));
    }
  }
}