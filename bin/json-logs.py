#!/usr/bin/python
import argparse
import json
import sys
from pygments.formatters import TerminalFormatter
from pygments.lexers import JsonLexer
from pygments import highlight

JSON_LEXER = JsonLexer()
TERM_FORMATTER = TerminalFormatter()
INDENT = 2

parser = argparse.ArgumentParser()
parser.add_argument("--query", "-q", default=None)
args = parser.parse_args()
QUERY_S = args.query


def query(__line, __json_line):
    if QUERY_S:
        for __k in __json_line:
            exec(__k + '=%r' % __json_line[__k])

        try:
            exec('assert ' + QUERY_S)
        except (AssertionError, NameError, AttributeError):
            return False
        else:
            return True

    else:
        return True


for line in sys.stdin:
    try:
        json_line = json.loads(line.rstrip())
        if query(__line=line, __json_line=json_line):
            json_parsed = json.dumps(json_line, indent=INDENT, sort_keys=True)
            sys.stdout.write(highlight(json_parsed, JSON_LEXER, TERM_FORMATTER) + '\n')

    except json.decoder.JSONDecodeError:
        sys.stdout.write(line)

