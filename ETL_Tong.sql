CREATE PROCEDURE `ETL_Tong` ()
-- v1.0 Thực hiện : Nguyễn Quốc Thái
BEGIN
-- 1. Thực hiện update ID_Nganh,ID_NganhCon,ID_ViTri 
    CALL ETL_Jobs();
    CALL ETL_ID_CapBac();
    CALL ETL_ID_LoaiHinh();
    CALL ETL_ID_CongTy();
    CALL ETL_ID_TinhThanh();
    CALL ETL_ID_Web();
    CALL ETL_TrungLap();
    CALL ETL_KinhNghiem();
    CALL ETL_Luong();
    CALL ETL_YeuCau();
-- 1. Thực hiện update các ID_Nganh, ID_NganhCon, ID_ViTri 


    
END
