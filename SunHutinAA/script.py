import re
from subprocess import call



print('Opening result file')
f = open('result', 'r')

d = {}
x = {}


begin = True


print('Parsing result')
for line in f:
    if line == "\n":
        begin = False
        
    
    if begin:
        m = re.search(r'(?P<x>\d) (?P<y>\d)   (?P<d>\d)', line)
        if m:
            d[m.group('x'), m.group('y')] = m.group('d')
    else:
        m = re.search(r'.*\'x\[(?P<x>\d)\,(?P<y>\d)\]\'\s*(?P<b>\d)', line)
        if m:
            if int(m.group('b')):
                x[m.group('x'), m.group('y')] = 1
        
        
        
        
f2 = open('graph.dot', 'w')
f2.write('digraph G {\n')
f2.write('layout="neato"')

print('Writing dot file')
for k in d:
    f2.write(k[0] + ' [shape="circle"]')
    f2.write(k[1] + ' [shape="circle"]')
    if k in x:
        f2.write(k[0] + ' -> ' + k[1] + ' [label= " ' + d[k] + '", color="red"]\n')
        f2.write(k[0] + ' [color="red"]')
        f2.write(k[1] + ' [color="red"]')
    else:
        f2.write(k[0] + ' -> ' + k[1] + ' [label= " ' + d[k] + '"]\n')
    
f2.write('}\n')

f2.close()

print('Graph generation')
call(["dot", "-Tsvg", "graph.dot", "-o", "graph.svg"])

print('Cleaning up')
call(["rm", "graph.dot"])

print('Done')