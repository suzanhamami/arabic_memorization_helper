// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internship_project/config/endpoints.dart';
import 'package:internship_project/core/error/exception.dart';
import 'package:internship_project/data/model/transcript_model.dart';
import 'package:retry/retry.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class TranscriptionDataSource {
  final Dio dio;
  TranscriptionDataSource({required this.dio});

  // String apiKey = dotenv.env['API_KEY']!;
  static const String apiKey = String.fromEnvironment('API_KEY');
  //______________________________________________________________________________________

  Future<String> uploadAudio({required File audioFile}) async {
    try {
      final response = await dio.post(
        Endpoints.uploadAudioEndPoint,
        options: Options(
          headers: {
            "authorization": apiKey,
            "Content-Type": "application/octet-stream",
          },
        ),
        data: audioFile.readAsBytesSync(),
      );
      if (response.statusCode == 200) {
        return response.data["upload_url"];
      }
      final serverException = ServerException(
        message: "Uploading audio failed with non-200 status code.",
      );
      await Sentry.captureException(
        serverException,
        stackTrace: StackTrace.current,
      );
      throw serverException;
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw ServerException(message: "Uploading audio failed: ${e.toString()}");
    }
  }
  //______________________________________________________________________________________

  Future<String> transcribeAudio({required String uploadUrl}) async {
    try {
      final response = await dio.post(
        Endpoints.transcribeAudioEndPoint,
        options: Options(
          headers: {
            "authorization": apiKey,
            "Content-Type": "application/json",
          },
        ),
        data: {
          "audio_url": uploadUrl,
          "format_text": false,
          "punctuate": false,
          "disfluencies": true,
          // "language_code": "ar",
          "language_detection": true,
        },
      );
      print(response.data);
      if (response.statusCode == 200) {
        return response.data["id"];
      }
      final serverException = ServerException(
        message: "Transcribing failed with non-200 status code.",
      );
      await Sentry.captureException(
        serverException,
        stackTrace: StackTrace.current,
      );
      throw serverException;
    } catch (e, s) {
      print("from transcribe request");
      print(s);
      await Sentry.captureException(e, stackTrace: s);
      throw ServerException(
        message: "Transcribing audio failed: ${e.toString()}",
      );
    }
  }

  //______________________________________________________________________________________
  Future<TranscriptModel> getTranscript({required String transcriptId}) async {
    try {
      return await retry(() async {
        final response = await dio
            .get(
              Endpoints.getTranscriptEndPoint(transcriptId),
              options: Options(headers: {"authorization": apiKey}),
            )
            .timeout(Duration(seconds: 60));
        final status = response.data["status"];
        print(status);
        if (status == "completed") {
          TranscriptModel transcript = TranscriptModel.fromMap(response.data);
          print(transcript);
          return transcript;
        } else if (status == "error") {
          final transcribingFailedException = TranscribingFailedException(
            message: response.data["error"] ?? "Unknown error",
          );
          await Sentry.captureException(
            transcribingFailedException,
            stackTrace: StackTrace.current,
          );
          throw transcribingFailedException;
        }
        final transcriptNotReadyException = TranscriptNotReadyException(
          message: "Transcript is still processing",
        );
        await Sentry.captureException(
          transcriptNotReadyException,
          stackTrace: StackTrace.current,
        );
        throw transcriptNotReadyException;
      }, retryIf: (e) => e is TranscriptNotReadyException);
    } catch (e, s) {
      print("from get transcript request");
      print(s);
      await Sentry.captureException(e, stackTrace: s);
      throw ServerException(
        message: "Getting transcript failed: ${e.toString()}",
      );
    }
  }
}
