import 'dart:math';

double randomInRange(double min, double max) {
  final random = Random();
  return min + random.nextDouble() * (max - min);
}
