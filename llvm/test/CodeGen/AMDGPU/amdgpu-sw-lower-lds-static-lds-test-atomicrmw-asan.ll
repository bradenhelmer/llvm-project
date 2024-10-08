; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals all --version 4
; RUN: opt < %s -passes=amdgpu-sw-lower-lds -S -mtriple=amdgcn-amd-amdhsa | FileCheck %s

@lds_1 = internal addrspace(3) global [1 x i32] poison, align 4
@lds_2 = internal addrspace(3) global [1 x i32] poison, align 4

; Test to check if static LDS accesses in kernel are lowered correctly.
;.
; CHECK: @llvm.amdgcn.sw.lds.atomicrmw_kernel = internal addrspace(3) global ptr poison, no_sanitize_address, align 4, !absolute_symbol [[META0:![0-9]+]]
; CHECK: @llvm.amdgcn.sw.lds.atomicrmw_kernel.md = internal addrspace(1) global %llvm.amdgcn.sw.lds.atomicrmw_kernel.md.type { %llvm.amdgcn.sw.lds.atomicrmw_kernel.md.item { i32 0, i32 8, i32 32 }, %llvm.amdgcn.sw.lds.atomicrmw_kernel.md.item { i32 32, i32 4, i32 32 }, %llvm.amdgcn.sw.lds.atomicrmw_kernel.md.item { i32 64, i32 4, i32 32 } }, no_sanitize_address
;.
define amdgpu_kernel void @atomicrmw_kernel(ptr addrspace(1) %arg0) sanitize_address {
; CHECK-LABEL: define amdgpu_kernel void @atomicrmw_kernel(
; CHECK-SAME: ptr addrspace(1) [[ARG0:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  WId:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; CHECK-NEXT:    [[TMP26:%.*]] = call i32 @llvm.amdgcn.workitem.id.y()
; CHECK-NEXT:    [[TMP45:%.*]] = call i32 @llvm.amdgcn.workitem.id.z()
; CHECK-NEXT:    [[TMP64:%.*]] = or i32 [[TMP0]], [[TMP26]]
; CHECK-NEXT:    [[TMP65:%.*]] = or i32 [[TMP64]], [[TMP45]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[TMP65]], 0
; CHECK-NEXT:    br i1 [[TMP5]], label [[MALLOC:%.*]], label [[TMP20:%.*]]
; CHECK:       Malloc:
; CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_ATOMICRMW_KERNEL_MD_TYPE:%.*]], ptr addrspace(1) @llvm.amdgcn.sw.lds.atomicrmw_kernel.md, i32 0, i32 2, i32 0), align 4
; CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_ATOMICRMW_KERNEL_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.atomicrmw_kernel.md, i32 0, i32 2, i32 2), align 4
; CHECK-NEXT:    [[TMP8:%.*]] = add i32 [[TMP6]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = zext i32 [[TMP8]] to i64
; CHECK-NEXT:    [[TMP10:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP11:%.*]] = ptrtoint ptr [[TMP10]] to i64
; CHECK-NEXT:    [[TMP12:%.*]] = call i64 @__asan_malloc_impl(i64 [[TMP9]], i64 [[TMP11]])
; CHECK-NEXT:    [[TMP13:%.*]] = inttoptr i64 [[TMP12]] to ptr addrspace(1)
; CHECK-NEXT:    store ptr addrspace(1) [[TMP13]], ptr addrspace(3) @llvm.amdgcn.sw.lds.atomicrmw_kernel, align 8
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP13]], i64 8
; CHECK-NEXT:    [[TMP15:%.*]] = ptrtoint ptr addrspace(1) [[TMP14]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP15]], i64 24)
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP13]], i64 36
; CHECK-NEXT:    [[TMP17:%.*]] = ptrtoint ptr addrspace(1) [[TMP16]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP17]], i64 28)
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP13]], i64 68
; CHECK-NEXT:    [[TMP19:%.*]] = ptrtoint ptr addrspace(1) [[TMP18]] to i64
; CHECK-NEXT:    call void @__asan_poison_region(i64 [[TMP19]], i64 28)
; CHECK-NEXT:    br label [[TMP20]]
; CHECK:       20:
; CHECK-NEXT:    [[XYZCOND:%.*]] = phi i1 [ false, [[WID:%.*]] ], [ true, [[MALLOC]] ]
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    [[TMP21:%.*]] = load ptr addrspace(1), ptr addrspace(3) @llvm.amdgcn.sw.lds.atomicrmw_kernel, align 8
; CHECK-NEXT:    [[TMP22:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_ATOMICRMW_KERNEL_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.atomicrmw_kernel.md, i32 0, i32 1, i32 0), align 4
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.atomicrmw_kernel, i32 [[TMP22]]
; CHECK-NEXT:    [[TMP24:%.*]] = load i32, ptr addrspace(1) getelementptr inbounds ([[LLVM_AMDGCN_SW_LDS_ATOMICRMW_KERNEL_MD_TYPE]], ptr addrspace(1) @llvm.amdgcn.sw.lds.atomicrmw_kernel.md, i32 0, i32 2, i32 0), align 4
; CHECK-NEXT:    [[TMP25:%.*]] = getelementptr inbounds i8, ptr addrspace(3) @llvm.amdgcn.sw.lds.atomicrmw_kernel, i32 [[TMP24]]
; CHECK-NEXT:    [[TMP1:%.*]] = load volatile i32, ptr addrspace(1) [[ARG0]], align 4
; CHECK-NEXT:    [[TMP27:%.*]] = ptrtoint ptr addrspace(3) [[TMP23]] to i32
; CHECK-NEXT:    [[TMP28:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP21]], i32 [[TMP27]]
; CHECK-NEXT:    [[TMP29:%.*]] = ptrtoint ptr addrspace(1) [[TMP28]] to i64
; CHECK-NEXT:    [[TMP35:%.*]] = add i64 [[TMP29]], 3
; CHECK-NEXT:    [[TMP98:%.*]] = inttoptr i64 [[TMP35]] to ptr addrspace(1)
; CHECK-NEXT:    [[TMP99:%.*]] = ptrtoint ptr addrspace(1) [[TMP28]] to i64
; CHECK-NEXT:    [[TMP30:%.*]] = lshr i64 [[TMP99]], 3
; CHECK-NEXT:    [[TMP31:%.*]] = add i64 [[TMP30]], 2147450880
; CHECK-NEXT:    [[TMP32:%.*]] = inttoptr i64 [[TMP31]] to ptr
; CHECK-NEXT:    [[TMP33:%.*]] = load i8, ptr [[TMP32]], align 1
; CHECK-NEXT:    [[TMP34:%.*]] = icmp ne i8 [[TMP33]], 0
; CHECK-NEXT:    [[TMP36:%.*]] = and i64 [[TMP99]], 7
; CHECK-NEXT:    [[TMP37:%.*]] = trunc i64 [[TMP36]] to i8
; CHECK-NEXT:    [[TMP38:%.*]] = icmp sge i8 [[TMP37]], [[TMP33]]
; CHECK-NEXT:    [[TMP39:%.*]] = and i1 [[TMP34]], [[TMP38]]
; CHECK-NEXT:    [[TMP40:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP39]])
; CHECK-NEXT:    [[TMP41:%.*]] = icmp ne i64 [[TMP40]], 0
; CHECK-NEXT:    br i1 [[TMP41]], label [[ASAN_REPORT:%.*]], label [[TMP44:%.*]], !prof [[PROF2:![0-9]+]]
; CHECK:       asan.report:
; CHECK-NEXT:    br i1 [[TMP39]], label [[TMP42:%.*]], label [[TMP43:%.*]]
; CHECK:       44:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP99]]) #[[ATTR6:[0-9]+]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP43]]
; CHECK:       45:
; CHECK-NEXT:    br label [[TMP44]]
; CHECK:       46:
; CHECK-NEXT:    [[TMP100:%.*]] = ptrtoint ptr addrspace(1) [[TMP98]] to i64
; CHECK-NEXT:    [[TMP101:%.*]] = lshr i64 [[TMP100]], 3
; CHECK-NEXT:    [[TMP102:%.*]] = add i64 [[TMP101]], 2147450880
; CHECK-NEXT:    [[TMP103:%.*]] = inttoptr i64 [[TMP102]] to ptr
; CHECK-NEXT:    [[TMP104:%.*]] = load i8, ptr [[TMP103]], align 1
; CHECK-NEXT:    [[TMP105:%.*]] = icmp ne i8 [[TMP104]], 0
; CHECK-NEXT:    [[TMP106:%.*]] = and i64 [[TMP100]], 7
; CHECK-NEXT:    [[TMP54:%.*]] = trunc i64 [[TMP106]] to i8
; CHECK-NEXT:    [[TMP107:%.*]] = icmp sge i8 [[TMP54]], [[TMP104]]
; CHECK-NEXT:    [[TMP108:%.*]] = and i1 [[TMP105]], [[TMP107]]
; CHECK-NEXT:    [[TMP109:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP108]])
; CHECK-NEXT:    [[TMP110:%.*]] = icmp ne i64 [[TMP109]], 0
; CHECK-NEXT:    br i1 [[TMP110]], label [[ASAN_REPORT1:%.*]], label [[TMP111:%.*]], !prof [[PROF2]]
; CHECK:       asan.report1:
; CHECK-NEXT:    br i1 [[TMP108]], label [[TMP112:%.*]], label [[TMP113:%.*]]
; CHECK:       59:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP100]]) #[[ATTR6]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP113]]
; CHECK:       60:
; CHECK-NEXT:    br label [[TMP111]]
; CHECK:       61:
; CHECK-NEXT:    [[TMP2:%.*]] = atomicrmw umin ptr addrspace(1) [[TMP28]], i32 [[TMP1]] seq_cst, align 4
; CHECK-NEXT:    [[TMP46:%.*]] = ptrtoint ptr addrspace(3) [[TMP23]] to i32
; CHECK-NEXT:    [[TMP47:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP21]], i32 [[TMP46]]
; CHECK-NEXT:    [[TMP48:%.*]] = ptrtoint ptr addrspace(1) [[TMP47]] to i64
; CHECK-NEXT:    [[TMP114:%.*]] = add i64 [[TMP48]], 3
; CHECK-NEXT:    [[TMP115:%.*]] = inttoptr i64 [[TMP114]] to ptr addrspace(1)
; CHECK-NEXT:    [[TMP116:%.*]] = ptrtoint ptr addrspace(1) [[TMP47]] to i64
; CHECK-NEXT:    [[TMP49:%.*]] = lshr i64 [[TMP116]], 3
; CHECK-NEXT:    [[TMP50:%.*]] = add i64 [[TMP49]], 2147450880
; CHECK-NEXT:    [[TMP51:%.*]] = inttoptr i64 [[TMP50]] to ptr
; CHECK-NEXT:    [[TMP52:%.*]] = load i8, ptr [[TMP51]], align 1
; CHECK-NEXT:    [[TMP53:%.*]] = icmp ne i8 [[TMP52]], 0
; CHECK-NEXT:    [[TMP55:%.*]] = and i64 [[TMP116]], 7
; CHECK-NEXT:    [[TMP56:%.*]] = trunc i64 [[TMP55]] to i8
; CHECK-NEXT:    [[TMP57:%.*]] = icmp sge i8 [[TMP56]], [[TMP52]]
; CHECK-NEXT:    [[TMP58:%.*]] = and i1 [[TMP53]], [[TMP57]]
; CHECK-NEXT:    [[TMP59:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP58]])
; CHECK-NEXT:    [[TMP60:%.*]] = icmp ne i64 [[TMP59]], 0
; CHECK-NEXT:    br i1 [[TMP60]], label [[ASAN_REPORT2:%.*]], label [[TMP63:%.*]], !prof [[PROF2]]
; CHECK:       asan.report2:
; CHECK-NEXT:    br i1 [[TMP58]], label [[TMP61:%.*]], label [[TMP62:%.*]]
; CHECK:       80:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP116]]) #[[ATTR6]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP62]]
; CHECK:       81:
; CHECK-NEXT:    br label [[TMP63]]
; CHECK:       82:
; CHECK-NEXT:    [[TMP117:%.*]] = ptrtoint ptr addrspace(1) [[TMP115]] to i64
; CHECK-NEXT:    [[TMP118:%.*]] = lshr i64 [[TMP117]], 3
; CHECK-NEXT:    [[TMP119:%.*]] = add i64 [[TMP118]], 2147450880
; CHECK-NEXT:    [[TMP120:%.*]] = inttoptr i64 [[TMP119]] to ptr
; CHECK-NEXT:    [[TMP87:%.*]] = load i8, ptr [[TMP120]], align 1
; CHECK-NEXT:    [[TMP88:%.*]] = icmp ne i8 [[TMP87]], 0
; CHECK-NEXT:    [[TMP89:%.*]] = and i64 [[TMP117]], 7
; CHECK-NEXT:    [[TMP90:%.*]] = trunc i64 [[TMP89]] to i8
; CHECK-NEXT:    [[TMP91:%.*]] = icmp sge i8 [[TMP90]], [[TMP87]]
; CHECK-NEXT:    [[TMP92:%.*]] = and i1 [[TMP88]], [[TMP91]]
; CHECK-NEXT:    [[TMP93:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP92]])
; CHECK-NEXT:    [[TMP94:%.*]] = icmp ne i64 [[TMP93]], 0
; CHECK-NEXT:    br i1 [[TMP94]], label [[ASAN_REPORT3:%.*]], label [[TMP97:%.*]], !prof [[PROF2]]
; CHECK:       asan.report3:
; CHECK-NEXT:    br i1 [[TMP92]], label [[TMP95:%.*]], label [[TMP96:%.*]]
; CHECK:       95:
; CHECK-NEXT:    call void @__asan_report_store1(i64 [[TMP117]]) #[[ATTR6]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP96]]
; CHECK:       96:
; CHECK-NEXT:    br label [[TMP97]]
; CHECK:       97:
; CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw umax ptr addrspace(1) [[TMP47]], i32 [[TMP1]] seq_cst, align 4
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    [[TMP66:%.*]] = ptrtoint ptr addrspace(3) [[TMP25]] to i32
; CHECK-NEXT:    [[TMP67:%.*]] = getelementptr inbounds i8, ptr addrspace(1) [[TMP21]], i32 [[TMP66]]
; CHECK-NEXT:    [[TMP68:%.*]] = ptrtoint ptr addrspace(1) [[TMP67]] to i64
; CHECK-NEXT:    [[TMP69:%.*]] = lshr i64 [[TMP68]], 3
; CHECK-NEXT:    [[TMP70:%.*]] = add i64 [[TMP69]], 2147450880
; CHECK-NEXT:    [[TMP71:%.*]] = inttoptr i64 [[TMP70]] to ptr
; CHECK-NEXT:    [[TMP72:%.*]] = load i8, ptr [[TMP71]], align 1
; CHECK-NEXT:    [[TMP73:%.*]] = icmp ne i8 [[TMP72]], 0
; CHECK-NEXT:    [[TMP74:%.*]] = and i64 [[TMP68]], 7
; CHECK-NEXT:    [[TMP75:%.*]] = add i64 [[TMP74]], 3
; CHECK-NEXT:    [[TMP76:%.*]] = trunc i64 [[TMP75]] to i8
; CHECK-NEXT:    [[TMP77:%.*]] = icmp sge i8 [[TMP76]], [[TMP72]]
; CHECK-NEXT:    [[TMP78:%.*]] = and i1 [[TMP73]], [[TMP77]]
; CHECK-NEXT:    [[TMP79:%.*]] = call i64 @llvm.amdgcn.ballot.i64(i1 [[TMP78]])
; CHECK-NEXT:    [[TMP80:%.*]] = icmp ne i64 [[TMP79]], 0
; CHECK-NEXT:    br i1 [[TMP80]], label [[ASAN_REPORT4:%.*]], label [[TMP83:%.*]], !prof [[PROF2]]
; CHECK:       asan.report4:
; CHECK-NEXT:    br i1 [[TMP78]], label [[TMP81:%.*]], label [[TMP82:%.*]]
; CHECK:       115:
; CHECK-NEXT:    call void @__asan_report_store4(i64 [[TMP68]]) #[[ATTR6]]
; CHECK-NEXT:    call void @llvm.amdgcn.unreachable()
; CHECK-NEXT:    br label [[TMP82]]
; CHECK:       116:
; CHECK-NEXT:    br label [[TMP83]]
; CHECK:       117:
; CHECK-NEXT:    store i32 [[TMP4]], ptr addrspace(1) [[TMP67]], align 4
; CHECK-NEXT:    br label [[CONDFREE:%.*]]
; CHECK:       CondFree:
; CHECK-NEXT:    call void @llvm.amdgcn.s.barrier()
; CHECK-NEXT:    br i1 [[XYZCOND]], label [[FREE:%.*]], label [[END:%.*]]
; CHECK:       Free:
; CHECK-NEXT:    [[TMP84:%.*]] = call ptr @llvm.returnaddress(i32 0)
; CHECK-NEXT:    [[TMP85:%.*]] = ptrtoint ptr [[TMP84]] to i64
; CHECK-NEXT:    [[TMP86:%.*]] = ptrtoint ptr addrspace(1) [[TMP21]] to i64
; CHECK-NEXT:    call void @__asan_free_impl(i64 [[TMP86]], i64 [[TMP85]])
; CHECK-NEXT:    br label [[END]]
; CHECK:       End:
; CHECK-NEXT:    ret void
;
  %1 = load volatile i32, ptr addrspace(1) %arg0
  %2 = atomicrmw umin ptr addrspace(3) @lds_1, i32 %1 seq_cst
  %3 = atomicrmw umax ptr addrspace(3) @lds_1, i32 %1 seq_cst
  %4 = add i32 %2, %3
  store i32 %4, ptr addrspace(3) @lds_2, align 4
  ret void
}
!llvm.module.flags = !{!0}
!0 = !{i32 4, !"nosanitize_address", i32 1}

;.
; CHECK: attributes #[[ATTR0]] = { sanitize_address "amdgpu-lds-size"="8" }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { nocallback nofree nosync nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR3:[0-9]+]] = { convergent nocallback nofree nounwind willreturn }
; CHECK: attributes #[[ATTR4:[0-9]+]] = { convergent nocallback nofree nounwind willreturn memory(none) }
; CHECK: attributes #[[ATTR5:[0-9]+]] = { convergent nocallback nofree nounwind }
; CHECK: attributes #[[ATTR6]] = { nomerge }
;.
; CHECK: [[META0]] = !{i32 0, i32 1}
; CHECK: [[META1:![0-9]+]] = !{i32 4, !"nosanitize_address", i32 1}
; CHECK: [[PROF2]] = !{!"branch_weights", i32 1, i32 1048575}
;.
