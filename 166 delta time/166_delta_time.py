import sys


def to_time_stamp(s):
    h, m, s = [int(i) for i in s.split(':')]
    return s + (m*60) + (h*60*60)


def from_time_stamp(i):
    h = i // (60*60)
    i -= h * 60 * 60
    m = i // 60
    i -= m * 60
    return '{:02d}:{:02d}:{:02d}'.format(h, m, i)


with open(sys.argv[1], 'r') as f:
    for line in f:
        left, right = [to_time_stamp(x) for x in line.strip().split(' ')]
        print(from_time_stamp(abs(left - right)))
