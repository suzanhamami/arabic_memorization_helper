// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/presentation/widgets/memorization_bottombar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/domain/entity/transcript_entity.dart';
import 'package:internship_project/presentation/comparison/bloc/comparison_bloc.dart';
import 'package:internship_project/presentation/transcription/bloc/transcription_bloc.dart';
import 'package:internship_project/presentation/widgets/memorization_container.dart';
import 'package:internship_project/presentation/widgets/progress_bar.dart';

class MemorizationPage extends StatefulWidget {
  const MemorizationPage({super.key});

  @override
  State<MemorizationPage> createState() => _MemorizationPageState();
}

class _MemorizationPageState extends State<MemorizationPage> {
  late AudioRecorder audioRecorder;
  bool isRecording = false;
  String? recordPath;
  TranscriptEntity originalText = TranscriptEntity(text: "i ate an apple.");

  @override
  void initState() {
    audioRecorder = AudioRecorder();
    super.initState();
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldColor,
      body: Column(
        children: [
          SafeArea(child: SizedBox()),
          ProgressBar(),
          SizedBox(height: 30.h),
          Expanded(
            child: MemorizationContainer(
              isRecording: isRecording,
              child: Center(
                child: BlocConsumer<TranscriptionBloc, TranscriptionState>(
                  listener: (context, state) {
                    if (state is AudioRecording) {
                      setState(() {
                        isRecording = true;
                      });
                    } else if (state is AudioUploading) {
                      setState(() {
                        isRecording = false;
                      });
                    } else if (state is TranscriptionReady) {
                      context.read<ComparisonBloc>().add(
                        ComparisonRequested(
                          originalText: originalText,
                          userText: state.transcript,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    switch (state) {
                      case AudioUploading() ||
                          TranscriptionLoading() ||
                          AudioUploadedSuccessfully():
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text(
                              "جاري معالجة التسجيل...",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        );
                      case TranscriptionReady():
                        return Text(
                          "تم استخراج النص بنجاح!",
                          style: TextStyle(color: Colors.white),
                        );
                      case TranscriptionError():
                        return Text(
                          state.message,
                          style: TextStyle(color: Colors.red),
                        );
                      case AudioRecording():
                        return Text(
                          "يتم تسجيل صوت...",
                          style: TextStyle(color: Colors.white),
                        );
                      default:
                        return Text(
                          originalText.text,
                          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w400, fontFamily: "Inter"),
                        );
                    }
                  },
                ),
              ),
            ),
          ),
          BlocListener<ComparisonBloc, ComparisonState>(
            listener: (BuildContext context, ComparisonState state) {
              switch (state) {
                case ComparisonError():
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                        style: TextStyle(color: Colors.red),
                      ),
                      showCloseIcon: true,
                      duration: Duration(seconds: 120),
                    ),
                  );
                case ComparisonSuccess():
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.comparisonResultEntity.toString(),
                        style: TextStyle(color: Colors.amber),
                      ),
                      showCloseIcon: true,
                      duration: Duration(seconds: 120),
                    ),
                  );
                default:
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: LinearProgressIndicator()));
              }
            },
            child: MemorizationBottomBar(
              isRecording: isRecording,
              audioRecording: audioRecording,
            ),
          ),
        ],
      ),
    );
  }
Future<void> audioRecording() async {
    if (isRecording) {
      String? filePath = await audioRecorder.stop();
      try {
        if (filePath != null) {
          recordPath = filePath;
          if (context.mounted) {
            context.read<TranscriptionBloc>().add(
              AudioUploaded(file: File(recordPath!)),
            );
          }
        }
      } catch (e, s) {
        print("from stop func");
        print(s);
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory directory = await getApplicationDocumentsDirectory();
        final String filePath =
            "${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a";
        try {
          await audioRecorder.start(const RecordConfig(), path: filePath);
          context.read<TranscriptionBloc>().add(AudioRecorded());
        } catch (e, s) {
          print("from start record func");
          print(s);
        }
      }
    }
  }
}