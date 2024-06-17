#!/bin/bash

# Run the test coverage script
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html