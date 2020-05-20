
from __future__ import print_function

from nltk.tree import Tree

import sys

def expand_unary(tree, unaryChar="+"):

        #nodeList = [(tree, [])]

        nodeList = [tree]

        #print(nodeList)
        # depth-first traversal of tree
        while nodeList != []:
                node = nodeList.pop()
             
             
                if isinstance(node, Tree):
                        #print(node)
                        unaryIndex = node.label().find(unaryChar)
                        if unaryIndex != -1:
                                newNode = Tree(
                                        node.label()[unaryIndex + 1 :], [i for i in node]
                                )
                                node.set_label(node.label()[:unaryIndex])
                                node[0:] = [newNode]
                        

                        for child in node:
                                nodeList.append(child)



if __name__ == '__main__':
        from nltk.draw.tree import draw_trees
        from nltk import tree, treetransforms
        from copy import deepcopy

        filepath = sys.argv[1]
        f = open(filepath)
        for line in f:
                #line = line.rstrip('\n')
                # original tree from WSJ bracketed text
                sentence = line#"(S (NP (RB I)) (KK (VP (VBD was) (NP (DET an) (NNP apple)))))"

                #print(sentence)

                t = tree.Tree.fromstring(sentence, remove_empty_top_bracketing=True)
                #t = tree.Tree.read(sentence, remove_empty_top_bracketing=True)
        
                # collapse subtrees with only one child
                collapsedTree = deepcopy(t)
                #treetransforms.collapse_unary(collapsedTree)

                
                #collapse_unary(collapsedTree, collapsePOS=True)
                expand_unary(collapsedTree)
                parse_string = ' '.join(str(collapsedTree).split())
                print(parse_string)
                #sentence2=collapsedTree.pprint()

                #sentence2 = sentence2.strip('\n')
                #print(sentence2)
        #draw_trees(t, collapsedTree)

        f.close()




