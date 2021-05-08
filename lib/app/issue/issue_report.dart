import 'package:fitable/app/issue/models/issue_report_model.dart';
import 'package:fitable/app/meal/models/product_model.dart';
import 'package:fitable/app/meal/product_create_screen.dart';
import 'package:fitable/common_widgets/build_show_dialog.dart';
import 'package:fitable/common_widgets/custom_button.dart';
import 'package:fitable/common_widgets/show_input_picker.dart';
import 'package:fitable/utilities/languages.dart';
import 'package:fitable/utilities/enums.dart';
import 'package:fitable/routers/route_generator.dart';
import 'package:fitable/utilities/macro.dart';
import 'package:fitable/utilities/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void _correctIssue(BuildContext context, dynamic element) async {
  Navigator.pop(context);
  var issuesReport;
  if (element.runtimeType == Product) {
    issuesReport = await Navigator.of(context).pushNamed(
      AppRoute.createProductScreen,
      arguments: ProductCreateScreenArguments(product: element, barcode: element.barcode),
    );
  }

  if (issuesReport != null) context.read(providerDatabase).createIssue(issuesReport);
}

void _otherIssue(BuildContext context, dynamic element, ElementType elementType) {
  String _description;
  showInputPicker(
    hintText: Languages.describe_error(),
    context: context,
    buttonTextYes: Languages.send(),
    multiLine: true,
    isCancel: true,
    onChanged: (v) => _description = v,
    onPressed: () {
      if (_description != null && _description.isNotEmpty) {
        Issue issuesReport = Issue(
          elementType: elementType,
          id: Macro.getId(element),
          dateCreate: DateTime.now(),
          description: _description,
          issueType: IssueType.other,
        );

        context.read(providerDatabase).createIssue(issuesReport);
        Navigator.pop(context);
      }
    },
  );
}

_typeIssue(BuildContext context, dynamic element, ElementType elementType) {
  if (element.runtimeType != Product) return _otherIssue(context, element, elementType);

  return buildShowDialog(
      context: context,
      height: 138,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            child: Text(Languages.report_correction()),
            color: Colors.indigo,
            textColor: Colors.white,
            onPressed: () => _correctIssue(context, element),
          ),
          CustomButton(
              child: Text(Languages.report_bug()),
              color: Colors.indigo,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                _otherIssue(context, element, elementType);
              }),
        ],
      ));
}

issueReport(BuildContext context, dynamic element, ElementType elementType) async {
  bool already = await context.read(providerDatabase).alreadyIssue(element.id, elementType);

  if (already)
    return buildShowDialog(
        context: context,
        height: 138,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Languages.is_aready_issue()),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  child: Text(Languages.cancel()),
                  color: Colors.indigo,
                  textColor: Colors.white,
                  onPressed: () => Navigator.pop(context),
                )),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                      child: Text(Languages.change()),
                      color: Colors.indigo,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        return _typeIssue(context, element, elementType);
                      }),
                ),
              ],
            ),
          ],
        ));

  return _typeIssue(context, element, elementType);
}
