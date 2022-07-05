import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:get/get.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tailorapp/controller/profile.dart';
import 'package:tailorapp/utils/app_colors.dart';
import 'package:tailorapp/utils/loader.dart';
class Customlocation extends StatefulWidget {
  // Customlocation(String value);


  @override
  _CustomlocationState createState() => _CustomlocationState();
}

class _CustomlocationState extends State<Customlocation> {
  late GoogleMapController googleMapController;
  String addr1 = "";

  String addr2 = "";
  var profile=Get.put(profileController());
  var currentLocation = LocationData;
  var location = new Location();
  var lng, lat;
  var Loading=true;
   LatLng? _initialPosition;
  Map< MarkerId, Marker> markers =<MarkerId, Marker>{};
  Set<Marker> markers_={};
  CameraPosition? camera_position;
  var tap=false;
  //update current location
  void updatePosition(CameraPosition _position) {
    setState(() {
      addr2="load_address".tr;
      camera_position=_position;
      markers_ = Set<Marker>.of(
          [
            Marker(
              draggable: true,
              markerId: MarkerId('first_marker'),
              position: LatLng(_position.target.latitude, _position.target.longitude),
              icon: BitmapDescriptor.defaultMarker,

            )
          ]
      );
      // if(tap==false){
      //   getAddressFromCordinates(
      //       Coordinates(_position.target.latitude, _position.target.longitude));
      // }
    });

  }

  /// convert cord into address
  getAddressFromCordinates(Coordinates cords) async {
    // print(cords);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(cords);

    setState(() {
      addr1 = addresses.first.featureName!;
      addr2 = addresses.first.addressLine!;
    }
    );
  }
  Future _getLocation() async {
    print("Getitng loc 1");
      if(profile.mapaddrerss.value.isNotEmpty && profile.latitude.isNotEmpty && profile.longitude.isNotEmpty ){

        addr2=profile.mapaddrerss.value;
        _initialPosition = LatLng(double.parse(profile.latitude.value), double.parse(profile.longitude.value));

        lat = double.parse(profile.latitude.value);
        lng = double.parse(profile.longitude.value);
        Loading=false;
        setState(() {

        });


      }
      else {
        // print("Getitng loc 4");
        final LocationData _locationResult = await location.getLocation();
        // {
          setState(() {
            _initialPosition =
                LatLng(_locationResult.latitude!, _locationResult.longitude!);
            lat = _locationResult.latitude;
            lng = _locationResult.longitude;
            Loading = false;
          });
        await getAddressFromCordinates(Coordinates(_locationResult.latitude!, _locationResult.longitude!));
        // }
      }
      setState(() {
        markers_=<Marker>{
          Marker(
            onTap: (){
            },
            markerId: MarkerId('first_marker'),
            position: LatLng(lat, lng),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow:  InfoWindow(
              title: 'Drop Me',
            ),

          )
        };
      });



  }



  @override
  void initState(){
    super.initState();
    _getLocation();
    // Loading = true;
  }

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return SafeArea(
      bottom: true,
      child: Scaffold(
          body:Loading ? Center(
            child:Loader(),
          ): Stack(
            children: [
              GoogleMap(

                // gestureRecognizers: Set()
                //   ..add(Factory<OneSequenceGestureRecognizer>(
                //           () => new EagerGestureRecognizer()))
                //   ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                //   ..add(
                //       Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                //   ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                //   ..add(Factory<VerticalDragGestureRecognizer>(
                //           () => VerticalDragGestureRecognizer())),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                trafficEnabled: false,
                myLocationEnabled: true,
                markers: markers_,
                onCameraMove: ((_position) => updatePosition(_position)),
                onCameraIdle: (){
                  getAddressFromCordinates(
                      Coordinates(camera_position?.target.latitude, camera_position?.target.longitude));
                },
                onMapCreated: (
                    GoogleMapController controller
                    ){
                  setState(() {
                    googleMapController = controller;
                  });
                  // googleMapController.
                },
                initialCameraPosition: CameraPosition(
                    target:LatLng(lat, lng),
                    zoom: 15.0
                ),


              ),
              Padding(
                padding: EdgeInsets.only(top: 20,left: 10,right: 20),
                child: Container(
                  margin: EdgeInsets.only(right: 50),
                  decoration: const BoxDecoration(
                      color: buttoncolor,
                      borderRadius:  BorderRadius.all(Radius.circular(20))
                  ),
                  height: 60,
                  width: double.infinity,

                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                   GestureDetector(
                     onTap: (){
                       Get.back();
                     },
                       child: Icon(Icons.arrow_back,color: Color(0xFFD1C4E9))),
                      SizedBox(width: 50,),
                      Center(
                        child: Container( padding: EdgeInsets.only(left:10,top: 5,right: 10),
                          height: 40,
                          width: widthSize*0.7,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:  BorderRadius.all(Radius.circular(20))
                          ),
                          child: RichText(
                            overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,
                            strutStyle: StrutStyle(fontSize: 20.0,),
                            text: TextSpan(
                                style: TextStyle(color: Colors.black,fontSize: 14,),
                                text: "$addr2",),
                          ),

                        ),
                      ),
                    ],
                  )
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 30,right: 30,bottom: 10),
                child: GestureDetector(
                  onTap: () async {
                    await profile.set_mapaddress(addr2,lng,lat);
                    Get.back();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: widthSize*0.300,right: widthSize*0.300),
                    height: 60,
                    decoration:const BoxDecoration(
                        color: buttoncolor,
                        // shape: BoxShape.circle
                        borderRadius:  BorderRadius.all(Radius.circular(50))
                    ),
                    child:const Center(
                      child: Text("Confirm", style: TextStyle(color: Colors.white,
                          fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                      ),
                    ),
                  ),
                ),
                ),
              )
            ],
          )
      ),
    );
  }
}
