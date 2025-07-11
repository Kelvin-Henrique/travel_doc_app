enum Flavor {
  DEV,
  PROD,
}

class F {
  static Flavor appFlavor = Flavor.DEV;

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.DEV:
        return "https://hmapidadostms.ventunolog.com.br/api/";
      case Flavor.PROD:
        return "https://hmapidadostms.ventunolog.com.br/api/";
    }
  }
}
