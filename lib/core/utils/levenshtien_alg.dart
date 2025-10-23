// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:internship_project/core/error/exception.dart';
import 'package:internship_project/core/utils/text_formatting.dart';
import 'package:internship_project/domain/entity/comparison_result_entity.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class WordEdit {
  final String type; // match, insert, delete, substitute
  final String? from;
  final String? to;
  WordEdit({required this.type, this.from, this.to});

  @override
  String toString() {
    switch (type) {
      case "match":
        return "✅ Match: $from";
      case "insert":
        return "➕ Insert: $to";
      case "delete":
        return "❌ Delete: $from";
      case "substitute":
        return "🔁 Substitute: $from → $to";
      default:
        return "";
    }
  }
}

class LevenshtienAlg {
  final TextFormatting formatter;
  LevenshtienAlg({required this.formatter});

  List<String> tokenize({required String text}) {
    List<String> tokens = formatter.formatText(text).split(" ");
    return tokens;
    // userTokens = formatter.formatText(userText).split(" ");
  }

  double editDistance({
    required String originalText,
    required String userText,
  }) {
    int n = originalText.length;
    int m = userText.length;

    List<List<int>> dpMatrix = List.generate(
      n + 1,
      (index) => List.filled(m + 1, 0),
    );
    //filling dp matrix
    for (var i = 1; i < n + 1; i++) {
      for (var j = 1; j < m + 1; j++) {
        if (originalText[i - 1] == userText[j - 1]) {
          dpMatrix[i][j] = dpMatrix[i - 1][j - 1] + 1;
        } else {
          dpMatrix[i][j] = max(dpMatrix[i][j - 1], dpMatrix[i - 1][j]);
        }
      }
    }
    final sim = dpMatrix[n][m];
    final maxLen = n > m ? n : m;
    return sim / maxLen;
  }

  void validateArabicText({required String text}) async{
    final RegExp arabicOnly = RegExp(r'^[\u0600-\u06FF\s]+$');
    if (!arabicOnly.hasMatch(text)) {
      final invalidLanguageException = InvalidLanguageException(
        message: "Text contains non-Arabic letters.",
      );
      await Sentry.captureException(
          invalidLanguageException,
          stackTrace: StackTrace.current,
        );
      throw invalidLanguageException;
    }
  }

  //TODO: fix algorithm
  ComparisonResultEntity compareText({
    required String originalText,
    required String userText,
  }) {
    List<String> originalTokens = tokenize(text: originalText);
    List<String> userTokens = tokenize(text: userText);
    List<String> wrongWords = [];
    int correctWords = 0;
    String score = "";
    // try {
    //   validateArabicText(text: originalText);
    //   validateArabicText(text: userText);
    // } catch (e) {
    //   rethrow;
    // }

    int n = originalTokens.length;
    int m = userTokens.length;

    List<List<int>> dpMatrix = List.generate(
      n + 1,
      (index) => List.filled(m + 1, 0),
    );
    //filling first row and column
    for (var i = 0; i < n + 1; i++) {
      dpMatrix[i][0] = i;
    }
    for (var j = 0; j < m + 1; j++) {
      dpMatrix[0][j] = j;
    }
    for (var i = 1; i < n + 1; i++) {
      for (var j = 1; j < m + 1; j++) {
        int cost = (originalTokens[i - 1] == userTokens[j - 1]) ? 0 : 1;
        dpMatrix[i][j] = [
          dpMatrix[i - 1][j] + 1,
          dpMatrix[i][j - 1] + 1,
          dpMatrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    print("from levenshtien alg");
    List<WordEdit> ops = [];
    var i = n, j = m;
    while (i > 0 || j > 0) {
      if (i > 0 && j > 0) {
        final cost = originalTokens[i - 1] == userTokens[j - 1] ? 0 : 1;
        if (dpMatrix[i][j] == dpMatrix[i - 1][j - 1] + cost) {
          if (cost == 0) {
            ops.add(WordEdit(type: "match", from: originalTokens[i - 1]));
            correctWords++;
          } else {
            final similarity = editDistance(
              originalText: originalTokens[i - 1],
              userText: userTokens[j - 1],
            );
            if (similarity >= 0.6) {
              ops.add(
                WordEdit(
                  type: "substitute",
                  from: originalTokens[i - 1],
                  to: userTokens[j - 1],
                ),
              );
              wrongWords.add(originalTokens[i - 1]);
            } else {
              if (dpMatrix[i - 1][j] <= dpMatrix[i][j - 1]) {
                ops.add(WordEdit(type: "delete", from: originalTokens[i - 1]));
                wrongWords.add(originalTokens[i - 1]);
                i--;
                continue;
              } else {
                ops.add(WordEdit(type: "insert", to: userTokens[j - 1]));
                wrongWords.add(userTokens[j - 1]);
                j--;
                continue;
              }
            }
          }
          i--;
          j--;
          continue;
        }
      }

      // only i left → deletion
      if (i > 0 && (j == 0 || dpMatrix[i][j] == dpMatrix[i - 1][j] + 1)) {
        ops.add(WordEdit(type: "delete", from: originalTokens[i - 1]));
        wrongWords.add(originalTokens[i - 1]);
        i--;
        continue;
      }

      // only j left → insertion
      if (j > 0 && (i == 0 || dpMatrix[i][j] == dpMatrix[i][j - 1] + 1)) {
        ops.add(WordEdit(type: "insert", to: userTokens[j - 1]));
        wrongWords.add(userTokens[j - 1]);
        j--;
        continue;
      }
    }
    wrongWords = wrongWords.reversed.toList();
    print(ops);
    print(dpMatrix);
    print(wrongWords);
    score = "$correctWords/$n";
    return ComparisonResultEntity(score: score, wrongWords: wrongWords);
  }
}