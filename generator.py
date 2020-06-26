#! /usr/bin/env python3

from converter import convert_type
from languages import Language

from antlr4 import *
from sunscript.SuncriptLexer import *
from sunscript.SuncriptListener import *
from sunscript.SuncriptParser import *

import argparse
from enum import Enum
import os


class SunScriptListener(SuncriptListener):
    def enterShaderBlock(self, ctx):
        print('Found Shader: {}'.format(ctx.Identifier()))
        # TODO: Implement shader block
        pass

    def enterModuleBlock(self, ctx):
        print('Found Module: {}'.format(ctx.Identifier()))
        # TODO: Implement module block

    def enterInputBlock(self, ctx):
        print('Found Input Block: Location={}, Binding={}'.format(
            ctx.locationStatement().Decimal(), ctx.bindingStatement().Decimal()))

    def enterFunctionBlock(self, ctx):
        print('Found Function {} returning {}'.format(
            ctx.Identifier(), ctx.types().getText()))
        # TODO: Implement function block


def create_output_folder(name: str):
    if not os.path.exists(name):
        os.makedirs(name)


def process(input: str, output: str, lang: Language):
    create_output_folder(output)
    input_stream = FileStream(input)
    lexer = SuncriptLexer(input_stream)
    stream = CommonTokenStream(lexer)
    parser = SuncriptParser(stream)
    walker = ParseTreeWalker()
    listener = SunScriptListener()
    tree = parser.compilationUnit()
    listener.lang = lang
    walker.walk(listener, tree)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Suncript Transpiler')
    parser.add_argument('--input', help='Input material file.')
    parser.add_argument(
        '--lang', help='Output language for shaders. Supported languages: glsl')
    parser.add_argument('--output-dir', default="out",
                        help='Output directory.')

    args = parser.parse_args()

    process(args.input, args.output_dir, Language[args.lang])
