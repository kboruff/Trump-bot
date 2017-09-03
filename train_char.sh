#!/bin/bash

if [ ! -f /dockerdata/glove/glove.840B.300d.txt ]; then
    echo "File not found!"
	wget http://nlp.stanford.edu/data/glove.840B.300d.zip
	mkdir glove
	fastjar xvf glove.840B.300d.zip
	mv glove.840B.300d.txt glove/vectors.840B.300d.txt
	rm glove*
fi

th train.lua \
	-data_dir dockerdata  \
	-rnn_size 256 \
	-num_layers 2 \
	-model gru \
	-learning_rate 2e-3 \
	-learning_rate_decay .97 \
	-learning_rate_decay_after 10 \
	-decay_rate .95 \
	-dropout 0.4 \
	-recurrent_dropout 0 \
	-seq_length 200 \
	-batch_size 50 \
	-max_epochs 60 \
	-grad_clip 5 \
	-train_frac 0.96 \
	-val_frac 0.04 \
	-print_every 5 \
	-eval_val_every 500 \
	-checkpoint_dir cv_char_caps_256_2 \
	-savefile autosave \
	-accurate_gpu_timing 0 \
	-gpuid -1 \
	-opencl 0 \
	-word_level 0 \
	-threshold 2 \
	-glove 1 \
	-optimizer rmsprop \
