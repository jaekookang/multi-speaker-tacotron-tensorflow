#!/bin/sh

# 1. Download and extract audio and texts
python -m datasets.son.download

# 2. Split audios on silence
python -m audio.silence --audio_pattern "./datasets/son/audio/*.wav" --method=pydub

# 3. Run Google Speech Recognition
export GOOGLE_APPLICATION_CREDENTIALS="My First Project-1df1d151da57.json"
python -m recognition.google --audio_pattern "./datasets/son/audio/*.*.wav"

# 4. Run heuristic text-audio pair search (any improvement on this is welcome)
python -m recognition.alignment --recognition_path "./datasets/son/recognition.json" --score_threshold=0.5

# 5. Make numpy files
python -m datasets.generate_data ./datasets/son/alignment.json

# 5. Remove intro music
rm datasets/son/data/*.0000.npz
