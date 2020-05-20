#!/bin/bash

cp ./models/$1/*pred_const_test$2 ./ctb/best_pred_test.conllx



python ./scripts/gold_order_sents.py ./ctb/best_pred_test.conllx ./ctb/LIU-GOLD-ORDER > ./ctb/pred_test.conllx.ordered
paste ./ctb/pred_test.conllx.ordered ./ctb/LIU-GOLD-WORDS-SIN-219 ./ctb/liu_predicted_unaries_test > ./ctb/tmp



cat ./ctb/tmp | awk  '{print $1 "\t" $9 "\t" $3 "\t" $10 "\t" $10 "\t" $6 "\t" $7 "\t" $8}' > ./ctb/pred_test.conllx.gold_words





java -jar -Dfile.encoding=utf-8  ./scripts/converter.jar deconv ./ctb/pred_test.conllx.gold_words ./ctb/pred_test.nouna.trees.non_ordered 4

python ./scripts/reorder_words.py ./ctb/pred_test.conllx.gold_words ./ctb/pred_test.nouna.trees.non_ordered > ./ctb/pred_test.nouna.trees





python ./scripts/expand.py ./ctb/pred_test.nouna.trees > ./ctb/pred_test.trees

echo "F1"



./scripts/EVALB/evalb -p ./scripts/EVALB/COLLINS.prm  ./ctb/LIU-GOLD-TEST.trees  ./ctb/pred_test.trees




