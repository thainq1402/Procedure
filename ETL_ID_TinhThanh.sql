CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_TinhThanh`()
BEGIN
	update Stg_ThongTin_raw
	set ID_TinhThanh = 
	case 
		when TinhThanh like 'An Giang' then 1
		when TinhThanh like '%An Giang%' then 1
		when TinhThanh like 'Bà Rịa - Vũng Tàu' then 2
		when TinhThanh like '%Vũng Tàu%' then 2
		when TinhThanh like 'Bạc Liêu' then 3
		when TinhThanh like '%Bạc Liêu%' then 3
		when TinhThanh like '%Bắc Giang%' then 4
		when TinhThanh like 'Bắc Giang' then 4
		when TinhThanh like '%Bắc Giang' then 4
		when TinhThanh like 'Bắc Kạn' then 5
		when TinhThanh like 'Bắc Cạn' then 5
		when TinhThanh like 'Bắc Ninh' then 6
		when TinhThanh like '%Bắc Ninh%' then 6
		when TinhThanh like '%Bắc Ninh' then 6
		when TinhThanh like 'Bến Tre' then 7
		when TinhThanh like '%Bến Tre%' then 7
		when TinhThanh like 'Ba Tri' then 7
		when TinhThanh like 'Bình Dương' then 8
		when TinhThanh like '%Bình Dương' then 8
		when TinhThanh like '%Bình Dương%' then 8
		when TinhThanh like 'Bình Định' then 9
		when TinhThanh like '%Bình Định' then 9
		when TinhThanh like '%Bình Định%' then 9
		when TinhThanh like 'Bình Phước' then 10
		when TinhThanh like '%Bình Phước%' then 10  
		when TinhThanh like '%Bình Phước' then 10
		when TinhThanh like 'Bình Thuận' then 11
		when TinhThanh like '%Bình Thuận%' then 11
		when TinhThanh like '%Bình Thuận' then 11
		when TinhThanh like 'Cà Mau' then 12
		when TinhThanh like '%Cà Mau%' then 12
		when TinhThanh like 'Cao Bằng' then 13
		when TinhThanh like 'Cần Thơ' then 14
		when TinhThanh like '%Cần Thơ' then 14
		when TinhThanh like '%Cần Thơ%' then 14
		when TinhThanh like 'Đà Nẵng' then 15
		when TinhThanh like '%Đà Nẵng%' then 15
		when TinhThanh like 'Da Nang' then 15
		when TinhThanh like 'Đắk Lắk' then 16
		when TinhThanh like '%Đắk Lắk%' then 16
		when TinhThanh like 'Dak Lak' then 16
		when TinhThanh like 'Đắk Nông' then 17
		when TinhThanh like '%Dak Nông' then 17
		when TinhThanh like '%Đắk Nông%' then 17
		when TinhThanh like 'Điện Biên' then 18
		when TinhThanh like 'Đồng Nai' then 19
		when TinhThanh like '%Đồng Nai' then 19
		when TinhThanh like '%Đồng Nai%' then 19
		when TinhThanh like 'Đồng Tháp' then 20
		when TinhThanh like '%Đồng Tháp%' then 20
		when TinhThanh like '%Đồng Tháp' then 20
		when TinhThanh like 'Gia Lai' then 21
		when TinhThanh like '%Gia Lai%' then 21
		when TinhThanh like 'Hà Giang' then 22
		when TinhThanh like 'Hà Nam' then 23
		when TinhThanh like '%Hà Nam%' then 23
		when TinhThanh like 'Hà Nội' then 24
		when TinhThanh like 'Cầu giấy' then 24
		when TinhThanh like '%Hai%' then 24
		when TinhThanh like '%Ba đình%' then 24
		when TinhThanh like '%Từ Liêm%' then 24
		when TinhThanh like '%Tây Hồ%' then 24
		when TinhThanh like '%Hoàng Mai%' then 24
		when TinhThanh like '%Thanh Xuân%' then 24
		when TinhThanh like '%Hà Nội%' then 24
		when TinhThanh like 'Hà Tĩnh' then 25
		when TinhThanh like '%Hà Tĩnh%' then 25
		when TinhThanh like 'Hải Dương' then 26
		when TinhThanh like '%Hải Dương' then 26
		when TinhThanh like '%Hải Dương%' then 26
		when TinhThanh like 'Hải Phòng' then 27
		when TinhThanh like '%Hải Phòng%' then 27
		when TinhThanh like '%Hải Phòng' then 27
		when TinhThanh like 'Hậu Giang' then 28
		when TinhThanh like '%Hậu Giang%' then 28
		when TinhThanh like '%Hậu Giang' then 28
		when TinhThanh like 'Hoà Bình' then 29
		when TinhThanh like 'Hưng Yên' then 30
		when TinhThanh like '%Hưng Yên%' then 30
		when TinhThanh like 'Khánh Hoà' then 31
		when TinhThanh like '%Khánh Hoà%' then 31
		when TinhThanh like 'Kiên Giang' then 32
		when TinhThanh like '%Kiên Giang%' then 32
		when TinhThanh like 'An Biên' then 32
		when TinhThanh like 'Kon Tum' then 33
		when TinhThanh like '%Kon Tum%' then 33
		when TinhThanh like '%Kon Tum' then 33
		when TinhThanh like 'Lai Châu' then 34
		when TinhThanh like 'Lạng Sơn' then 35
		when TinhThanh like 'Bắc Sơn' then 35
		when TinhThanh like 'Lào Cai' then 36
		when TinhThanh like 'Lâm Đồng' then 37
		when TinhThanh like '%Lâm Đồng%' then 37
		when TinhThanh like 'Long An' then 38
		when TinhThanh like '%Long An' then 38
		when TinhThanh like '%Long An%' then 38
		when TinhThanh like 'Nam Định' then 39
		when TinhThanh like 'Nghệ An' then 40
		when TinhThanh like '%Nghệ An%' then 40
		when TinhThanh like '%Nghệ An' then 40
		when TinhThanh like 'Ninh Bình' then 41
		when TinhThanh like 'Ninh Thuận' then 42
		when TinhThanh like 'Phú Thọ' then 43
		when TinhThanh like 'Phú Yên' then 44
		when TinhThanh like 'Quảng Bình' then 45
		when TinhThanh like '%Quảng Bình%' then 45
		when TinhThanh like 'Quảng Nam' then 46
		when TinhThanh like '%Quảng Nam%' then 46
		when TinhThanh like '%Quảng Nam' then 46
		when TinhThanh like 'Quảng Ngãi' then 47
		when TinhThanh like '%Quảng Ngãi%' then 47
		when TinhThanh like 'Quảng Ninh' then 48
		when TinhThanh like '%Quảng Ninh%' then 48
		when TinhThanh like 'Quảng Trị' then 49
		when TinhThanh like 'Sóc Trăng' then 50
		when TinhThanh like 'Sơn La' then 51
		when TinhThanh like 'Tây Ninh' then 52
		when TinhThanh like '%Tây Ninh%' then 52
		when TinhThanh like '%Tây Ninh' then 52
		when TinhThanh like 'Thái Bình' then 53
		when TinhThanh like 'Thái Nguyên' then 54
		when TinhThanh like '%hái Nguyên%' then 54
		when TinhThanh like 'Thanh Hoá' then 55
		when TinhThanh like '%Thanh Hoá%' then 55
		when TinhThanh like 'Thừa Thiên Huế' then 56
		when TinhThanh like '%Huế%' then 56
		when TinhThanh like 'Tiền Giang' then 57
		when TinhThanh like '%Tiền Giang%' then 57
		when TinhThanh like 'Hồ Chí Minh' then 58
		when TinhThanh like '%Đông Nam%' then 58
		when TinhThanh like '%Bình Thạnh' then 58
		when TinhThanh like '%Quan 1%' then 58
		when TinhThanh like '%Chí Minh%' then 58
		when TinhThanh like '%HCM%' then 58
		when TinhThanh like 'Thủ Đức' then 58
		when TinhThanh like 'Quận Bốn' then 58
		when TinhThanh like 'Toàn quốc' then 58
		when TinhThanh like '%Bắc' then 58
		when TinhThanh like '%Tất cả%' then 58
		when TinhThanh like 'Trà Vinh' then 59
		when TinhThanh like 'Tuyên Quang' then 60
		when TinhThanh like 'Vĩnh Long' then 61
		when TinhThanh like '%ĩnh Long%' then 61
		when TinhThanh like 'Vĩnh Phúc' then 62
		when TinhThanh like '%Vĩnh Phúc%' then 62
		when TinhThanh like '%Vĩnh Phúc' then 62
		when TinhThanh like 'Yên Bái' then 63
		when TinhThanh like 'Khác' then 64
		when TinhThanh like '%Khác' then 64
		when TinhThanh like 'Nước ngoài' then 64
		when TinhThanh like 'Oversea' then 64
		when TinhThanh like '%Nước ngoài' then 64
		when TinhThanh like 'Nhật Bản' then 64
		when TinhThanh like '%Nhật Bản%' then 64
		when TinhThanh like '%Tokyo%' then 64
		when TinhThanh like '%Osaka%' then 64
		when TinhThanh like '%Kyoto%' then 64
		when TinhThanh like 'Quốc tế' then 64
		when TinhThanh like 'Singapore' then 64
        else 64
        end;
END