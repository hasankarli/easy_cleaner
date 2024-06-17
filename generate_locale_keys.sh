#!/bin/bash

cd example

# Easy Localization - Generate Locale Keys
dart run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart