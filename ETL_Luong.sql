CREATE DEFINER=`dulieutu`@`%` PROCEDURE `ETL_Luong`()
BEGIN

-- Bước 1: ETL ( Loại bỏ những thành phần không phải số )

	update Stg_ThongTin_v1
    set
		Luong = replace(Luong,'Trên',''),
        Luong = replace(Luong,'Lên đến',''),
        Luong = replace(Luong,'Tới',''),
        Luong = replace(Luong,'VND',''),
        Luong = replace(Luong,',',''),
		Luong = replace(Luong,'.',''),
        Luong = replace(Luong,'Lên tới',''),
        Luong = replace(Luong,'Từ',''),
        Luong = replace(Luong,'Dưới',''),
        Luong = replace(Luong,'USD',''),
        Luong = replace(Luong,'IDR','');
        
-- Bước 2: Sử dụng cast và substring để tách ra min max và lương trung bình
	update Stg_ThongTin_v1
    set 
		LuongMin = cast(substring_index(Luong,'-',1) as Decimal(12,2)),
        LuongMax = cast(substring_index(Luong,'-',-1) as Decimal(12,2)),
        LuongTB = (LuongMin+LuongMax)/2;
-- Bước 3: Xử lý các trường hợp 12000000-23000000
		update Stg_ThongTin_v1
		set  	
		LuongMin = LuongMin * 0.000001,
		LuongTB  = LuongTB  * 0.000001,
		LuongMax = LuongMax * 0.000001
		where ID_Nganh = 2 and (LuongMax >= 1000000 or LuongMin >= 1000000);
-- Bước 4: Xử lý Luong USD 
	-- Note: Lương USD thường chỉ nằm trong khoảng từ 350 - > 10000 (mười nghìn đô - level khá ok) nên
    -- nhân LuongMin,LuongMax,LuongTB với 0.024 - tỷ giá đô hiện tại 
		update Stg_ThongTin_v1
        set 
			LuongMin = LuongMin * 0.024,
            LuongMax = LuongMax * 0.024,
            LuongTB  = LuongTB  * 0.024
		where ID_Nganh = 2 and LuongTB between 350 and 10000;

-- Bước cuối: Set những bản ghi có LuongMin,Max,TB = 0.0 thành 'Thoả thuận'
	update Stg_ThongTin_v1
    set 
		LuongTB = 'Thoả thuận'
	where ID_Nganh = 2 and LuongTB = 0.0;
        
END