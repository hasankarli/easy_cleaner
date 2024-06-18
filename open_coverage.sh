#!/bin/bash

# Open the coverage report in the browser
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html