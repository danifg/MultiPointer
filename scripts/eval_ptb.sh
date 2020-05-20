#!/bin/bash

cp ./models/$1/*pred_const_test$2 ./ptb/best_pred_test.conllx

python ./scripts/escape_parenthesis.py ./ptb/best_pred_test.conllx  > ./ptb/pred_test.conllx.escaped

python ./scripts/gold_order_sents.py ./ptb/pred_test.conllx.escaped ./ptb/GOLD-ORDER > ./ptb/pred_test.conllx.ordered


paste ./ptb/pred_test.conllx.ordered ./ptb/GOLD-WORDS ./ptb/predicted_unaries_test > ./ptb/tmp
cat ./ptb/tmp | awk  '{print $1 "\t" $9 "\t" $3 "\t" $10 "\t" $10 "\t" $6 "\t" $7 "\t" $8}' > ./ptb/pred_test.conllx.gold_words






java -jar -Dfile.encoding=utf-8  ./scripts/converter.jar deconv ./ptb/pred_test.conllx.gold_words ./ptb/pred_test.nouna.trees.non_ordered 4

python ./scripts/reorder_words.py ./ptb/pred_test.conllx.gold_words ./ptb/pred_test.nouna.trees.non_ordered > ./ptb/pred_test.nouna.trees





python ./scripts/expand.py ./ptb/pred_test.nouna.trees > ./ptb/pred_test.trees

echo "F1"

./scripts/EVALB/evalb -p ./scripts/EVALB/COLLINS.prm  ./ptb/GOLD-TEST.trees  ./ptb/pred_test.trees




