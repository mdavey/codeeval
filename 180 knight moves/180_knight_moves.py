# C is a letter from 'a' to 'h' and denotes a column.
# N is a number from 1 to 8 and denotes a row.
import sys


def col_to_char(num):
    if num == 1: return 'a'
    elif num == 2: return 'b'
    elif num == 3: return 'c'
    elif num == 4: return 'd'
    elif num == 5: return 'e'
    elif num == 6: return 'f'
    elif num == 7: return 'g'
    elif num == 8: return 'h'
    raise Exception('Invalid column number ' + num)


def char_to_col(ch):
    if ch == 'a': return 1
    elif ch == 'b': return 2
    elif ch == 'c': return 3
    elif ch == 'd': return 4
    elif ch == 'e': return 5
    elif ch == 'f': return 6
    elif ch == 'g': return 7
    elif ch == 'h': return 8
    raise Exception('Invalid column char ' + ch)


def knight_moves(line):
    valid_positions = []
    move_offsets = [
        [-2, -1],
        [-2, 1],
        [2, -1],
        [2, 1],
        [1, -2],
        [1, 2],
        [-1, -2],
        [-1, 2],
    ]

    origin_col, origin_row = char_to_col(line[0]), int(line[1])

    for move_offset in move_offsets:
        new_row = origin_row + move_offset[0]
        new_col = origin_col + move_offset[1]
        if 1 <= new_row <= 8 and 1 <= new_col <= 8:
            valid_positions.append(col_to_char(new_col) + str(new_row))

    valid_positions.sort()

    return ' '.join(valid_positions)


if __name__ == '__main__':
    filename = 'data.txt'

    if len(sys.argv) == 2:
        filename = sys.argv[1]

    with open(filename, 'r') as f:
        for line in f:
            print(knight_moves(line))
