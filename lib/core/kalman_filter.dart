class KalmanFilter1D {
  final double processNoise;
  final double measurementNoise;

  double _estimate;
  double _errorCovariance;
  bool _initialized = false;

  KalmanFilter1D({
    this.processNoise = 0.6,
    this.measurementNoise = 4.0,
    double initialEstimate = -70,
    double initialErrorCovariance = 1,
  })  : _estimate = initialEstimate,
        _errorCovariance = initialErrorCovariance;

  double update(double measurement) {
    if (!_initialized) {
      _estimate = measurement;
      _initialized = true;
      return _estimate;
    }

    final predictedCovariance = _errorCovariance + processNoise;
    final gain = predictedCovariance / (predictedCovariance + measurementNoise);
    _estimate = _estimate + gain * (measurement - _estimate);
    _errorCovariance = (1 - gain) * predictedCovariance;
    return _estimate;
  }

  double get value => _estimate;

  void reset({double initialEstimate = -70}) {
    _estimate = initialEstimate;
    _errorCovariance = 1;
    _initialized = false;
  }
}
