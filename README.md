EEG-processing
==============
This repository contains two programs:
 1. A script for batch processing EEG data, found under `batch_processing`
 2. A hacked version of `EEG recorder_2015v2.5`, found under NOT 2015! IS SHOULD BE 2007

Batch processing of EEG data

Usage
=====
To batch process EEG data, follow these steps:

 - make sure all the data you want to process at the same time is nicely together in a directory
 - (un)comment desired code and set desired constants in `batch_function.m`. Make sure to choose the output variable correctly.
 - run `main_script.m`




git diff 800c62d -- EEG_recorder.m hacked_recorder/EEG_recorder.m
