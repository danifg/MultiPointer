#!/bin/bash

cp ./models/$1/*gold_const_test$2 ./tiger/best_gold_test.conllx
cp ./models/$1/*pred_const_test$2 ./tiger/best_pred_test.conllx


python ./scripts/ger_escape_parenthesis.py ./tiger/best_gold_test.conllx  > ./tiger/gold_test.conllx.escaped.1

python ./scripts/ger_escape_parenthesis.py ./tiger/best_pred_test.conllx  > ./tiger/pred_test.conllx.escaped.1

cat ./tiger/gold_test.conllx.escaped.1 | awk  '{print $1 "\t" $2 "\t" $3 "\t" $5 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' > ./tiger/gold_test.conllx.escaped
cat ./tiger/pred_test.conllx.escaped.1 | awk  '{print $1 "\t" $2 "\t" $3 "\t" $5 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' > ./tiger/pred_test.conllx.escaped


java -jar -Dfile.encoding=utf-8  ./scripts/disconverter.jar deconv ./tiger/gold_test.conllx.escaped ./tiger/gold_test.trees

java -jar -Dfile.encoding=utf-8  ./scripts/disconverter.jar deconv ./tiger/pred_test.conllx.escaped ./tiger/pred_test.trees


java -jar -Dfile.encoding=utf-8 ./scripts/trees2export.jar  ./tiger/gold_test.trees  TIGER

java -jar -Dfile.encoding=utf-8 ./scripts/trees2export.jar  ./tiger/pred_test.trees  TIGER

echo "F1"

discodop eval ./tiger/gold_test.trees.export  ./tiger/pred_test.trees.export  ./scripts/proper.prm | tail -n 13

echo "Disc F1"

discodop eval ./tiger/gold_test.trees.export  ./tiger/pred_test.trees.export  ./scripts/proper.prm --disconly | tail -n 13


#rm ./tiger/gold_test.conllx.escaped
#rm ./tiger/pred_test.conllx.escaped
rm ./tiger/gold_test.trees
rm ./tiger/pred_test.trees
rm ./tiger/gold_test.trees.export
rm ./tiger/pred_test.trees.export
