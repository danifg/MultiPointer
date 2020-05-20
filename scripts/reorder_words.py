from nltk import tree, treetransforms
import sys

filepath = sys.argv[1]
f = open(filepath)

filepath2 = sys.argv[2]
f2 = open(filepath2)  



def process_sentence(leaves, words, postags, con_sent):
    children=""
    for node in range(len(leaves)+1):
        if node == 0: continue
        #children+=str(node)+' '
        children+=leaves[str(node)]+' '

    plain_tree = tree.Tree.fromstring('(S '+children+')', remove_empty_top_bracketing=True)
    orig_tree = tree.Tree.fromstring(con_sent, remove_empty_top_bracketing=True)

    orig_tree=orig_tree[0]
    if orig_tree.leaves() != plain_tree.leaves():
        #print(plain_tree)
        #print(orig_tree)
        #print(plain_tree.leaves())
        #print(orig_tree.leaves())

        orig_leaves=orig_tree.leaves()
        plain_leaves=plain_tree.leaves()
        #for i, elto in enumerate(plain_leaves):
            #if elto != orig_leaves[i]:
         #       print(elto, orig_leaves[i])
        i=0      
        for s in orig_tree.subtrees(lambda t: t.height() == 2):
            #print(s)
                    
            s.set_label(postags[str(i+1)])
            #print(s)
            s[0]=words[str(i+1)]
            #print(s[0])
                #exit(0)
            i+=1


        orig_tree=plain_tree
        #print(orig_tree)
        #exit(0)
        #print('(S '+children+')')
        
    #else:
        #print(con_sent)

        

    parse_string = ' '.join(str(orig_tree).split())

    print(parse_string)

    


con_lines=[]
for line in f2:
    line = line.strip()
    con_lines.append(line)
    

leaves=dict()

words=dict()
postags=dict()
num_sent=0
for line in f:
    line = line.strip()

    if len(line) == 0:

        process_sentence(leaves,words,postags,con_lines[num_sent])

        num_sent+=1
        leaves.clear()

    else:
        fields = line.split('\t')
        index = fields[0]
        word = fields[1]
        postag = fields[4]
        leaves[index]='('+postag+' '+word+')'

        words[index]=word
        postags[index]=postag
