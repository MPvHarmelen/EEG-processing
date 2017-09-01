EEG-processing
==============
This repository contains three programs:
 1. A script for batch processing EEG data with Matlab 2015b, found under `batch_processing`
 2. A hacked version of `EEG recorder_v4.2` for Matlab 2007b, found under `hacked_recorder`
 3. An applet to give neurofeedback to the participant, found under `neurofeedback_applet`


Batch processing of EEG data
----------------------------
To batch process EEG data, follow these steps:

 - make sure all the data you want to process at the same time is nicely together in a directory
 - (un)comment desired code and set desired constants in `batch_function.m`. Make sure to choose the output variable correctly.
 - run `main_script.m`


The hacked EEG recorder
-----------------------
To run the hacked EEG recorder, navigate to the `hacked_recorder` directory within Matlab 2007b,
type `EEG_recorder` in the Matlab prompt and hit return. The program will automatically start updating
the files `alpha.txt` and `beta.txt` with the calculated alpha and bèta values.

To change how this value is calculated from the total power spectrum, change the function in `eeg_power_processing.m`.
It gets a frequency x time matrix and should output whatever should be printed to the file. To change how long data must
be agregated before it is processed, which frequency bands to process and where to save the resulting values, change
the globals `OUTPUT_DELAY`, `OUTPUT_BANDS` and `OUTPUT_FILENAMES` (respectively) in the first few lines of `EEG_recorder.m`.
`OUTPUT_DELAY` is in seconds, `OUTPUT_BANDS` in Hertz and paths in `OUTPUT_FILENAMES` are relative to the current working
directory (the content of which is shown in the small file browser in Matlab), which will be `hacked_recorder` if you
correctly followed the instructions for running the hacked recorder.

The only file of `EEG recorder_v4.2` that was changed, is `EEG_recorder.m`. To see what exactly was
changed, navigate to the root directory of this repository and run:

    git diff 800c62d -- EEG_recorder.m hacked_recorder/EEG_recorder.m

Additionally, the following files were added:

 - `eeg_power_buffer.m`
 - `eeg_power_init.m`
 - `eeg_power_save.m`
 - `eeg_power_processing.m`


The neurofeedback applet
------------------------
To run the neurofeedback applet, navigate to the `neurofeedback_applet` directory within Matlab 2007b,
type `Concentration_Exp` in the Matlab prompt and hit return.
