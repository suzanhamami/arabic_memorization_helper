import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/domain/entity/transcript_entity.dart';
import 'package:internship_project/domain/repository/transcript_repo.dart';
part 'transcription_event.dart';
part 'transcription_state.dart';

class TranscriptionBloc extends Bloc<TranscriptionEvent, TranscriptionState> {
  final TranscriptRepo transcriptRepo;
  TranscriptionBloc({required this.transcriptRepo})
    : super(TranscriptionInitial()) {
    on<AudioRecorded>((event, emit) => emit(AudioRecording()));
    on<AudioUploaded>((event, emit) async {
      emit(AudioUploading());
      try {
        final uploadResult = await transcriptRepo.uploadAudio(
          audioFile: event.file,
        );
        //TODO: try to send an exception to sentry here and on line 39
        if (uploadResult.isLeft()) {
          final failure = uploadResult.swap().getOrElse(
            () => throw Exception(),
          );
          emit(TranscriptionError(message: failure.message));
          return;
        }

        final uploadUrl = uploadResult.getOrElse(() => "");
        emit(AudioUploadedSuccessfully(response: uploadUrl));

        final transcribeResult = await transcriptRepo.transcribeAudio(
          uploadUrl: uploadUrl,
        );

        if (transcribeResult.isLeft()) {
          final failure = transcribeResult.swap().getOrElse(
            () => throw Exception(),
          );
          emit(TranscriptionError(message: failure.message));
          return;
        }

        final transcriptId = transcribeResult.getOrElse(() => "");
        emit(TranscriptionLoading(transcriptId: transcriptId));

        final transcriptResult = await transcriptRepo.getTranscript(
          transcriptId: transcriptId,
        );

        transcriptResult.fold(
          (failure) => emit(TranscriptionError(message: failure.message)),
          (transcriptEntity) {
            print(
              'Emitting TranscriptionReady with text: ${transcriptEntity.text}...',
            );
            emit(TranscriptionReady(transcript: transcriptEntity));
          },
        );
      } catch (e, s) {
        debugPrint("TranscriptionBloc error: $e");
        debugPrint("Stack trace: $s");
        emit(TranscriptionError(message: "Unexpected error: ${e.toString()}"));
      }
    });
  }
}
