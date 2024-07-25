CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_CongTy`()
BEGIN
-- v2.0 22-12-2023 Nguyễn Quốc Thái

	-- 1. Insert các công ty ở bảng Stg_ThongTin chưa có trong Dim_CongTy vào bảng Dim_CongTy 
	insert into Dim_CongTy (CongTy)
    select distinct t1.CongTy from Stg_ThongTin_raw t1 
    left join Dim_CongTy t2 on t1.CongTy = t2.CongTy 
    where t2.CongTy is null;
	

	-- 2.Update ID_CongTy in Stg_ThongTin_raw 
	UPDATE Stg_ThongTin_raw t1
	INNER JOIN Dim_CongTy t2 using(CongTy)
	SET t1.ID_CongTy = t2.ID_CongTy
    where t1.ID_CongTy is null;
	-- WHERE t1.ID_Nganh = 2;
        
END