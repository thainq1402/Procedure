CREATE DEFINER=`dulieutu`@`%` PROCEDURE `ETL_1`()
BEGIN
-- ETL Nganh IT
	call ETL_Nganh_IT();
-- ------------
    call ETL_ID_ViTri_IT();
	call ETL_ID_CapBac();
    call ETL_ID_CongTy();
    call ETL_ID_LoaiHinh();
    call ETL_ID_TinhThanh();
    call ETL_ID_Web();
    call ETL_KinhNghiem();
    call ETL_Luong();
    call ETL_TrangThaiTrungLap();
    call ETL_ViTri_IT();
    call ETL_NganhCon_IT();

END