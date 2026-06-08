// ignore_for_file: constant_identifier_names
enum FlavorEnum {
  DEV(appName: "Yala Desarrollo"),
  PROD(appName: "Yala");

  const FlavorEnum({required this.appName});
  final String appName;
}

enum SnackbarEnum {
  success,
  error,
  informative,
}
