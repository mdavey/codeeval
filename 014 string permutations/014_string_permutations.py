import sys
import itertools

# filename = sys.argv[1]
filename = 'data.txt'

for line in open(filename, 'r'):
    characters = [c for c in line.strip()]
    words = [''.join(char) for char in itertools.permutations(characters)]
    words.sort()
    print ','.join(words)
