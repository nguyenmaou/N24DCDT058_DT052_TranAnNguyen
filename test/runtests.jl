using Test
include(joinpath(@__DIR__, "..", "src", "DeTai.jl"))
using .DeTai

@testset "DT052 - 12 ca chuc nang" begin
    # T01: ví dụ 1 trên phiếu; kiểm tra bảng, độ dài và các ký tự BCBA.
    kq = giai_bai("ABCBDAB", "BDCABA")
    @test kq.do_dai == 4
    @test kq.day in ["BCBA", "BDAB", "BCAB"]
    @test kq.so_o_tinh == 42
    @test kq.so_buoc_truy_vet == 8
    @test la_day_con(kq.day, "ABCBDAB")
    @test la_day_con(kq.day, "BDCABA")
    @test lcs_hai_hang("ABCBDAB", "BDCABA") == 4

    # T02: ví dụ 2 trên phiếu (câu 23 cuối chương 4 giáo trình).
    kq = giai_bai("AGGTAB", "GXTXAYB")
    @test kq.do_dai == 4
    @test kq.day == "GTAB"
    @test kq.so_o_tinh == 42
    @test kq.so_buoc_truy_vet == 8
    @test la_day_con(kq.day, "AGGTAB")
    @test la_day_con(kq.day, "GXTXAYB")
    @test lcs_hai_hang("AGGTAB", "GXTXAYB") == 4

    # T03: ca 1 phiếu: Xâu X rỗng; không đọc tràn mảng.
    kq = giai_bai("", "ABC")
    @test kq.do_dai == 0
    @test isempty(kq.day)
    @test kq.so_o_tinh == 0
    @test kq.so_buoc_truy_vet == 0

    # T04: ca 2 phiếu: hai xâu giống nhau hoàn toàn; đi theo đường chéo.
    kq = giai_bai("ABC", "ABC")
    @test kq.do_dai == 3
    @test kq.day == "ABC"
    @test kq.so_buoc_truy_vet == 3

    # T05: ca 3 phiếu: hai xâu rời nhau, không có ký tự chung; bảng toàn 0.
    kq = giai_bai("ABC", "DEF")
    @test kq.do_dai == 0
    @test isempty(kq.day)
    @test all(kq.bang .== 0)

    # T06: ca 4 phiếu: ký tự lặp; không dùng quá số ký tự có sẵn của Y.
    kq = giai_bai("AAAA", "AA")
    @test kq.do_dai == 2
    @test kq.day == "AA"

    # T07: ca 5 phiếu: hai xâu đảo ngược; một trong A hoặc B đều đúng.
    kq = giai_bai("AB", "BA")
    @test kq.do_dai == 1
    @test kq.day in ["A", "B"]

    # T08: biên nhỏ nhất: cả hai xâu đều rỗng.
    kq = giai_bai("", "")
    @test kq.do_dai == 0
    @test isempty(kq.day)
    @test kq.so_o_tinh == 0
    @test kq.so_buoc_truy_vet == 0

    # T09: biên một ký tự; khớp và không khớp.
    kq1 = giai_bai("X", "X")
    kq2 = giai_bai("X", "Y")
    @test kq1.do_dai == 1 && kq1.day == "X"
    @test kq2.do_dai == 0 && isempty(kq2.day)

    # T10: tự thiết kế 1: phân biệt nghiêm ngặt chữ hoa và thường (case-sensitive).
    kq = giai_bai("AbCd", "aBcD")
    @test kq.do_dai == 0
    @test isempty(kq.day)

    # T11: tự thiết kế 2: cặp xâu kinh điển giáo trình CLRS.
    kq = giai_bai("XMJYAUZ", "MZJAWXU")
    @test kq.do_dai == 4
    @test kq.day == "MJAU"
    @test la_day_con(kq.day, "XMJYAUZ")
    @test la_day_con(kq.day, "MZJAWXU")

    # T12: biên trên n=100 ký tự; bảng 101x101 và bộ nhớ đáp ứng đủ.
    X100 = repeat("A", 100)
    Y100 = repeat("A", 100)
    kq = giai_bai(X100, Y100)
    @test kq.do_dai == 100
    @test kq.day == X100
    @test kq.so_o_tinh == 10000
    @test kq.so_buoc_truy_vet == 100
    @test lcs_hai_hang(X100, Y100) == 100
end

@testset "Du lieu vao va ham kiem tra" begin
    @test_throws ArgumentError kiem_tra_dau_vao(repeat("A", 101), "ABC")      # V01
    @test_throws ArgumentError kiem_tra_dau_vao("ABC", repeat("A", 101))      # V02
    @test_throws ArgumentError kiem_tra_dau_vao("ABC123", "XYZ")              # V03
    @test_throws ArgumentError kiem_tra_dau_vao("ABC@", "XYZ")                # V04
    @test_throws ArgumentError kiem_tra_dau_vao("A B", "XYZ")                 # V05
    @test_throws ArgumentError kiem_tra_dau_vao("Trần", "Nguyen")             # V06
    @test_throws ArgumentError giai_bai("ABC")                                # V07
    @test_throws ArgumentError giai_bai((123, 456))                           # V08
    @test !la_day_con("ABC", "AC")                                            # V09
    @test la_day_con("", "ABC")                                               # V10
    @test la_day_con("ABC", "ABC")                                            # V11
    @test !la_day_con("ABCD", "ABC")                                          # V12
end

println("DA QUA 12 CA CHUC NANG VA CAC KIEM TRA DU LIEU VAO.")
