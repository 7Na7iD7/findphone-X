/// English strings. This is the app's default/fallback language.
const Map<String, String> enStrings = {
  // App
  'appTitle': 'findphone X',

  // Home screen
  'homeSubtitle': 'Find a nearby Bluetooth device by signal strength',
  'deviceNameLabel': 'Device name (optional)',
  'deviceNameHint': 'e.g. iPhone',
  'soundEnabledLabel': 'Proximity sound',
  'redactLabel': 'Hide addresses (screen recording)',
  'surveyButton': 'Scan all devices',
  'huntButton': 'Track this device',
  'pairedDevicesButton': 'Paired devices',
  'permissionsRequired': 'Bluetooth and location permission are required.',
  'settingsTooltip': 'Settings',

  // Hunt screen
  'trendWarmer': '▲ Getting closer',
  'trendColder': '▼ Getting farther',
  'trendSteady': '· Steady',
  'errorPrefix': 'Error: {error}',
  'noSignalYet': 'No signal yet — {count} other device(s) in range',
  'noSignalHint':
      'If this continues, the device is off, out of range\n(roughly 10–20 m), or shielded by something metallic.',
  'distanceApprox': '~{distance} m (estimated)',
  'statsLine': '{count} in the last minute · {total} total readings',
  'peakLine': 'Peak/min {peak} dBm',
  'staleWarning': 'Stale — wait a moment for a fresh reading',
  'moveHint': 'Move a few meters, then stay still for about 10 seconds',

  // Survey screen
  'surveyTitle': 'Scan devices',
  'surveyEmpty': 'Nothing found yet — wait a few seconds',
  'unknownDevice': 'Unknown device',
  'staleSuffix': ' (stale)',

  // Paired devices screen
  'pairedDevicesTitle': 'Paired devices',
  'noPairedDevices': 'No paired devices found.',
  'connected': 'Connected',
  'disconnected': 'Disconnected',

  // Settings screen
  'settingsTitle': 'Settings',
  'languageLabel': 'Language',
  'generalLabel': 'General',
  'developersTitle': 'Developers',
  'linkOpenFailed': "Couldn't open that link.",
};
