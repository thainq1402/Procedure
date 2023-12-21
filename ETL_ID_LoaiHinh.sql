CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_LoaiHinh`()
BEGIN
    update Stg_ThongTin t1
    join  Stg_LoaiHinhMap t2 on t1.LoaiHinh = t2.LoaiHinh_Web
    set t1.ID_LoaiHinh = t2.ID_LoaiHinh;
END