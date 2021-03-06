; RUN: llc < %s | FileCheck %s

target datalayout = "e-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-p:32:32:32-v128:32:128-n32-S128"
target triple = "asmjs-unknown-emscripten"

; CHECK: function _fx1($p) {
; CHECK:  $p = $p|0;
; CHECK:  var $q = 0, $s = SIMD_float32x4(0,0,0,0), $t = SIMD_float32x4(0,0,0,0)
; CHECK:  $t = SIMD_float32x4_loadX(HEAPU8, $p);
; CHECK:  $s = SIMD_float32x4_add($t,SIMD_float32x4(Math_fround(+0.5),Math_fround(+0),Math_fround(+0),Math_fround(+0)));
; CHECK:  $q = $p;SIMD_float32x4_storeX(HEAPU8, $q, $s);
; CHECK:  return;
; CHECK: }
define void @fx1(i8* %p) {
    %q = bitcast i8* %p to <1 x float>*
    %t = load <1 x float>* %q
    %s = fadd <1 x float> %t, <float 0.5>
    store <1 x float> %s, <1 x float>* %q
    ret void
}

; CHECK: function _fx2($p) {
; CHECK:  $p = $p|0;
; CHECK:  var $q = 0, $s = SIMD_float32x4(0,0,0,0), $t = SIMD_float32x4(0,0,0,0)
; CHECK:  $t = SIMD_float32x4_loadXY(HEAPU8, $p);
; CHECK:  $s = SIMD_float32x4_add($t,SIMD_float32x4(Math_fround(+3.5),Math_fround(+7.5),Math_fround(+0),Math_fround(+0)));
; CHECK:  $q = $p;SIMD_float32x4_storeXY(HEAPU8, $q, $s);
; CHECK:  return;
; CHECK: }
define void @fx2(i8* %p) {
    %q = bitcast i8* %p to <2 x float>*
    %t = load <2 x float>* %q
    %s = fadd <2 x float> %t, <float 3.5, float 7.5>
    store <2 x float> %s, <2 x float>* %q
    ret void
}

; CHECK: function _fx3($p) {
; CHECK:  $p = $p|0;
; CHECK:  var $q = 0, $s = SIMD_float32x4(0,0,0,0), $t = SIMD_float32x4(0,0,0,0)
; CHECK:  $t = SIMD_float32x4_loadXYZ(HEAPU8, $p);
; CHECK:  $s = SIMD_float32x4_add($t,SIMD_float32x4(Math_fround(+1.5),Math_fround(+4.5),Math_fround(+6.5),Math_fround(+0)));
; CHECK:  $q = $p;SIMD_float32x4_storeXYZ(HEAPU8, $q, $s);
; CHECK:  return;
; CHECK: }
define void @fx3(i8* %p) {
    %q = bitcast i8* %p to <3 x float>*
    %t = load <3 x float>* %q
    %s = fadd <3 x float> %t, <float 1.5, float 4.5, float 6.5>
    store <3 x float> %s, <3 x float>* %q
    ret void
}

; CHECK: function _fx4($p) {
; CHECK:  $p = $p|0;
; CHECK:  var $q = 0, $s = SIMD_float32x4(0,0,0,0), $t = SIMD_float32x4(0,0,0,0)
; CHECK:  $t = SIMD_float32x4_load(HEAPU8, $p);
; CHECK:  $s = SIMD_float32x4_add($t,SIMD_float32x4(Math_fround(+9.5),Math_fround(+5.5),Math_fround(+1.5),Math_fround(+-3.5)));
; CHECK:  $q = $p;SIMD_float32x4_store(HEAPU8, $q, $s);
; CHECK:  return;
; CHECK: }
define void @fx4(i8* %p) {
    %q = bitcast i8* %p to <4 x float>*
    %t = load <4 x float>* %q
    %s = fadd <4 x float> %t, <float 9.5, float 5.5, float 1.5, float -3.5>
    store <4 x float> %s, <4 x float>* %q
    ret void
}
