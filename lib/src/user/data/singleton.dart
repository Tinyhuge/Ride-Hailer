class Singleton {
  static final Singleton _singleton = Singleton._internal();

  /// storing all the data locally until the app cleared from recent

  factory Singleton() {
    return _singleton;
  }
  Singleton._internal();

  String currentLoc = "";
  String togoLoc = "";

  String currentLat = "";
  String currentLong = "";

  String togoLat = "";
  String togoLong = "";
}
