import sys
import re


filepath = sys.argv[1]
f = open(filepath)

filepath2 = sys.argv[2]
f2 = open(filepath2)

gold=[]
pred=[]

total=0
correct=0
total_una=0
correct_una=0
for line in f:
    line = line.strip()
    if len(line)>0:gold.append(line)
    

for line in f2:
    line = line.strip()
    if len(line)>0:pred.append(line)
    
for i,e in enumerate(gold):
    total+=1
    if '+' in e: total_una+=1
    if e == pred[i]:
        correct+=1
        if '+' in e:
            correct_una+=1
    if e != pred[i] and '+' in e: print(e,pred[i])

print('total:',total)
print('correct:',correct,correct/total)
print('total una:',total_una)
print('correct una:',correct_una,correct_una/total_una)
