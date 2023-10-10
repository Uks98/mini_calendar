
class LocationData{
  String id;
  String placeName;
  String address;
  String gpsX;
  String gpsY;

  LocationData({
    required this.id,
    required this.placeName,
    required this.address,
    required this.gpsX,
    required this.gpsY
});

  factory LocationData.fromJson(Map<String,dynamic> json){
    return LocationData(
      id : json["id"],
      placeName : json["place_name"],
      address: json["address_name"],
      gpsX: json["x"],
      gpsY: json["y"],
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return this.placeName;
  }
}