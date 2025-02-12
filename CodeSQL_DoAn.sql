CREATE DATABASE QuanLyBanDoAnNhanh;
go
Use QuanLyBanDoAnNhanh
go
-- Tạo bảng Tài Khoản
CREATE TABLE TaiKhoan (
    IDTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap NVARCHAR(50) UNIQUE NOT NULL,
    MatKhau NVARCHAR(100) NOT NULL,
    LoaiTaiKhoan NVARCHAR(20) CHECK (LoaiTaiKhoan IN ('Admin', 'NhanVien')) NOT NULL
);

-- Tạo bảng Nhân Viên
CREATE TABLE NhanVien (
    IDNhanVien INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    SDT NVARCHAR(15) UNIQUE NOT NULL,
    DiaChi NVARCHAR(255),
    IDTaiKhoan INT UNIQUE,  
    FOREIGN KEY (IDTaiKhoan) REFERENCES TaiKhoan(IDTaiKhoan) ON DELETE SET NULL
);

-- Tạo bảng Khách Hàng
CREATE TABLE KhachHang (
    IDKhachHang INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    SDT NVARCHAR(15) UNIQUE NOT NULL,
    DiemTichLuy INT DEFAULT 0
);

-- Tạo bảng Loại Sản Phẩm
CREATE TABLE LoaiSanPham (
    IDLoai INT IDENTITY(1,1) PRIMARY KEY,
    TenLoai NVARCHAR(100) UNIQUE NOT NULL
);

-- Tạo bảng Sản Phẩm
CREATE TABLE SanPham (
    IDSanPham INT IDENTITY(1,1) PRIMARY KEY,
    TenSanPham NVARCHAR(255) NOT NULL,
    Gia DECIMAL(18,2) NOT NULL,
    IDLoai INT NOT NULL,
    HinhAnh NVARCHAR(255),
    FOREIGN KEY (IDLoai) REFERENCES LoaiSanPham(IDLoai) ON DELETE CASCADE
);

-- Tạo bảng Khuyến Mãi
CREATE TABLE KhuyenMai (
    IDKhuyenMai INT IDENTITY(1,1) PRIMARY KEY,
    MaKhuyenMai NVARCHAR(50) UNIQUE NOT NULL,
    PhanTramGiam DECIMAL(5,2) CHECK (PhanTramGiam BETWEEN 0 AND 100) NOT NULL,
    NgayBatDau DATETIME NOT NULL,
    NgayKetThuc DATETIME NOT NULL
);

-- Tạo bảng Đơn Hàng
CREATE TABLE DonHang (
    IDDonHang INT IDENTITY(1,1) PRIMARY KEY,
    IDKhachHang INT NULL,
    IDNhanVien INT NOT NULL,
    IDKhuyenMai INT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    TrangThai NVARCHAR(20) CHECK (TrangThai IN ('Chưa thanh toán', 'Đã thanh toán')) NOT NULL,
    FOREIGN KEY (IDKhachHang) REFERENCES KhachHang(IDKhachHang) ON DELETE SET NULL,
    FOREIGN KEY (IDNhanVien) REFERENCES NhanVien(IDNhanVien) ON DELETE CASCADE,
    FOREIGN KEY (IDKhuyenMai) REFERENCES KhuyenMai(IDKhuyenMai) ON DELETE SET NULL
);

-- Tạo bảng Chi Tiết Đơn Hàng
CREATE TABLE ChiTietDonHang (
    IDChiTiet INT IDENTITY(1,1) PRIMARY KEY,
    IDDonHang INT NOT NULL,
    IDSanPham INT NOT NULL,
    SoLuong INT CHECK (SoLuong > 0) NOT NULL,
    Gia DECIMAL(18,2) NOT NULL DEFAULT 0,
    TongTien AS (SoLuong * Gia) PERSISTED,
    FOREIGN KEY (IDDonHang) REFERENCES DonHang(IDDonHang) ON DELETE CASCADE,
    FOREIGN KEY (IDSanPham) REFERENCES SanPham(IDSanPham) ON DELETE CASCADE
);

-- Tạo bảng Hóa Đơn
CREATE TABLE HoaDon (
    IDHoaDon INT IDENTITY(1,1) PRIMARY KEY,
    IDDonHang INT UNIQUE NOT NULL,
    NgayThanhToan DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (IDDonHang) REFERENCES DonHang(IDDonHang) ON DELETE CASCADE
);

-- Tạo bảng Lịch Sử Tích Điểm Khách Hàng
CREATE TABLE LichSuTichDiem (
    IDLichSu INT IDENTITY(1,1) PRIMARY KEY,
    IDKhachHang INT NOT NULL,
    DiemCong INT NOT NULL,
    NgayGiaoDich DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (IDKhachHang) REFERENCES KhachHang(IDKhachHang) ON DELETE CASCADE
);

