import glsl_output
from languages import Language


def convert_type(lang: Language, variable_type: str):
    if lang is Language.GLSL:
        return glsl_output.convert(variable_type)
    return None
