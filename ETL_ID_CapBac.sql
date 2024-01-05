CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_CapBac`()
BEGIN
-- v2.0 22-12-2023 Nguyễn Quốc Thái

-- Bước 1: Thực hiện Mapping
update Stg_ThongTin t1
join Stg_CapBacMap t2 on  ( t1.CapBac = t2.CapBacWeb and t1.Web = t2.Web)
set t1.ID_CapBac = t2.ID_CapBac;

-- Bước 2: Xử lý Cấp bậc không có
-- Các web không có cấp bậc sẽ tìm trong tên chứa những key word về cấp bậc: TechWorks, Joboko, StudentJob

-- Bước 2: Thực hiện xử lý các trường hợp không có cấp bậc theo năm kinh nghiệm
-- tinh chỉnh Cấp bậc dựa trên năm kinh nghiệm 
    -- ETl Luong chính xác hơn
    -- Cấp bậc sẽ chính xác hơn 
    -- từ 3 - 5 năm phải có cách xử lý khác 
    


UPDATE Stg_ThongTin t1
JOIN Dim_KinhNghiem t2 ON t1.KinhNghiemTB BETWEEN t2.Min AND t2.Max
SET t1.ID_CapBac = 
    CASE 
        WHEN t2.ID_KinhNghiem = 1 THEN 1 -- Không yêu cầu 
        WHEN t2.ID_KinhNghiem = 2 THEN 2
        ELSE t1.ID_CapBac
    END
WHERE t1.ID_CapBac = 8;

UPDATE Stg_ThongTin t1 
SET ID_CapBac = 
    CASE 
        WHEN KinhNghiemTB BETWEEN 1 AND 2 THEN 2 -- 1 - 2 năm kinh nghiệm - fresher
        WHEN KinhNghiemTB BETWEEN 2 AND 3 THEN 3 -- 2 - 3 năm kinh nghiệm - junior 
        WHEn KinhNghiemTB BETWEEN 3 AND 4 THEN 
        ELSE  
    END
WHERE ID_CapBac = 8


END
