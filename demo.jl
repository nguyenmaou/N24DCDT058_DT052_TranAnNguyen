include(joinpath(@__DIR__, "src", "DeTai.jl"))
using .DeTai
using Printf

function in_ket_qua(X, Y)
    kq = giai_bai(X, Y)
    println("DT052 - TIM DAY KY TU CHUNG DAI NHAT (LCS)")
    println("X=\"$X\"; Y=\"$Y\"")
    println("Bang quy hoach dong va truy vet tu goc cuoi ve (0, 0).")
    if length(X) <= 15 && length(Y) <= 15
        in_bang_lcs(X, Y, kq.bang)
    end
    println("Do dai LCS: ", kq.do_dai)
    println("Day ky tu chung: \"", kq.day, "\"")
    println("Kiem day con tren X va Y: ", (la_day_con(kq.day, X) && la_day_con(kq.day, Y)) ? "DUNG" : "SAI")
    println("So o bang da tinh: ", kq.so_o_tinh)
    println("So buoc khi truy vet: ", kq.so_buoc_truy_vet)
    println("Do dai ban 2 hang (doi chieu): ", lcs_hai_hang(X, Y))
    return kq
end

function nhap_ban_phim()
    println("Nhap xau X (chu cai Latin khong dau, toi da 100 ky tu):")
    X = strip(readline())
    println("Nhap xau Y (chu cai Latin khong dau, toi da 100 ky tu):")
    Y = strip(readline())
    in_ket_qua(String(X), String(Y))
end

function minh_hoa_du_lieu_sai()
    println("DT052 - MINH HOA TU CHOI DU LIEU KHONG HOP LE")
    println("X=\"ABC123\"; Y=\"XYZ\"")
    println("Mong doi: xau X chua ky tu so '1', validator tu choi.")
    try
        giai_bai("ABC123", "XYZ")
    catch loi
        if loi isa ArgumentError && occursin("khong hop le", sprint(showerror, loi))
            println("DA TU CHOI DU LIEU: ", sprint(showerror, loi))
            println("KET QUA MINH HOA: DUNG; loi du kien da duoc bat.")
            println("Ma thoat 0 chi danh cho demo bat loi dung nhu mong doi.")
            return nothing
        end
        rethrow()
    end
    error("LOI: chuong trinh da chap nhan ky tu khong hop le")
end

if "--nhap" in ARGS
    nhap_ban_phim()
elseif any(startswith("--ca="), ARGS)
    ca = only(filter(startswith("--ca="), ARGS))
    if ca == "--ca=1"
        in_ket_qua("ABCBDAB", "BDCABA")
    elseif ca == "--ca=2"
        in_ket_qua("AGGTAB", "GXTXAYB")
    elseif ca == "--ca=3"
        in_ket_qua("AbCd", "aBcD")
    elseif ca == "--ca=4"
        in_ket_qua("XMJYAUZ", "MZJAWXU")
    elseif ca == "--ca=5"
        in_ket_qua("", "ABC")
    elseif ca == "--ca=6"
        in_ket_qua("ABC", "ABC")
    elseif ca == "--ca=7"
        in_ket_qua("ABC", "DEF")
    elseif ca == "--ca=8"
        minh_hoa_du_lieu_sai()
    else
        throw(ArgumentError("chon --ca=1 den --ca=8"))
    end
else
    # Hai ví dụ đúng như phiếu DT052. Có thể sửa trực tiếp các biến này.
    in_ket_qua("ABCBDAB", "BDCABA")
    println("\n--- VI DU 2: TREN PHIEU GIAO (CAU 23) ---")
    in_ket_qua("AGGTAB", "GXTXAYB")
end
