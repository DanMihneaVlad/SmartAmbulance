import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/constants/consts.dart';
import 'package:smart_ambulance/constants/input_decoration.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/models/hospital/hospital_model.dart';
import 'package:smart_ambulance/providers/destination_provider.dart';
import 'package:smart_ambulance/providers/hospital_provider.dart';
import 'package:smart_ambulance/widgets/custom_alert_dialog.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class ParamedicMapScreen extends StatefulWidget {
  const ParamedicMapScreen({super.key});

  @override
  State<ParamedicMapScreen> createState() => _ParamedicMapScreenState();
}

class _ParamedicMapScreenState extends State<ParamedicMapScreen> {

  Location _locationController = new Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  static const LatLng _pGooglePlex = LatLng(45.7377, 21.2412);
  static const LatLng _pAcasa = LatLng(45.7545, 21.2537);
  LatLng? _currentPos = null;

  Map<PolylineId, Polyline> polylines = {};

  late final DestinationProvider destinationProvider;

  HospitalModel? _destinationHospital;

  @override
  void initState() {
    super.initState();

    destinationProvider = context.read<DestinationProvider>();

    getHospitalsAndDestination().then((_) => {
    getLocationUpdates().then((_) => {
      setPolylinePoints()
    })});
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
            initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
            markers: getMarkers(),
            polylines: Set<Polyline>.of(polylines.values),
          ),
          Container(
            padding: const EdgeInsets.only(top: 24, right: 12),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () async {
                    var formKey = GlobalKey<FormState>();

                    showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.paramedic_map_hospital_destination),
                        content: Form(
                          key: formKey,
                          child: DropdownButtonFormField(
                            value: _destinationHospital,
                            validator: (value) {
                              if (value == null) {
                                return AppLocalizations.of(context)!.paramedic_map_error_no_hospital;
                              }
                              return null;
                            },
                            isExpanded: true,
                            onChanged: (HospitalModel? newValue) {
                              _destinationHospital = newValue!;
                            },
                            items: destinationProvider.hospitals.map<DropdownMenuItem<HospitalModel>>((HospitalModel value) {
                              return DropdownMenuItem<HospitalModel>(value: value, child: Text(value.name));
                            }).toList(), 
                            decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.paramedic_map_hint_hospital),
                          ),
                        ),
                        actions: [
                        TextButton(
                          onPressed: (() async {
                            try {

                              if (formKey.currentState!.validate()) {
                                if (_currentPos == null || _destinationHospital == null || destinationProvider.userDestination.uid.isNotEmpty) {
                                  if (mounted) Navigator.of(context).pop();
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                      CustomAlertDialog(
                                        title: AppLocalizations.of(context)!.paramedic_map_error_destination_not_set));
                                } else { 
                                  await destinationProvider.setDestination(_currentPos!.latitude, _currentPos!.longitude, _destinationHospital!);

                                  getPolylinePoints().then((coordinates) => generatePolyLineFromPoints(coordinates));

                                  if (mounted) Navigator.of(context).pop();
                                }
                              }
                            } catch (e) {
                              if (mounted) Navigator.of(context).pop();
                            }
                          }),
                          child: Text(AppLocalizations.of(context)!.paramedic_map_set_destination))
                        ],
                      )
                    );
                  },
                  heroTag: "btn1",
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.local_hospital_outlined, color: Colors.green, size: SmartAmbulanceSizes.fabSize,),
                ),
                const SizedBox(height: SmartAmbulanceSizes.mediumSizedBox,),
                FloatingActionButton(
                  onPressed: () async {
                    if (destinationProvider.userDestination.uid.isNotEmpty) {
                      PolylineId id = PolylineId("poly${destinationProvider.userDestination.latStart}");

                      await destinationProvider.stopTravelling();

                      removePolyline(id);
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                          CustomAlertDialog(
                            title: AppLocalizations.of(context)!.paramedic_map_error_not_travelling));
                    }
                  },
                  heroTag: "btn2",
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.stop_circle, color: Colors.red, size: SmartAmbulanceSizes.fabSize),
                )
              ],
            ),
          )
        ]
      )
    );
  }

  Future<void> getHospitalsAndDestination() async {
    await destinationProvider.getHospitals;
    await destinationProvider.getDestination;
    
    // check for hospital
    if (destinationProvider.userDestination.uid.isNotEmpty) {
      _destinationHospital = destinationProvider.hospitals.firstWhere((h) => h.uid == destinationProvider.userDestination.hospitalUid);
    }
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
          cameraToPosition(_currentPos!);
          if (destinationProvider.userDestination.uid.isNotEmpty && destinationProvider.userDestination.latCurrent != _currentPos!.latitude && destinationProvider.userDestination.lngCurrent != _currentPos!.longitude) {
            destinationProvider.updateLocation(_currentPos!);
          }
        });
      }
    });
  }

  Future<void> cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: position, zoom: 13);

    await controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future <List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY, 
      PointLatLng(destinationProvider.userDestination.latStart, destinationProvider.userDestination.lngStart), 
      PointLatLng(_destinationHospital!.lat, _destinationHospital!.lng), 
      travelMode: TravelMode.driving
    );

    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
       });
    }

    return polylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polyLineCoordinates) async {
    PolylineId id = PolylineId("poly${destinationProvider.userDestination.latStart}"); // distinct polygonid for each polylines
    Polyline polyline = Polyline(polylineId: id, color: Colors.blue, points: polyLineCoordinates, width: 6);

    if (!mounted) return;
    setState(() {
      polylines[id] = polyline;
    });
  }

  void removePolyline(PolylineId id) async {
    if (!mounted) return;
    setState(() {
      polylines[id] = Polyline(polylineId: id, color: Colors.blue, points: [], width: 6);
    });
  }

  Future<void> setPolylinePoints() async {
    if (_destinationHospital == null) {
      return;
    } else {
      getPolylinePoints().then((coordinates) => generatePolyLineFromPoints(coordinates));
    }
  }

  Set<Marker> getMarkers() {
    Set<Marker> markers = {};

    markers.add(Marker(markerId: const MarkerId("_currentLocation"), icon: BitmapDescriptor.defaultMarker, position: _currentPos!));

    for (var hospital in destinationProvider.hospitals) {
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

    return markers;
  }
}