enum SprintMode {
  short(duration: Duration(seconds: 25), label: '25s'),
  medium(duration: Duration(seconds: 45), label: '45s'),
  long(duration: Duration(seconds: 60), label: '60s');

  const SprintMode({required this.duration, required this.label});
  final Duration duration;
  final String label;
}
