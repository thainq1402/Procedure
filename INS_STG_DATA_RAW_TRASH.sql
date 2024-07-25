CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `INS_STG_DATA_RAW_TRASH`()
BEGIN
-- Bước 1: Đỏ dữ liệu vào bảng Trash 
INSERT IGNORE INTO Trash
SELECT *
FROM 
    Stg_Data_Raw t1
WHERE NOT 
    (t1.Link IS NOT NULL 
    AND t1.SoLuong IS NOT NULL 
    AND t1.ID_Nganh IS NOT NULL
    AND t1.ID_NganhCon IS NOT NULL 
    AND t1.ID_ViTri IS NOT NULL 
    AND t1.ID_Web IS NOT NULL 
    AND t1.ID_CongTy IS NOT NULL 
    AND t1.ID_LoaiHinh IS NOT NULL 
    AND t1.ID_CapBac IS NOT NULL 
    AND t1.ID_KinhNghiem IS NOT NULL 
    AND t1.ID_TinhThanh IS NOT NULL 
    AND t1.ID_CapBac IS NOT NULL 
    AND t1.ID_KinhNghiem IS NOT NULL 
    AND t1.ID_TinhThanh IS NOT NULL 
    AND t1.KinhNghiemMin IS NOT NULL 
	AND t1.KinhNghiemTB != 0
    AND t1.KinhNghiemMax IS NOT NULL 
    AND t1.KinhNghiemTB IS NOT NULL 
    AND t1.LuongMin IS NOT NULL 
    AND t1.LuongMax IS NOT NULL 
    AND t1.LuongTB IS NOT NULL 
	AND t1.LuongTB != 0 
    AND t1.HanNopCVDate IS NOT NULL);
END