-----
-- Chèn dữ liệu vào bảng Tài Khoản
INSERT INTO TaiKhoan (TenDangNhap, MatKhau, LoaiTaiKhoan) VALUES
('admin', 'admin123', 'Admin'),
('nhantai123', '1233456789', 'NhanVien'),
('vankhoa456', '987654321','NhanVien');

-- Chèn dữ liệu vào bảng Nhân Viên
INSERT INTO NhanVien (HoTen, SDT, DiaChi, IDTaiKhoan) VALUES
('Do Thanh Nhan Tai', '0915838301', 'Cần Thơ', 2),
('Nguyen Van Khoa','0900900900','Cần Thơ ', 3);
-- Chèn dữ liệu vào bảng Khách Hàng
INSERT INTO KhachHang (HoTen, SDT, DiemTichLuy) VALUES
('Thai Lam Hong Phuc', '0923456789', 10),
('Pham Thai An', '0934567890', 20);

-- Chèn dữ liệu vào bảng Loại Sản Phẩm
INSERT INTO LoaiSanPham (TenLoai) VALUES
('Đồ uống'),
('Đồ ăn');

-- Chèn dữ liệu vào bảng Sản Phẩm
INSERT INTO SanPham (TenSanPham, Gia, IDLoai, HinhAnh) VALUES
(N'Hamburger bò', 45000, 1, 'hamburgerbo.jpg'),
(N'Hamburger Bò Trứng Xúc Xích', 50000, 1, 'hamburgerbotrungxx.jpg'),
(N'Hamburger Gà', 40000, 1, 'hamburgerga.jpg'),
(N'Hamburger Trứng Opla', 48000, 1, 'hamburgertrungopla.jpg'),
(N'Gà Không Xương', 60000, 1, 'gakhongxuonwg.jpg'),
(N'Gà Rán Giòn Cay', 55000, 1, 'garangion.jpg'),
(N'Gà Rán Giòn Không Cay', 55000, 1, 'garangion.jpg'),
(N'Gà Tẩm Nước Mắm', 65000, 1, 'gatamnuocnmam.jpg'),
(N'Pizza Bò Xúc Xích', 90000, 1, 'boxucxich.jpg'),
(N'Pizza Hải Sản', 95000, 1, 'haisan.jpg'),
(N'Pizza Phô Mai', 85000, 1, 'phomai.jpg'),
(N'Pizza Rau Củ', 80000, 1, 'raucu.jpg'),
(N'Pizza Thập Cẩm', 92000, 1, 'thapcamz.jpg'),
(N'Pizza Xúc Xích', 87000, 1, 'xucxich.jpg'),
(N'Trà Sữa Đặc Biệt', 35000, 2, 'tsdacbiet.jpg'),
(N'Trà Sữa Hạt Dẻ', 32000, 2, 'tshatde.jpg'),
(N'Trà Sữa Kem Trứng', 34000, 2, 'tskemtrung.jpg'),
(N'Trà Sữa Khoai Môn', 33000, 2, 'tskhoaimon.jpg'),
(N'Trà Sữa Khúc Bạch', 36000, 2, 'tskhucbach.jpg'),
(N'Trà Sữa Thái Xanh', 31000, 2, 'tsthaixanh.jpg'),
(N'Trà Sữa Truyền Thống', 30000, 2, 'tstruyenthong.jpg'),
(N'Trà Sữa Đào', 32000, 2, 'trasuadao.jpg'),
(N'NTrà Chanh', 25000, 2, 'trachanh.jpg'),
(N'Trà Dâu', 28000, 2, 'tradau.jpg'),
(N'Trà Dứa', 27000, 2, 'tradua.jpg'),
(N'Trà Tắc', 26000, 2, 'tratac.jpg'),
(N'Trà Chanh Dây', 29000, 2, 'traxanh.jpg');


-- Chèn dữ liệu vào bảng Khuyến Mãi
INSERT INTO KhuyenMai (MaKhuyenMai, PhanTramGiam, NgayBatDau, NgayKetThuc) VALUES
('KM10', 10, '2025-01-01', '2025-12-31');

-- Chèn dữ liệu vào bảng Đơn Hàng
INSERT INTO DonHang (IDKhachHang, IDNhanVien, IDKhuyenMai, TrangThai) VALUES
(1, 1, 1, 'Đã thanh toán'),
(2, 1, NULL, 'Chưa thanh toán');

-- Chèn dữ liệu vào bảng Chi Tiết Đơn Hàng
INSERT INTO ChiTietDonHang (IDDonHang, IDSanPham, SoLuong) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 2, 3);

-- Chèn dữ liệu vào bảng Hóa Đơn
INSERT INTO HoaDon (IDDonHang, TongTien) VALUES
(1, 80000);

-- Chèn dữ liệu vào bảng Lịch Sử Tích Điểm
INSERT INTO LichSuTichDiem (IDKhachHang, DiemCong) VALUES
(1, 5),
(2, 10);


