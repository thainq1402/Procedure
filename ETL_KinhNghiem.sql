CREATE DEFINER=`dulieutu`@`%` PROCEDURE `ETL_KinhNghiem`()
BEGIN
-- Bước 1: ETL Dữ liệu ( bỏ đi các từ phía trước không cần thiết )
	update Stg_ThongTin_v1
    set 
		KinhNghiem = replace(KinhNghiem,'Lên đến',''),
		KinhNghiem = replace(KinhNghiem,'Trên',''),
		KinhNghiem = replace(KinhNghiem,'Dưới',''),
		KinhNghiem = replace(KinhNghiem,'Hơn',''),
		KinhNghiem = replace(KinhNghiem,'đến','-'),
		KinhNghiem = replace(KinhNghiem,'một','1'),
		KinhNghiem = replace(KinhNghiem,'Từ','');
-- Bước 2: Sử dụng hàm cast, substring_index để lấy ra min max và tính trung bình
	update Stg_ThongTin_v1
    set 
		KinhNghiemMin = cast(substring_index(KinhNghiem,'-',1) as Decimal(5,2)), -- Min
		KinhNghiemMax = cast(substring_index(KinhNghiem,'-',-1) as Decimal(5,2)), -- Max
        KinhNghiemTB = (KinhNghiemMin + KinhNghiemMax)/2;
-- Bước 3: Update các trường hợp kinh nghiệm 'Tháng'
	Update Stg_ThongTin_v1
    set 
		KinhNghiemMin = KinhNghiemMin /12,
        KinhNghiemMax = KinhNghiemMax /12,
        KinhNghiemTB  = KinhNghiemTB /12
	where ID_Nganh = 2 and (KinhNghiem like  '%Tháng' or KinhNghiem like '%Tháng%');
-- Bước cuối: Update các TH KinhNghiem Min, Max = 0.0 -> Không yêu cầu 


END