import 'package:cardexam/theme/theme_constants.dart';
import 'package:flutter/material.dart';

SnackBar mySnackBar({required Icon iconSnack, required String text}) =>
    SnackBar(
      backgroundColor: backgroundColorDarkDown,
      content: Row(
        children: <Widget>[
          // add your preferred icon here
          iconSnack,
          const SizedBox(width: 15.0),
          // add your preferred text content here
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
