CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_KinhNghiem`()
-- Version 1.0 2023-18-12

BEGIN
-- Bước 0: Set cột KinhNghiemETL = KinhNghiem
	update Stg_ThongTin set KinhNghiemETL = KinhNghiem;
-- Bước 1: ETL Dữ liệu ( bỏ đi các từ phía trước không cần thiết )
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiem,'Lên đến','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiem,'Trên','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiem,'Dưới','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiem,'Hơn','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiem,'đến','-') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiem,'một','1') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiem,'Từ','') ;

-- Bước 2: Sử dụng hàm cast, substring_index để lấy ra min max và tính trung bình
	update ignore Stg_ThongTin
    set 
		KinhNghiemMin = cast(substring_index(KinhNghiemETL,'-',1) as Decimal(5,2)), -- Min
		KinhNghiemMax = cast(substring_index(KinhNghiemETL,'-',-1) as Decimal(5,2)), -- Max
        KinhNghiemTB = (KinhNghiemMin + KinhNghiemMax)/2;
-- Bước 3: Update các trường hợp kinh nghiệm 'Tháng'
	Update ignore Stg_ThongTin
    set 
		KinhNghiemMin = KinhNghiemMin /12,
        KinhNghiemMax = KinhNghiemMax /12,
        KinhNghiemTB  = KinhNghiemTB /12
	where (KinhNghiemETL like  '%Tháng' or KinhNghiemETL like '%Tháng%');
-- Bước cuối: Update các TH KinhNghiem Min, Max = 0.0 -> Không yêu cầu 


END