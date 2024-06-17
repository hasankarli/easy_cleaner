import 'package:easy_cleaner_example/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() {
  LocaleKeys.home.tr();
  Text(LocaleKeys.about).tr();
  LocaleKeys.currencies_usd.tr();
  LocaleKeys.currencies_eur.tr();
  LocaleKeys.currencies_gbp.tr();
}

class TextWidgets extends StatefulWidget {
  const TextWidgets({super.key});

  @override
  State<TextWidgets> createState() => _TextWidgetsState();
}

class _TextWidgetsState extends State<TextWidgets> {
  @override
  void initState() {
    super.initState();
    tr('title');
    'title2'.tr();
    Text('title3').tr();

    plural('money', 10.23);
    plural('money_args', 10.23, args: ['John', '10.23']);
    plural('money_named_args', 10.23,
        namedArgs: {'name': 'Jane', 'money': '10.23'});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(context.tr('title4')),
        Text('money2').plural(1000000,
            format: NumberFormat.compact(locale: context.locale.toString())),
        Text(context.plural('money3', 10.23)),
        Text(LocaleKeys.money4.plural(5)),
      ],
    );
  }
}
