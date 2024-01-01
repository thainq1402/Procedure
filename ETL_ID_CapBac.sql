CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_CapBac`()
BEGIN
-- v2.0 22-12-2023 Nguyễn Quốc Thái

-- Bước 1: Thực hiện Mapping
update Stg_ThongTin t1
join Stg_CapBacMap t2 on  ( t1.CapBac = t2.CapBacWeb and t1.Web = t2.Web)
set t1.ID_CapBac = t2.ID_CapBac;

-- Bước 2: Thực hiện xử lý các trường hợp không có cấp bậc theo năm kinh nghiệm

UPDATE Stg_ThongTin t1
JOIN Dim_KinhNghiem t2 ON t1.KinhNghiemTB BETWEEN t2.Min AND t2.Max
SET t1.ID_CapBac = 
    CASE 
        WHEN t2.ID_KinhNghiem = 1 THEN 1
        WHEN t2.ID_KinhNghiem = 2 THEN 2
        ELSE t1.ID_CapBac
    END
WHERE t1.ID_CapBac = 8;
END
