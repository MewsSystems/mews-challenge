import 'dart:ui';

import 'package:core/core.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key key,
    @required this.question,
    @required this.onAnswer,
  }) : super(key: key);

  final Question question;
  final void Function(String) onAnswer;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (question.tag != null) ...[
            QuestionLabel(tag: question.tag),
            Container(height: 12),
          ],
          Text(
            question.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(height: 40),
          if (question.code != null) ...[
            Text(
              formatCode(question.code),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Source Code Pro',
              ),
            ),
            Container(height: 32),
          ],
          ...question.answers.map(
            (a) => AnswerButton(
              onClick: () {
                onAnswer(a.id);
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: a.image == null
                    ? Text(
                        formatCode(a.text),
                        style: TextStyle(
                          color: const Color(0xFF0F1A2B),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )
                    : RemoteImage(imageId: a.image),
              ),
            ),
          ),
        ],
      );
}

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    Key key,
    @required this.child,
    @required this.onClick,
  }) : super(key: key);

  final Widget child;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 56),
            child: child,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
          ),
          Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(4),
              color: Colors.transparent,
              child: InkWell(
                onTap: onClick,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RemoteImage extends StatelessWidget {
  const RemoteImage({Key key, @required this.imageId}) : super(key: key);

  final String imageId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: storage()
          .ref('questions/$imageId')
          .getDownloadURL()
          .then((u) => u.toString()),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        return Image.network(snapshot.data);
      },
    );
  }
}

class QuestionLabel extends StatelessWidget {
  const QuestionLabel({Key key, this.tag}) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    final colors = _mapColors(tag);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: colors.backgroundColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: Text(
        tag.toUpperCase(),
        style: TextStyle(
          color: colors.textColor,
          fontSize: 14,
          height: 1.3,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  LabelColors _mapColors(String tag) {
    switch (tag) {
      case 'C#':
        return const LabelColors(Color(0xFFFFDD56), Color(0xFF493508));
      case 'Dart':
        return const LabelColors(Color(0xFF4DB2FC), Color(0xFF0A2652));
      case 'Data':
        return const LabelColors(Color(0xFFE87067), Color(0xFF400A06));
      case 'JS':
      default:
        return const LabelColors(Color(0xFF57D56B), Color(0xFF063D0B));
    }
  }
}

class LabelColors {
  const LabelColors(this.backgroundColor, this.textColor);

  final Color backgroundColor;
  final Color textColor;
}
