/**
 *   raylib-hx - a Haxe binding for the library raylib, a simple and easy-to-use library to enjoy videogames programming
 *
 *   LICENSE: zlib/libpng
 *
 *   raylib-hx is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
 *   BSD-like license that allows static linking with closed source software:
 *
 *   Copyright (c) 2021-2022 Ratul Krisna (@ForeignSasquatch)
 *
 *   This software is provided "as-is", without any express or implied warranty. In no event
 *   will the authors be held liable for any damages arising from the use of this software.
 *
 *   Permission is granted to anyone to use this software for any purpose, including commercial
 *   applications, and to alter it and redistribute it freely, subject to the following restrictions:
 *
 *     1. The origin of this software must not be misrepresented; you must not claim that you
 *     wrote the original software. If you use this software in a product, an acknowledgment
 *     in the product documentation would be appreciated but is not required.
 *
 *     2. Altered source versions must be plainly marked as such, and must not be misrepresented
 *     as being the original software.
 *
 *     3. This notice may not be removed or altered from any source distribution.
 */

package;

#if !cpp
#error 'Raylib supports only C++ target platforms.'
#end
import Raylib;

@:buildXml('<include name="${haxelib:raylib-hx}/project/Build.xml" />')
@:include('raymath-impl.h')
@:unreflective
extern class Raymath
{
    @:native('PI') static var PI:Single;
    @:native('EPSILON') static var EPSILON:Single;
    @:native('DEG2RAD') static var DEG2RAD:Single;
    @:native('RAD2DEG') static var RAD2DEG:Single;
    
    @:native('Clamp') static function clamp(value:Single, min:Single, max:Single):Single;
    @:native('Lerp') static function lerp(start:Single, end:Single, amount:Single):Single;
    @:native('Normalize') static function normalize(value:Single, start:Single, end:Single):Single;
    @:native('Remap') static function remap(value:Single, inputStart:Single, inputEnd:Single, outputStart:Single, outputEnd:Single):Single;
    @:native('Wrap') static function wrap(value:Single, min:Single, max:Single):Single;
    @:native('FloatEquals') static function floatEquals(x:Single, y:Single):Bool;

    @:native('Vector2Zero') static function vector2Zero():RayVector2;
    @:native('Vector2One') static function vector2One():RayVector2;
    @:native('Vector2Add') static function vector2Add(v1:RayVector2, v2:RayVector2):RayVector2;
    @:native('Vector2AddValue') static function vector2AddValue(v:RayVector2, add:Single):RayVector2;
    @:native('Vector2Subtract') static function vector2Subtract(v1:RayVector2, v2:RayVector2):RayVector2;
    @:native('Vector2SubtractValue') static function vector2SubtractValue(v:RayVector2, sub:Single):RayVector2;
    @:native('Vector2Length') static function vector2Length(v:RayVector2):Single;
    @:native('Vector2LengthSqr') static function vector2LengthSqr(v:RayVector2):Single;
    @:native('Vector2DotProduct') static function vector2DotProduct(v1:RayVector2, v2:RayVector2):Single;
    @:native('Vector2Distance') static function vector2Distance(v1:RayVector2, v2:RayVector2):Single;
    @:native('Vector2DistanceSqr') static function vector2DistanceSqr(v1:RayVector2, v2:RayVector2):Single;
    @:native('Vector2Angle') static function vector2Angle(v1:RayVector2, v2:RayVector2):Single;
    @:native('Vector2LineAngle') static function vector2LineAngle(start:RayVector2, end:RayVector2):Single;
    @:native('Vector2Scale') static function vector2Scale(v:RayVector2, scale:Single):RayVector2;
    @:native('Vector2Multiply') static function vector2Multiply(v1:RayVector2, v2:RayVector2):RayVector2;
    @:native('Vector2Negate') static function vector2Negate(v:RayVector2):RayVector2;
    @:native('Vector2Divide') static function vector2Divide(v1:RayVector2, v2:RayVector2):RayVector2;
    @:native('Vector2Normalize') static function vector2Normalize(v:RayVector2):RayVector2;
    @:native('Vector2Transform') static function vector2Transform(v:RayVector2, mat:RayMatrix):RayVector2;
    @:native('Vector2Lerp') static function vector2Lerp(v1:RayVector2, v2:RayVector2, amount:Single):RayVector2;
    @:native('Vector2Reflect') static function vector2Reflect(v:RayVector2, normal:RayVector2):RayVector2;
    @:native('Vector2Rotate') static function vector2Rotate(v:RayVector2, angle:Single):RayVector2;
    @:native('Vector2MoveTowards') static function vector2MoveTowards(v:RayVector2, target:RayVector2, maxDistance:Single):RayVector2;
    @:native('Vector2Invert') static function vector2Invert(v:RayVector2):RayVector2;
    @:native('Vector2Clamp') static function vector2Clamp(v:RayVector2, min:RayVector2, max:RayVector2):RayVector2;
    @:native('Vector2ClampValue') static function vector2ClampValue(v:RayVector2, min:Single, max:Single):RayVector2;
    @:native('Vector2Equals') static function vector2Equals(p:RayVector2, q:RayVector2):Bool;

    @:native('Vector3Zero') static function vector3Zero():RayVector3;
    @:native('Vector3One') static function vector3One():RayVector3;
    @:native('Vector3Add') static function vector3Add(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3AddValue') static function vector3AddValue(v:RayVector3, add:Single):RayVector3;
    @:native('Vector3Subtract') static function vector3Subtract(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3SubtractValue') static function vector3SubtractValue(v:RayVector3, sub:Single):RayVector3;
    @:native('Vector3Scale') static function vector3Scale(v:RayVector3, scalar:Single):RayVector3;
    @:native('Vector3Multiply') static function vector3Multiply(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3CrossProduct') static function vector3CrossProduct(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3Perpendicular') static function vector3Perpendicular(v:RayVector3):RayVector3;
    @:native('Vector3Length') static function vector3Length(v:RayVector3):Single;
    @:native('Vector3LengthSqr') static function vector3LengthSqr(v:RayVector3):Single;
    @:native('Vector3DotProduct') static function vector3DotProduct(v1:RayVector3, v2:RayVector3):Single;
    @:native('Vector3Distance') static function vector3Distance(v1:RayVector3, v2:RayVector3):Single;
    @:native('Vector3DistanceSqr') static function vector3DistanceSqr(v1:RayVector3, v2:RayVector3):Single;
    @:native('Vector3Angle') static function vector3Angle(v1:RayVector3, v2:RayVector3):Single;
    @:native('Vector3Negate') static function vector3Negate(v:RayVector3):RayVector3;
    @:native('Vector3Divide') static function vector3Divide(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3Normalize') static function vector3Normalize(v:RayVector3):RayVector3;
    @:native('Vector3Project') static function vector3Project(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3Reject') static function vector3Reject(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3OrthoNormalize') static function vector3OrthoNormalize(v1:cpp.RawPointer<RayVector3>, v2:cpp.RawPointer<RayVector3>):Void;
    @:native('Vector3Transform') static function vector3Transform(v:RayVector3, mat:RayMatrix):RayVector3;
    @:native('Vector3RotateByQuaternion') static function vector3RotateByRayVector4(v:RayVector3, q:RayVector4):RayVector3;
    @:native('Vector3RotateByAxisAngle') static function vector3RotateByAxisAngle(v:RayVector3, axis:RayVector3, angle:Single):RayVector3;
    @:native('Vector3Lerp') static function vector3Lerp(v1:RayVector3, v2:RayVector3, amount:Single):RayVector3;
    @:native('Vector3Reflect') static function vector3Reflect(v:RayVector3, normal:RayVector3):RayVector3;
    @:native('Vector3Min') static function vector3Min(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3Max') static function vector3Max(v1:RayVector3, v2:RayVector3):RayVector3;
    @:native('Vector3Barycenter') static function vector3Barycenter(p:RayVector3, a:RayVector3, b:RayVector3, c:RayVector3):RayVector3;
    @:native('Vector3Unproject') static function vector3Unproject(source:RayVector3, projection:RayMatrix, view:RayMatrix):RayVector3;
    @:native('Vector3ToFloat') static function vector3ToFloat(v:RayVector3):utils.FloatPointer;
    @:native('Vector3Invert') static function vector3Invert(v:RayVector3):RayVector3;
    @:native('Vector3Clamp') static function vector3Clamp(v:RayVector3, min:RayVector3, max:RayVector3):RayVector3;
    @:native('Vector3ClampValue') static function vector3ClampValue(v:RayVector3, min:Single, max:Single):RayVector3;

    @:native('MatrixDeterminant') static function matrixDeterminant(mat:RayMatrix):Single;
    @:native('MatrixTrace') static function matrixTrace(mat:RayMatrix):Single;
    @:native('MatrixTranspose') static function matrixTranspose(mat:RayMatrix):RayMatrix;
    @:native('MatrixInvert') static function matrixInvert(mat:RayMatrix):RayMatrix;
    @:native('MatrixIdentity') static function matrixIdentity():RayMatrix;
    @:native('MatrixAdd') static function matrixAdd(left:RayMatrix, right:RayMatrix):RayMatrix;
    @:native('MatrixSubtract') static function matrixSubtract(left:RayMatrix, right:RayMatrix):RayMatrix;
    @:native('MatrixMultiply') static function matrixMultiply(left:RayMatrix, right:RayMatrix):RayMatrix;
    @:native('MatrixTranslate') static function matrixTranslate(x:Single, y:Single, z:Single):RayMatrix;
    @:native('MatrixRotate') static function matrixRotate(axis:RayVector3, angle:Single):RayMatrix;
    @:native('MatrixRotateX') static function matrixRotateX(angle:Single):RayMatrix;
    @:native('MatrixRotateY') static function matrixRotateY(angle:Single):RayMatrix;
    @:native('MatrixRotateZ') static function matrixRotateZ(angle:Single):RayMatrix;
    @:native('MatrixRotateXYZ') static function matrixRotateXYZ(angle:RayVector3):RayMatrix;
    @:native('MatrixRotateZYX') static function matrixRotateZYX(angle:RayVector3):RayMatrix;
    @:native('MatrixScale') static function matrixScale(x:Single, y:Single, z:Single):RayMatrix;
    @:native('MatrixFrustum') static function matrixFrustum(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float):RayMatrix;
    @:native('MatrixPerspective') static function matrixPerspective(fovY:Float, aspect:Float, nearPlane:Float, farPlane:Float):RayMatrix;
    @:native('MatrixOrtho') static function matrixOrtho(left:Float, right:Float, bottom:Float, top:Float, nearPlane:Float, farPlane:Float):RayMatrix;
    @:native('MatrixLookAt') static function matrixLookAt(eye:RayVector3, target:RayVector3, up:RayVector3):RayMatrix;
    @:native('MatrixToFloat') static function matrixToFloat(mat:RayMatrix):utils.FloatPointer;

    @:native('QuaternionAdd') static function quaternionAdd(q1:RayVector4, q2:RayVector4):RayVector4;
    @:native('QuaternionAddValue') static function quaternionAddValue(q:RayVector4, add:Single):RayVector4;
    @:native('QuaternionSubtract') static function quaternionSubtract(q1:RayVector4, q2:RayVector4):RayVector4;
    @:native('QuaternionSubtractValue') static function quaternionSubtractValue(q:RayVector4, sub:Single):RayVector4;
    @:native('QuaternionIdentity') static function quaternionIdentity():RayVector4;
    @:native('QuaternionLength') static function quaternionLength(q:RayVector4):Single;
    @:native('QuaternionNormalize') static function quaternionNormalize(q:RayVector4):RayVector4;
    @:native('QuaternionInvert') static function quaternionInvert(q:RayVector4):RayVector4;
    @:native('QuaternionMultiply') static function quaternionMultiply(q1:RayVector4, q2:RayVector4):RayVector4;
    @:native('QuaternionScale') static function quaternionScale(q:RayVector4, mul:Single):RayVector4;
    @:native('QuaternionDivide') static function quaternionDivide(q1:RayVector4, q2:RayVector4):RayVector4;
    @:native('QuaternionLerp') static function quaternionLerp(q1:RayVector4, q2:RayVector4, amount:Single):RayVector4;
    @:native('QuaternionNlerp') static function quaternionNlerp(q1:RayVector4, q2:RayVector4, amount:Single):RayVector4;
    @:native('QuaternionSlerp') static function quaternionSlerp(q1:RayVector4, q2:RayVector4, amount:Single):RayVector4;
    @:native('QuaternionFromVector3ToVector3') static function quaternionFromVector3ToVector3(from:RayVector3, to:RayVector3):RayVector4;
    @:native('QuaternionFromMatrix') static function quaternionFromMatrix(mat:RayMatrix):RayVector4;
    @:native('QuaternionToMatrix') static function quaternionToMatrix(q:RayVector4):RayMatrix;
    @:native('QuaternionFromAxisAngle') static function quaternionFromAxisAngle(axis:RayVector3, angle:Single):RayVector4;
    @:native('QuaternionToAxisAngle') static function quaternionToAxisAngle(q:RayVector4, outAxis:RayVector3, outAngle:Single):Void;
    @:native('QuaternionFromEuler') static function quaternionFromEuler(pitch:Single, yaw:Single, roll:Single):RayVector4;
    @:native('QuaternionToEuler') static function quaternionToEuler(q:RayVector4):RayVector3;
    @:native('QuaternionTransform') static function quaternionTransform(q:RayVector4, mat:RayMatrix):RayVector4;
    @:native('QuaternionEquals') static function quaternionEquals(p:RayVector4, q:RayVector4):Int;
}