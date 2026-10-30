module DeTai

export kiem_tra_dau_vao, lcs_bang, truy_vet_lcs, la_day_con, lcs_hai_hang, in_bang_lcs, giai_bai

function kiem_tra_dau_vao(X::AbstractString, Y::AbstractString)
    (0 <= length(X) <= 100 && 0 <= length(Y) <= 100) || throw(ArgumentError("do dai xau phai nam trong 0..100"))
    for (idx, c) in enumerate(X)
        (isascii(c) && isletter(c)) || throw(ArgumentError("xau X chua ky tu khong hop le '$c' tai vi tri $idx"))
    end
    for (idx, c) in enumerate(Y)
        (isascii(c) && isletter(c)) || throw(ArgumentError("xau Y chua ky tu khong hop le '$c' tai vi tri $idx"))
    end
    return true
end

function kiem_tra_dau_vao(du_lieu)
    (du_lieu isa Tuple && length(du_lieu) == 2) || throw(ArgumentError("du lieu phai la tuple chua 2 xau (X, Y)"))
    X, Y = du_lieu
    (X isa AbstractString && Y isa AbstractString) || throw(ArgumentError("hai phan tu phai la kieu String"))
    return kiem_tra_dau_vao(X, Y)
end

function lcs_bang(X::AbstractString, Y::AbstractString)
    arr_X = collect(X)
    arr_Y = collect(Y)
    m = length(arr_X)
    n = length(arr_Y)
    f = zeros(Int, m + 1, n + 1)
    so_o_tinh = 0

    for i in 1:m
        for j in 1:n
            so_o_tinh += 1
            if arr_X[i] == arr_Y[j]
                f[i + 1, j + 1] = f[i, j] + 1
            else
                f[i + 1, j + 1] = max(f[i, j + 1], f[i + 1, j])
            end
        end
    end
    return (; f, so_o_tinh)
end

function truy_vet_lcs(X::AbstractString, Y::AbstractString, f::Matrix{Int})
    arr_X = collect(X)
    arr_Y = collect(Y)
    i = length(arr_X)
    j = length(arr_Y)
    duong = Char[]
    so_buoc_truy_vet = 0

    while i > 0 && j > 0
        so_buoc_truy_vet += 1
        if arr_X[i] == arr_Y[j]
            push!(duong, arr_X[i])
            i -= 1
            j -= 1
        elseif f[i, j + 1] >= f[i + 1, j]
            i -= 1
        else
            j -= 1
        end
    end
    return (; day=String(reverse(duong)), so_buoc_truy_vet)
end

function la_day_con(s::AbstractString, x::AbstractString)
    arr_s = collect(s)
    arr_x = collect(x)
    len_s = length(arr_s)
    len_x = length(arr_x)
    i = 1
    for c in arr_x
        if i <= len_s && arr_s[i] == c
            i += 1
        end
    end
    return i > len_s
end

function lcs_hai_hang(X::AbstractString, Y::AbstractString)
    length(X) < length(Y) && return lcs_hai_hang(Y, X)
    arr_X = collect(X)
    arr_Y = collect(Y)
    m = length(arr_X)
    n = length(arr_Y)
    prev_row = zeros(Int, n + 1)
    curr_row = zeros(Int, n + 1)

    for i in 1:m
        curr_row[1] = 0
        for j in 1:n
            if arr_X[i] == arr_Y[j]
                curr_row[j + 1] = prev_row[j] + 1
            else
                curr_row[j + 1] = max(prev_row[j + 1], curr_row[j])
            end
        end
        prev_row .= curr_row
    end
    return curr_row[n + 1]
end

function in_bang_lcs(X::AbstractString, Y::AbstractString, f::Matrix{Int}; io=stdout)
    arr_X = collect(X)
    arr_Y = collect(Y)
    m = length(arr_X)
    n = length(arr_Y)

    println(io, "\nBang quy hoach dong LCS voi nhan ky tu:")
    print(io, "      e  ")
    for j in 1:n
        print(io, "  $(arr_Y[j]) ")
    end
    println(io)

    for i in 0:m
        nhan = (i == 0) ? "e" : string(arr_X[i])
        print(io, "  $nhan  ")
        for j in 0:n
            print(io, lpad(string(f[i + 1, j + 1]), 3), " ")
        end
        println(io)
    end
    println(io)
end

function giai_bai(X::AbstractString, Y::AbstractString)
    kiem_tra_dau_vao(X, Y)
    kq_bang = lcs_bang(X, Y)
    f = kq_bang.f
    kq_vet = truy_vet_lcs(X, Y, f)
    day = kq_vet.day
    do_dai = f[length(X) + 1, length(Y) + 1]

    @assert length(day) == do_dai
    @assert la_day_con(day, X)
    @assert la_day_con(day, Y)

    return (; X, Y, do_dai, day, bang=f, kq_bang.so_o_tinh, kq_vet.so_buoc_truy_vet)
end

function giai_bai(du_lieu)
    kiem_tra_dau_vao(du_lieu)
    return giai_bai(du_lieu[1], du_lieu[2])
end

end # module DeTai
