import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iat_nigeria/constants/constants.dart';

import 'custom_circular_progress.dart';

showWaitingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        // child: WaitCircularProgress(title: 'Please wait'),
        child: Padding(
          padding: EdgeInsets.only(top: 49, bottom: 39),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomCircularProgress(
                size: 86,
                color: kColorPrimary,
              ),
              SizedBox(
                height: 41,
              ),
              Text(
                'Please Wait',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
