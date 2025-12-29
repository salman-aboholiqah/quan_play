/// Base class for all failures in the application.
/// Provides user-friendly error messages.
abstract class Failure {
  final String message;
  final String? userMessage;
  
  Failure(this.message, {this.userMessage});
  
  /// Returns a user-friendly error message, falling back to technical message if not provided.
  String get displayMessage => userMessage ?? message;
}

/// Failure that occurs when database operations fail.
class CacheFailure extends Failure {
  CacheFailure(super.message, {super.userMessage});
  
  /// Creates a user-friendly cache failure.
  factory CacheFailure.userFriendly(String technicalMessage) {
    String userMessage;
    if (technicalMessage.contains('Insert failed')) {
      userMessage = 'Unable to save the link. Please try again.';
    } else if (technicalMessage.contains('Update failed')) {
      userMessage = 'Unable to update the link. Please try again.';
    } else if (technicalMessage.contains('Delete failed')) {
      userMessage = 'Unable to delete the link. Please try again.';
    } else if (technicalMessage.contains('Fetching')) {
      userMessage = 'Unable to load links. Please restart the app.';
    } else if (technicalMessage.contains('Search failed')) {
      userMessage = 'Search failed. Please try again.';
    } else {
      userMessage = 'An error occurred. Please try again.';
    }
    return CacheFailure(technicalMessage, userMessage: userMessage);
  }
}

/// Failure that occurs when network operations fail.
class NetworkFailure extends Failure {
  NetworkFailure(super.message, {super.userMessage});
  
  factory NetworkFailure.userFriendly(String technicalMessage) {
    String userMessage;
    if (technicalMessage.contains('timeout')) {
      userMessage = 'Connection timed out. Please check your internet connection.';
    } else if (technicalMessage.contains('socket')) {
      userMessage = 'Network error. Please check your internet connection.';
    } else {
      userMessage = 'Unable to connect. Please check your internet connection.';
    }
    return NetworkFailure(technicalMessage, userMessage: userMessage);
  }
}

/// Failure that occurs when platform channel operations fail.
class PlatformFailure extends Failure {
  PlatformFailure(super.message, {super.userMessage});
  
  factory PlatformFailure.userFriendly(String technicalMessage) {
    const userMessage = 'Unable to receive video data. Please try opening the link again.';
    return PlatformFailure(technicalMessage, userMessage: userMessage);
  }
}
