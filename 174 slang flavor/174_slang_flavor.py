import sys
import re


class ReplaceWithSlang(object):
    def __init__(self):
        self.toggle = False
        self.offset = 0
        self.slang = [
            ', yeah!',
            ', this is crazy, I tell ya.',
            ', can U believe this?',
            ', eh?',
            ', aw yea.',
            ', yo.',
            '? No way!',
            '. Awesome!'
        ]

    def __call__(self, match):
        return_val = match.group()
        if self.toggle:
            return_val = self.slang[self.offset]
            self.offset += 1
            if self.offset >= len(self.slang):
                self.offset = 0
        self.toggle = not self.toggle
        return return_val


if __name__ == '__main__':
    with open(sys.argv[1], 'r') as f:
        slang_replacer = ReplaceWithSlang()
        for line in f:
            print(re.sub('[\.!\?]', slang_replacer, line.strip()))
