import sys

filepath = sys.argv[1]
f = open(filepath)



arcs=dict()


def is_nonproj(node, head_node, arcs):
    left_node=int(node)
    right_node=int(head_node)
    if int(node)>int(head_node):
        left_node = int(head_node)
        right_node = int(node)


    for index in arcs:
        head = arcs[index]
        left = int(index)
        right = int(head)
        if int(index) > int(head):
            left = int(head)
            right = int(index)

        if (left<left_node and left_node<right and right<right_node) or (left>left_node and left_node>right and right>right_node):
            if left == 0 or left_node == 0: #Si se corta con el root, no cuenta
                return False

            #print(left, right, "vs", left_node, right_node)
            return True

    return False


def creates_cycle(index,head,arcs):
    iter=len(arcs)+1
    if head not in arcs: return False
    elto=arcs[head]
    while iter>0:
        if elto==index:
            #print(elto, head)
            return True

        if elto not in arcs: return False
        elto=arcs[elto]
        iter-=1

    return False



def process_sentence(dict_lines,arcs):
    num_arcs=0
    num_nonproj=0
    
    for elto in range(len(dict_lines)+1):
        if elto == 0:continue
        line=dict_lines[str(elto)]
        #print(line)
        fields = line.split('\t')
        index = fields[0]
        head = fields[6]
        label = fields[7]
        fields[3] = fields[4]

        num_arcs+=1
        if is_nonproj(index,head,arcs):
            num_nonproj+=1

    return num_arcs,num_nonproj



                
dict_lines=dict()

num_arcs=0
num_nonproj=0

for line in f:
    line = line.strip()

    
    if len(line) == 0:
    
        a,b = process_sentence(dict_lines,arcs)
        num_arcs+=a
        num_nonproj+=b
#        for elto in arcs:
#            if creates_cycle(elto, arcs[elto], arcs):
#                print('CICLO')
#                exit(1)
#        print()
        dict_lines.clear()
        arcs.clear()
        size_sent=0

    else:
        
        fields = line.split('\t')
        index = fields[0]
        #fields[3] = fields[4]
        head = fields[6]
        label = fields[7]

        arcs[index]=head

        dict_lines[index]=line

print('TOTAL',num_arcs)
print('NONPROJ',num_nonproj)

f.close()
