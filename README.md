# DT052 Tìm dãy ký tự chung dài nhất của hai xâu (LCS)

Bản giải hoàn chỉnh cho đề tài cá nhân môn học Cấu trúc dữ liệu và giải thuật (INT13185 nhóm 03).
Sinh viên thực hiện: Trần An Nguyên — MSSV: N24DCDT058 — Lớp: D24CQDT01-N.
Giảng viên hướng dẫn: ThS. Hồ Nhựt Minh.
Tham chiếu giáo trình INT1306, Chương 4, mục 4.3.3.1, trang in 100–103, Ví dụ 4.9, Bài 4.3, Bài tập 23 trang in 112.

## Bắt đầu

Cài Julia; bản này được kiểm tra trên Julia 1.12.7. Chỉ dùng thư viện chuẩn.
Từ thư mục mã nguồn `N24DCDT058_DT052_TranAnNguyen`, mở PowerShell và chạy:

```powershell
.\Run_all.ps1
```

Nếu Julia chưa có trên PATH, truyền đường dẫn tới julia.exe:

```powershell
.\Run_all.ps1 -Julia 'DUONG_DAN_DEN_JULIA_EXE'
```

Tệp Run_all.ps1 tự động chạy lần lượt các ca demo 1..8 và bộ kiểm thử, dừng ngay nếu có lệnh trả mã lỗi:

```powershell
julia --startup-file=no demo.jl --ca=1
# Thay 1 bằng 2..8 để xem từng ca tương ứng với kế hoạch ảnh A01..A08
julia --startup-file=no test/runtests.jl
julia --startup-file=no demo.jl --nhap
```

Nhập bàn phím tương tác: chạy `julia --startup-file=no demo.jl --nhap`, chương trình sẽ hỏi xâu X và xâu Y rồi in bảng quy hoạch động và dãy con chung.

## Hợp đồng bài toán

- Hai xâu ký tự X, Y chỉ gồm chữ cái Latin không dấu (A-Z, a-z), phân biệt chữ hoa và thường.
- Chiều dài mỗi xâu trong miền 0≤|X|, |Y|≤100; dữ liệu vi phạm bị từ chối qua ArgumentError.
- Bảng quy hoạch động f kích thước (m+1) x (n+1); hàng 1 và cột 1 ứng với xâu rỗng (bằng 0).
- Truy vết từ góc cuối (m, n) về (0, 0), chọn đi chéo khi ký tự trùng, đi ô lớn hơn khi khác nhau; đảo ngược chuỗi để có kết quả từ trái sang phải.
- Kiểm tra độc lập dãy con bằng hàm hai con trỏ `la_day_con(day, xâu)`.
- Hai lời gọi trên cùng dữ liệu luôn bắt đầu từ trạng thái mới, không phụ thuộc bộ nhớ đệm hay tệp ngoài.

## Các phần đã giải

| Tệp | Vai trò |
|---|---|
| `src/DeTai.jl` | Hợp đồng kiểm tra input, bảng quy hoạch động, truy vết, kiểm dãy con, bản 2 hàng |
| `demo.jl` | 8 ca demo minh họa (A01..A08) và chế độ nhập bàn phím tương tác |
| `test/runtests.jl` | 12 ca chức năng có mã T01..T12 và 12 ca kiểm tra dữ liệu vào V01..V12 (57 assert) |
| `Run_all.ps1` | Chạy toàn bộ 8 demo và bộ kiểm thử tự động bằng một lệnh duy nhất |
| `docs/anh_ket_qua/` | Thư mục lưu trữ 11 ảnh thực nghiệm A01..A11 phục vụ báo cáo |

- **Demo 1:** Ví dụ 1 phiếu giao (X="ABCBDAB", Y="BDCABA" → do_dai=4, day="BCBA").
- **Demo 2:** Ví dụ 2 phiếu giao / Câu 23 giáo trình (X="AGGTAB", Y="GXTXAYB" → do_dai=4, day="GTAB").
- **Demo 3:** Tự thiết kế 1: phân biệt nghiêm ngặt chữ hoa và thường (X="AbCd", Y="aBcD" → do_dai=0).
- **Demo 4:** Tự thiết kế 2: cặp xâu kinh điển CLRS (X="XMJYAUZ", Y="MZJAWXU" → do_dai=4, day="MJAU").
- **Demo 5:** Biên 1: xâu X rỗng (X="", Y="ABC" → do_dai=0).
- **Demo 6:** Biên 2: hai xâu trùng nhau hoàn toàn (X=Y="ABC" → do_dai=3, day="ABC").
- **Demo 7:** Biên 3: hai xâu rời nhau không ký tự chung (X="ABC", Y="DEF" → do_dai=0).
- **Demo 8:** Minh họa từ chối dữ liệu sai: bắt ArgumentError dự kiến và thoát mã 0 theo chuẩn bài mẫu.

## Lập luận và kiểm chứng

Quy hoạch động xét bài toán con trên tiền tố. Đặt f[i, j] là độ dài LCS của i ký tự đầu X và j ký tự đầu Y.
- Nếu X[i] == Y[j]: ký tự này chắc chắn thuộc dãy con chung tối ưu mở rộng từ f[i-1, j-1], do đó f[i, j] = f[i-1, j-1] + 1.
- Nếu X[i] != Y[j]: ký tự chung không thể đồng thời kết thúc tại cả X[i] và Y[j], ta lấy f[i, j] = max(f[i-1, j], f[i, j-1]).

Chi phí xây bảng quy hoạch động là O(m·n) thời gian và O(m·n) không gian bộ nhớ. Bước truy vết đi tối đa m+n bước.
Bản mở rộng `lcs_hai_hang` giảm không gian bộ nhớ xuống O(min(m, n)) chỉ dùng hai mảng một chiều luân phiên.

## Phiên bản và chạy lại

Khởi tạo git, commit C và kiểm tra bản clone sạch:

```powershell
git init
git add .
git commit -m "Commit C: Hoan thanh de tai DT052"
git rev-parse HEAD
cd ..
git clone N24DCDT058_DT052_TranAnNguyen kiem_tra_clone
cd kiem_tra_clone
.\Run_all.ps1
```
