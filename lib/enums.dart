/// The status types for a request
/// See [](https://radar.io/documentation/sdk#android-foreground).
enum RadarStatus {
  /// The request succeeded
  success,

  /// The SDK was not initialized with a publishable API key
  errorPublishableKey,

  /// Location permissions have not been granted
  errorPermissions,

  /// The user has not granted location permissions for the app
  errorLocation,

  /// The network was unavailable, or the network connection timed out
  errorNetwork,

  /// The publishable API key is invalid
  errorUnauthorized,

  /// An internal server error occurred
  errorServer,

  /// Exceeded rate limit of 1 request per second per user or 60 requests per hour per user
  errorRateLimit,

  /// An unknown error occurred
  errorUnknown,

  /// An unknown error occurred
  unknown,
}

/// Determines how frequently location updates are requested on the client.
enum RadarTrackingPriority {
  /// The default, more responsive
  responsiveness,

  /// Less responsive, but guaranteed to avoid Android vitals bad behavior thresholds
  efficiency
}

/// Determines whether to replay offline location updates to the server.

enum RadarTrackingOffline {
  /// The default, replays stopped location updates
  replayStopped, // 1,
  /// Replays no location updates
  replayOff, // -1
}

/// Determines which location updates to sync to the server.
enum RadarTrackingSync {
  /// Syncs only locations that could result in events
  possibleStateChanges, // 1
  /// Syncs all location changes
  all, // -1
}
