import numpy as np

from posenet.utils.utils import to_numpy

def quaternion_distance(q1, q2):
    """Returns an angle that rotates q1 into q2"""
    q1 = to_numpy(q1)
    q2 = to_numpy(q2)
    cos = 2*(q1.dot(q2))**2 - 1
    cos = max(min(cos, 1), -1) # To combat numerical imprecisions
    return np.arccos(cos)

def quaternion_mult(a, b):
    a = to_numpy(a)
    b = to_numpy(b)
    ab = [a[0]*b[0] - a[1]*b[1] - a[2]*b[2] - a[3]*b[3],
          a[0]*b[1] + a[1]*b[0] + a[2]*b[3] - a[3]*b[2],
          a[0]*b[2] - a[1]*b[3] + a[2]*b[0] + a[3]*b[1],
          a[0]*b[3] + a[1]*b[2] - a[2]*b[1] + a[3]*b[0]]
    return to_numpy(ab)

def rotate_by_quaternion(vec, q):
    vec = to_numpy(vec)
    q = to_numpy(q)
    q = q * 1.0 / np.linalg.norm(q) # Normalise the quaternion
    r = np.append([0], vec)
    q_conj = q * [1,-1,-1,-1]
    return quaternion_mult(quaternion_mult(q, r), q_conj)[1:]

def quat_to_axis(q):
    p = [0,0,-1] # Default blender camera orientation
    return rotate_by_quaternion(p, q)
