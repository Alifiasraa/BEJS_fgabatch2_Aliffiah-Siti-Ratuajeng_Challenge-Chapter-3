-- DDL
create table tb_alamat (
	id_alamat serial primary key,
	jalan varchar(100) not null,
	kelurahan varchar(50) not null,
	kecamatan varchar(50) not null,
	kota varchar(50) not null,
	provinsi varchar(50) not null,
	negara varchar(50) not null,
	kode_pos varchar(15) not null
)

create table tb_nasabah (
	id_nasabah serial primary key,
	nama_nasabah varchar(100) not null,
	id_alamat serial,
	tanggal_lahir date not null,
	no_telepon varchar(15) not null unique,
	foreign key (id_alamat) references tb_alamat (id_alamat)
)

--akun
create type status_akun_enum as enum ('Aktif', 'Non-Aktif')

create table tb_jenis_akun (
	id_jenis_akun serial primary key,
	nama_jenis_akun varchar(50) not null
)

create table tb_akun (
	id_akun serial primary key,
	id_nasabah serial,
	id_jenis_akun serial,
	no_rekening varchar(50) not null,
	email varchar(100) not null,
	status_akun status_akun_enum not null,
	saldo integer not null,
	foreign key (id_nasabah) references tb_nasabah (id_nasabah),
	foreign key (id_jenis_akun) references tb_jenis_akun (id_jenis_akun)
)

--transaksi
create type status_transaksi_enum as enum ('Sukses', 'Gagal', 'Pending', 'Dalam Proses')

create table tb_jenis_transaksi (
	id_jenis_transaksi serial primary key,
	nama_jenis_transaksi varchar(50) not null
)

create table tb_transaksi (
	id_transaksi serial primary key,
	id_akun serial,
	id_jenis_transaksi serial,
	status_transaksi status_transaksi_enum not null,
	tanggal_transaksi timestamp not null default current_timestamp,
	foreign key (id_akun) references tb_akun (id_akun),
	foreign key (id_jenis_transaksi) references tb_jenis_transaksi (id_jenis_transaksi)
)

-- DML

--insert data to tb_alamat
insert into tb_alamat (jalan, kelurahan, kecamatan, kota, provinsi, negara, kode_pos) values
('Jl. Sukajadi No. 25', 'Pasteur', 'Sukajadi', 'Bandung', 'Jawa Barat', 'Indonesia', '40161'),
('Jl. Cihampelas No. 123', 'Cihampelas', 'Coblong', 'Bandung', 'Jawa Barat', 'Indonesia', '40131'),
('Jl. Riau No. 456', 'Riau', 'Bandung Wetan', 'Bandung', 'Jawa Barat', 'Indonesia', '40111')

select * from tb_alamat
	   
--crud tb_nasabah
insert into tb_nasabah (nama_nasabah, id_alamat, tanggal_lahir, no_telepon) values
('Dwi', 1, '2001-09-07', '08123456789'), --delete
('Kania', 1, '1998-04-28', '08192827364'),
('Doni', 3, '1980-12-19', '087829372378'),
('Budi', 2, '1995-01-12', '081234322342')

select * from tb_nasabah

update tb_nasabah 
set no_telepon = '089991111122'
where nama_nasabah='Kania'

delete from tb_nasabah 
where id_nasabah = 1

--insert data to tb_jenis_akun
insert into tb_jenis_akun (nama_jenis_akun) values
('Tabungan'),
('Giro'),
('Deposito'),
('Investasi')

select * from tb_jenis_akun

--crud tb_akun
insert into tb_akun (id_nasabah, id_jenis_akun, no_rekening, email, status_akun, saldo) values
(2, '3', '1234567890', 'kania@gmail.com', 'Aktif', 200000),
(3, '2', '5432109876', 'doni@gmail.com', 'Non-Aktif', 0), --delete
(4, '1', '6789012345', 'budi@gmail.com', 'Non-Aktif', 350000)

select * from tb_akun

update tb_akun
set status_akun = 'Aktif'
where id_nasabah = 4

delete from tb_akun 
where status_akun = 'Non-Aktif'

--insert data to tb_jenis_transaksi
insert into tb_jenis_transaksi (nama_jenis_transaksi) values
('Debit'),
('Kredit'),
('Transfer'),
('Pembayaran'),
('Penarikan')

select * from tb_jenis_transaksi 

--crud tb_transaksi
insert into tb_transaksi (id_akun, id_jenis_transaksi, status_transaksi) values
(1, 3, 'Sukses'),
(1, 2, 'Gagal'), --delete
(3, 3, 'Pending')

select * from tb_transaksi 

update tb_transaksi 
set status_transaksi = 'Sukses'
where id_transaksi = 3

delete from tb_transaksi
where status_transaksi = 'Gagal'
