enum Flavor {
  DEV,
  PROD,
}

class F {
  static Flavor appFlavor = Flavor.DEV;

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.DEV:
        return "https://ec135b3b5f48.ngrok-free.app/";
      case Flavor.PROD:
        return "https://ec135b3b5f48.ngrok-free.app/";
    }
  }
}
