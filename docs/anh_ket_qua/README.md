# Kế hoạch 11 ảnh minh chứng A01–A11 cho đề tài DT052

Thư mục này dùng để lưu trữ 11 ảnh chụp màn hình thực nghiệm thật (A01 đến A11)
để chèn vào Chương 4 của báo cáo cá nhân `N24DCDT058_DT052_TranAnNguyen_BaoCao.docx`.

| Mã ảnh | Tên tệp lưu tại đây | Lệnh thực thi để chụp | Mục tiêu minh chứng |
| :--- | :--- | :--- | :--- |
| **A01** | `01_vi_du_1.png` | `julia demo.jl --ca=1` | Ví dụ 1 phiếu: X="ABCBDAB", Y="BDCABA" -> do_dai=4, day="BCBA", bảng có nhãn |
| **A02** | `02_vi_du_2.png` | `julia demo.jl --ca=2` | Ví dụ 2 phiếu (Câu 23 SGK): X="AGGTAB", Y="GXTXAYB" -> do_dai=4, day="GTAB" |
| **A03** | `03_tu_thiet_ke_1.png` | `julia demo.jl --ca=3` | Ca tự thiết kế 1: Phân biệt nghiêm ngặt chữ hoa và thường (case-sensitive) -> do_dai=0 |
| **A04** | `04_tu_thiet_ke_2.png` | `julia demo.jl --ca=4` | Ca tự thiết kế 2: Xâu kinh điển giáo trình CLRS -> do_dai=4, day="MJAU" |
| **A05** | `05_bien_1.png` | `julia demo.jl --ca=5` | Ca biên 1: Xâu X rỗng -> do_dai=0, day="", không đọc tràn mảng |
| **A06** | `06_bien_2.png` | `julia demo.jl --ca=6` | Ca biên 2: Hai xâu giống nhau hoàn toàn -> do_dai=3, day="ABC" |
| **A07** | `07_bien_3.png` | `julia demo.jl --ca=7` | Ca biên 3: Hai xâu không có ký tự chung -> do_dai=0, day="" |
| **A08** | `08_input_khong_hop_le.png` | `julia demo.jl --ca=8` | Validator từ chối dữ liệu sai, bắt lỗi ArgumentError và in xác nhận thoát mã 0 chuẩn |
| **A09** | `09_tong_ket_kiem_thu.png` | `julia test/runtests.jl` | Tổng kết toàn bộ 12 ca chức năng + 12 ca kiểm tra dữ liệu vào (57 assert) PASS 100% |
| **A10** | `10_clone_sach_chay_lai.png` | Clone repo sạch sang thư mục mới | Kiểm tra git rev-parse HEAD, chạy lại .\Run_all.ps1 độc lập |
| **A11** | `11_github_repo_commit.png` | Chụp giao diện GitHub thật | Trang GitHub repository cá nhân tại commit C chứa cây thư mục và mã nguồn |

## Quy chuẩn chụp ảnh:
1. Chụp rõ ràng giao diện terminal hoặc trình duyệt bằng phím tắt `Windows + Shift + S`.
2. Thấy rõ: Lệnh chạy, dữ liệu vào (Input), kết quả ra (Output) và mã hash nếu có.
3. Không sửa ảnh hoặc dùng ảnh mẫu.
