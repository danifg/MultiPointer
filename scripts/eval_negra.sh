#!/bin/bash

cp ./models/$1/*gold_const_test$2 ./negra/best_gold_test.conllx
cp ./models/$1/*pred_const_test$2 ./negra/best_pred_test.conllx


python ./scripts/ger_escape_parenthesis.py ./negra/best_gold_test.conllx  > ./negra/gold_test.conllx.escaped.1

python ./scripts/ger_escape_parenthesis.py ./negra/best_pred_test.conllx  > ./negra/pred_test.conllx.escaped.1


cat ./negra/gold_test.conllx.escaped.1 | awk  '{print $1 "\t" $2 "\t" $3 "\t" $5 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' > ./negra/gold_test.conllx.escaped
cat ./negra/pred_test.conllx.escaped.1 | awk  '{print $1 "\t" $2 "\t" $3 "\t" $5 "\t" $5 "\t" $6 "\t" $7 "\t" $8}' > ./negra/pred_test.conllx.escaped


java -jar -Dfile.encoding=utf-8  ./scripts/disconverter.jar deconv ./negra/gold_test.conllx.escaped ./negra/gold_test.trees

java -jar -Dfile.encoding=utf-8  ./scripts/disconverter.jar deconv ./negra/pred_test.conllx.escaped ./negra/pred_test.trees


java -jar -Dfile.encoding=utf-8 ./scripts/trees2export.jar  ./negra/gold_test.trees  NEGRA

java -jar -Dfile.encoding=utf-8 ./scripts/trees2export.jar  ./negra/pred_test.trees  NEGRA

echo "F1"

discodop eval ./negra/gold_test.trees.export  ./negra/pred_test.trees.export  ./scripts/proper.prm | tail -n 13

echo "Disc F1"

discodop eval ./negra/gold_test.trees.export  ./negra/pred_test.trees.export  ./scripts/proper.prm --disconly | tail -n 13


#rm ./negra/gold_test.conllx.escaped
#rm ./negra/pred_test.conllx.escaped
rm ./negra/gold_test.trees
rm ./negra/pred_test.trees
rm ./negra/gold_test.trees.export
rm ./negra/pred_test.trees.export
