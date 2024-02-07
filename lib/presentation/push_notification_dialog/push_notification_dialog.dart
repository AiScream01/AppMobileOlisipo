import 'package:flutter/material.dart';
import 'package:rui_pedro_s_application11/core/app_export.dart';
import 'package:rui_pedro_s_application11/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class PushNotificationDialog extends StatelessWidget {
  const PushNotificationDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 34.h,
        vertical: 115.v,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 69.v,
            ),
            decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 26.v),
                Text(
                  "A enviar Documentos...",
                  style: CustomTextStyles.headlineSmallInter,
                ),
                SizedBox(height: 76.v),
                Container(
                  width: 260.h,
                  margin: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Text(
                    "O seu documento foi enviado com sucesso!",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.titleMediumErrorContainer,
                  ),
                ),
                SizedBox(height: 64.v),
                CustomElevatedButton(
                  height: 51.v,
                  text: "Ir para página principal",
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  buttonTextStyle: theme.textTheme.titleMedium!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
