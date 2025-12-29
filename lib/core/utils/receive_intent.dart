// Handles platform channel communication for receiving video stream intents.
//
// This module manages communication between Flutter and native platforms
// to receive video stream data from external applications.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_player/core/error/failure.dart';
import 'package:url_player/data/models/stream_model.dart';

/// Platform channel for receiving intent data from native platforms.
final _intentChannel = const MethodChannel('intent_channel');

/// Receives stream quality data from platform intent.
///
/// Returns a list of [StreamQuality] objects parsed from the platform intent.
/// Returns an empty list if no data is available or if an error occurs.
///
/// Throws [PlatformFailure] if platform channel communication fails.
Future<List<StreamQuality>> receiveIntentQualities() async {
  try {
    final intent = await _intentChannel.invokeMethod('getIntentData');

    if (intent == null) {
      debugPrint('Intent data is null');
      return [];
    }

    final String jsonString = intent['streams'] ?? '[]';

    if (jsonString.isEmpty || jsonString == '[]') {
      debugPrint('No stream data in intent');
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);

      if (jsonList.isEmpty) {
        return [];
      }

      List<StreamQuality> streamQualitiesList =
          jsonList
              .map((e) {
                try {
                  return StreamQuality.fromJson(Map<String, dynamic>.from(e));
                } catch (e) {
                  debugPrint('Error parsing stream quality: $e');
                  return null;
                }
              })
              .whereType<StreamQuality>()
              .toList();

      return streamQualitiesList;
    } on FormatException catch (e) {
      debugPrint('JSON decode error: $e');
      throw PlatformFailure.userFriendly('Invalid data format received');
    }
  } on PlatformException catch (e) {
    debugPrint(
      'Platform exception receiving intent data: ${e.code} - ${e.message}',
    );
    throw PlatformFailure.userFriendly(
      'Platform error: ${e.message ?? e.code}',
    );
  } on Exception catch (e) {
    debugPrint('Unexpected error receiving intent data: $e');
    throw PlatformFailure.userFriendly('Unexpected error occurred');
  }
}

/// Listens for new intents from the platform.
///
/// [onNewData] callback is invoked when new intent data is received.
/// The callback receives a list of [StreamQuality] objects.
///
/// Errors during parsing are logged but don't interrupt the listener.
void listenToNewIntents(Function(List<StreamQuality>) onNewData) {
  _intentChannel.setMethodCallHandler((call) async {
    try {
      if (call.method == 'newIntentReceived') {
        final dataJson = call.arguments?['streams'] as String? ?? '[]';

        if (dataJson.isEmpty || dataJson == '[]') {
          debugPrint('Empty stream data in new intent');
          return null;
        }

        try {
          final List<dynamic> decoded = jsonDecode(dataJson);

          final qualities =
              decoded
                  .map((e) {
                    try {
                      return StreamQuality.fromJson(
                        Map<String, dynamic>.from(e),
                      );
                    } catch (e) {
                      debugPrint(
                        'Error parsing stream quality in listener: $e',
                      );
                      return null;
                    }
                  })
                  .whereType<StreamQuality>()
                  .toList();

          if (qualities.isNotEmpty) {
            onNewData(qualities);
          }
        } on FormatException catch (e) {
          debugPrint('JSON decode error in listener: $e');
        }
      }
    } on PlatformException catch (e) {
      debugPrint(
        'Platform exception in intent listener: ${e.code} - ${e.message}',
      );
    } on Exception catch (e) {
      debugPrint('Unexpected error in intent listener: $e');
    }

    return null;
  });
}
