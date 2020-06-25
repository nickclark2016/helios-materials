from enum import Enum


class GLSLBuiltins:
    Boolean = 'bool'
    Double = 'double'
    Float = 'float'
    Int = 'int'
    UInt = 'uint'

    @staticmethod
    def convert(name: str):
        if name == 'bool':
            return 'bool'
        elif name == 'f64':
            return 'double'
        elif name == 'f32':
            return 'float'
        elif name == 'i32':
            return 'int'
        elif name == 'u32':
            return 'uint'
        return None
