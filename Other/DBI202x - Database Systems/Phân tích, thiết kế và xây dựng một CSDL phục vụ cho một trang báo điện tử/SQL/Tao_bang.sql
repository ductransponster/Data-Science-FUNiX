-- II. Tạo các bảng
-- 2.1. Bảng ChuDE
CREATE TABLE ChuDe
(
	ID_ChuDe INT IDENTITY(1,1) NOT NULL,
	TenChuDe NVARCHAR(200) NOT NULL,
	MoTa NVARCHAR(500),
	NgayTao DATETIME NOT NULL,
	CONSTRAINT PK_ChuDe PRIMARY KEY(ID_ChuDe),
	CONSTRAINT UNIQUE_ChuDe UNIQUE (TenChuDe)
)
GO

-- 2.2. Tạo bảng ChuyenMuc
CREATE TABLE ChuyenMuc
(
	ID_ChuyenMuc INT IDENTITY(1,1) NOT NULL,
	TenChuyenMuc NVARCHAR(200) NOT NULL,
	MoTa NVARCHAR(500),
	NgayTao DATETIME NOT NULL,
	ID_ChuDe INT NOT NULL,
	CONSTRAINT PK_ChuyenMuc PRIMARY KEY (ID_ChuyenMuc),
	CONSTRAINT FK_ChuyenMuc FOREIGN KEY (ID_ChuDe) REFERENCES ChuDe(ID_ChuDe),
	CONSTRAINT UNIQUE_ChuyenMuc UNIQUE (TenChuyenMuc)
)
GO

-- 2.3. Bảng BienTapVien
CREATE TABLE BienTapVien
(
	ID_BienTapVien INT IDENTITY(1,1) NOT NULL,
	Email VARCHAR(320) NOT NULL,
	MatKhau NVARCHAR(64) NOT NULL,
	HoTen NVARCHAR(100) NOT NULL,
	GioiTinh NVARCHAR(3),
	NgayThangNamSinh DATE,
	AnhDaiDien VARCHAR(500),
	NgayThamGia DATETIME NOT NULL,
	CONSTRAINT PK_BienTapVien PRIMARY KEY (ID_BienTapVien),
	CONSTRAINT Check_BienTapVien_NgayThamgia CHECK (NgayThamGia <= GETDATE()),
	CONSTRAINT Check_BienTapVien_NgayThangNamSinh CHECK (YEAR(GETDATE()) - YEAR(NgayThangNamSinh) > 18)
)
GO

-- 2.4. Bảng PhongVien
CREATE TABLE PhongVien
(
	ID_PhongVien INT IDENTITY(1,1) NOT NULL,
	Email VARCHAR(320) NOT NULL,
	MatKhau NVARCHAR(64) NOT NULL,
	HoTen NVARCHAR(100) NOT NULL,
	GioiTinh NVARCHAR(3),
	NgayThangNamSinh DATE,
	AnhDaiDien VARCHAR(500),
	NgayThamGia DATETIME NOT NULL,
	ID_BienTapVien INT NOT NULL,
	CONSTRAINT PK_PhongVien PRIMARY KEY (ID_PhongVien),
	CONSTRAINT FK_PhongVien FOREIGN KEY (ID_BienTapVien) REFERENCES BienTapVien(ID_BienTapVien),
	CONSTRAINT Check_PhongVien_NgayThamgia CHECK (NgayThamGia <= GETDATE()),
	CONSTRAINT Check_PhongVien_NgayThangNamSinh CHECK (YEAR(GETDATE()) - YEAR(NgayThangNamSinh) > 18)
)
GO

-- 2.5. Bảng NguoiDoc
CREATE TABLE NguoiDoc
(
	ID_NguoiDoc INT IDENTITY(1,1) NOT NULL,
	Email VARCHAR(320) NOT NULL,
	MatKhau NVARCHAR(64) NOT NULL,
	HoTen NVARCHAR(100) NOT NULL,
	AnhDaiDien VARCHAR(500),
	NgayThamGia DATETIME NOT NULL,
	CONSTRAINT PK_NguoiDoc PRIMARY KEY (ID_NguoiDoc),
	CONSTRAINT Check_NguoiDoc_NgayThamgia CHECK (NgayThamGia <= GETDATE())
)
GO

-- 2.6. Bảng BaiBao
CREATE TABLE BaiBao
(
	ID_BaiBao INT IDENTITY(1,1) NOT NULL,
	TieuDe NVARCHAR(200) NOT NULL,
	NoiDungTomTat NVARCHAR(500) NOT NULL,
	NoiDungDayDu NVARCHAR(MAX) NOT NULL,
	NgayXuatBan DATETIME NOT NULL,
	NgayCapNhat DATETIME NOT NULL,
	SoLuotXem INT NOT NULL,
	ID_ChuyenMuc INT NOT NULL,
	ID_PhongVien INT NOT NULL,
	ID_BienTapVien INT NOT NULL,
	CONSTRAINT PK_BaiBao PRIMARY KEY (ID_BaiBao),
	CONSTRAINT FK_BaiBao_ChuyenMuc FOREIGN KEY (ID_ChuyenMuc) REFERENCES ChuyenMuc(ID_ChuyenMuc),
	CONSTRAINT FK_BaiBao_PhongVien FOREIGN KEY (ID_PhongVien) REFERENCES PhongVien(ID_PhongVien),
	CONSTRAINT FK_BaiBao_BienTapVien FOREIGN KEY (ID_BienTapVien) REFERENCES BienTapVien(ID_BienTapVien),
	CONSTRAINT Check_BaiBao_NgayCapNhat CHECK (NgayCapNhat >= NgayXuatBan)
)
GO

-- 2.7. Bảng HinhAnh
CREATE TABLE HinhAnh
(
	ID_BaiBao INT NOT NULL,
	ID_HinhAnh INT IDENTITY(1,1) NOT NULL,
	TenAnh NVARCHAR(200) NOT NULL,
	Anh VARCHAR(500) NOT NULL,
	CONSTRAINT PK_HinhAnh PRIMARY KEY (ID_BaiBao, ID_HinhAnh),
	CONSTRAINT FK_HinhAnh FOREIGN KEY (ID_BaiBao) REFERENCES BaiBao(ID_BaiBao)
)
GO

-- 2.8. Bảng Video
CREATE TABLE Video
(
	ID_BaiBao INT NOT NULL,
	ID_Video INT IDENTITY(1,1) NOT NULL,
	TenVideo NVARCHAR(200) NOT NULL,
	Video VARCHAR(500) NOT NULL,
	CONSTRAINT PK_Video PRIMARY KEY (ID_BaiBao, ID_Video),
	CONSTRAINT FK_Video FOREIGN KEY (ID_BaiBao) REFERENCES BaiBao(ID_BaiBao)
)
GO

-- 2.9. Bảng BinhLuan
CREATE TABLE BinhLuan
(
	ID_BaiBao INT NOT NULL,
	ID_NguoiDoc INT NOT NULL,
	STT INT IDENTITY(1,1) NOT NULL,
	ThoiDiemBinhLuan DATETIME NOT NULL,
	NoiDung NVARCHAR(4000) NOT NULL,
	CONSTRAINT PK_BinhLuan PRIMARY KEY (ID_BaiBao, ID_NguoiDoc, STT),
	CONSTRAINT FK_BinhLuan_BaiBao FOREIGN KEY (ID_BaiBao) REFERENCES BaiBao(ID_BaiBao),
	CONSTRAINT FK_BinhLuan_NguoiDoc FOREIGN KEY (ID_NguoiDoc) REFERENCES NguoiDoc(ID_NguoiDoc)
)
GO