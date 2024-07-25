CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_LoaiHinh`()
BEGIN
-- ver 1.0 22-12-2023 Nguyen Quoc Thai
-- Buoc 1: Insert các Loại hình ở bảng Stg_ThongTin_raw mà chưa có trong Stg_LoaiHinhMap vào Stg_LoaiHinhMap 
	insert into Stg_LoaiHinhMap  (LoaiHinh_Web)
	select distinct  t2.LoaiHinh from Stg_ThongTin_raw t2
    left join Stg_LoaiHinhMap t1 on t1.LoaiHinh_Web = t2.LoaiHinh 
    where t1.LoaiHinh_Web is null;

-- Bước 2: Update các ID_LoaiHinh trong bảng Stg_ThongTin_raw 
    update Stg_ThongTin_raw t1
    join  Stg_LoaiHinhMap t2 on t1.LoaiHinh = t2.LoaiHinh_Web
    set t1.ID_LoaiHinh = t2.ID_LoaiHinh
   -- where t1.ID_LoaiHinh is null and t1.ID_Nganh = 2;
	 where t1.ID_LoaiHinh is null;
END