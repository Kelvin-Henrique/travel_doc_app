enum Flavor {
  DEV,
  PROD,
}

class F {
  static Flavor appFlavor = Flavor.DEV;

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.DEV:
        return "https://41bcf454935e.ngrok-free.app/";
      case Flavor.PROD:
        return "https://41bcf454935e.ngrok-free.app/";
    }
  }
}
