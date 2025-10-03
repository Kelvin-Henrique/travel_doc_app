enum Flavor {
  DEV,
  PROD,
}

class F {
  static Flavor appFlavor = Flavor.DEV;

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.DEV:
        return "https://fadd5ef22326.ngrok-free.app/";
      case Flavor.PROD:
        return "https://fadd5ef22326.ngrok-free.app/";
    }
  }
}
