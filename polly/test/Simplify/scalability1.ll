; RUN: opt %loadNPMPolly -polly-ignore-inbounds '-passes=print<polly-simplify>' -disable-output < %s | FileCheck %s -match-full-lines
;
; Test scalability.
;
define void @func(i32 %n, ptr noalias nonnull %A,
i32 %p0, i32 %p1, i32 %p2, i32 %p3, i32 %p4, i32 %p5, i32 %p6, i32 %p7, i32 %p8, i32 %p9,
i32 %p10, i32 %p11, i32 %p12, i32 %p13, i32 %p14, i32 %p15, i32 %p16, i32 %p17, i32 %p18, i32 %p19,
i32 %p20, i32 %p21, i32 %p22, i32 %p23, i32 %p24, i32 %p25, i32 %p26, i32 %p27, i32 %p28, i32 %p29,
i32 %p30, i32 %p31, i32 %p32) {
entry:
  br label %for

for:
  %j = phi i32 [0, %entry], [%j.inc, %inc]
  %j.cmp = icmp slt i32 %j, %n
  br i1 %j.cmp, label %body, label %exit


    body:
      %A0 = getelementptr inbounds double, ptr %A, i32 %p0
      %A1 = getelementptr inbounds double, ptr %A, i32 %p1
      %A2 = getelementptr inbounds double, ptr %A, i32 %p2
      %A3 = getelementptr inbounds double, ptr %A, i32 %p3
      %A4 = getelementptr inbounds double, ptr %A, i32 %p4
      %A5 = getelementptr inbounds double, ptr %A, i32 %p5
      %A6 = getelementptr inbounds double, ptr %A, i32 %p6
      %A7 = getelementptr inbounds double, ptr %A, i32 %p7
      %A8 = getelementptr inbounds double, ptr %A, i32 %p8
      %A9 = getelementptr inbounds double, ptr %A, i32 %p9
      %A10 = getelementptr inbounds double, ptr %A, i32 %p10
      %A11 = getelementptr inbounds double, ptr %A, i32 %p11
      %A12 = getelementptr inbounds double, ptr %A, i32 %p12
      %A13 = getelementptr inbounds double, ptr %A, i32 %p13
      %A14 = getelementptr inbounds double, ptr %A, i32 %p14
      %A15 = getelementptr inbounds double, ptr %A, i32 %p15
      %A16 = getelementptr inbounds double, ptr %A, i32 %p16
      %A17 = getelementptr inbounds double, ptr %A, i32 %p17
      %A18 = getelementptr inbounds double, ptr %A, i32 %p18
      %A19 = getelementptr inbounds double, ptr %A, i32 %p19
      %A20 = getelementptr inbounds double, ptr %A, i32 %p20
      %A21 = getelementptr inbounds double, ptr %A, i32 %p21
      %A22 = getelementptr inbounds double, ptr %A, i32 %p22
      %A23 = getelementptr inbounds double, ptr %A, i32 %p23
      %A24 = getelementptr inbounds double, ptr %A, i32 %p24
      %A25 = getelementptr inbounds double, ptr %A, i32 %p25
      %A26 = getelementptr inbounds double, ptr %A, i32 %p26
      %A27 = getelementptr inbounds double, ptr %A, i32 %p27
      %A28 = getelementptr inbounds double, ptr %A, i32 %p28
      %A29 = getelementptr inbounds double, ptr %A, i32 %p29
      %A30 = getelementptr inbounds double, ptr %A, i32 %p30
      %A31 = getelementptr inbounds double, ptr %A, i32 %p31
      %A32 = getelementptr inbounds double, ptr %A, i32 %p32

      %val = load double, ptr %A0

      store double %val, ptr %A1
      store double %val, ptr %A2
      store double %val, ptr %A3
      store double %val, ptr %A4
      store double %val, ptr %A5
      store double %val, ptr %A6
      store double %val, ptr %A7
      store double %val, ptr %A8
      store double %val, ptr %A9
      store double %val, ptr %A10
      store double %val, ptr %A11
      store double %val, ptr %A12
      store double %val, ptr %A13
      store double %val, ptr %A14
      store double %val, ptr %A15
      store double %val, ptr %A16
      store double %val, ptr %A17
      store double %val, ptr %A18
      store double %val, ptr %A19
      store double %val, ptr %A20
      store double %val, ptr %A21
      store double %val, ptr %A22
      store double %val, ptr %A23
      store double %val, ptr %A24
      store double %val, ptr %A25
      store double %val, ptr %A26
      store double %val, ptr %A27
      store double %val, ptr %A28
      store double %val, ptr %A29
      store double %val, ptr %A30
      store double %val, ptr %A31
      store double %val, ptr %A32

      br label %inc


inc:
  %j.inc = add nuw nsw i32 %j, 1
  br label %for

exit:
  br label %return

return:
  ret void
}


; CHECK: SCoP could not be simplified
