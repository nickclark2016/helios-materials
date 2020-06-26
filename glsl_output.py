from enum import Enum


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
    if name == 'bvec2':
        return 'bvec2'
    elif name == 'bvec3':
        return 'bvec3'
    elif name == 'bvec4':
        return 'bvec4'
    elif name == 'f64vec2':
        return 'dvec2'
    elif name == 'f64vec3':
        return 'dvec3'
    elif name == 'f64vec4':
        return 'dvec4'
    elif name == 'f32vec2':
        return 'vec2'
    elif name == 'f32vec3':
        return 'vec3'
    elif name == 'f32vec4':
        return 'vec4'
    elif name == 'i32vec2':
        return 'ivec2'
    elif name == 'i32vec3':
        return 'ivec3'
    elif name == 'i32vec4':
        return 'ivec4'
    elif name == 'u32vec2':
        return 'uvec2'
    elif name == 'u32vec3':
        return 'uvec3'
    elif name == 'u32vec4':
        return 'uvec4'
    return None
