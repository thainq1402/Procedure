CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `INSERT_Fact`()
BEGIN
   INSERT INTO Fact (Link,SoLuong,ID_Nganh,ID_NganhCon,ID_ViTri,ID_Web,ID_CongTy, ID_LoaiHinh, ID_CapBac, ID_KinhNghiem, ID_TinhThanh,
   ID_KhoangLuong, CountTin, TrangThaiTrungLap, KinhNghiemETL, KinhNghiem, KinhNghiemMin, KinhNghiemTB, KinhNghiemMax, Luong, LuongETL, LuongMin, LuongTB, LuongMax, HanNopCVDate)
   SELECT Link, SoLuong, ID_Nganh, ID_NganhCon, ID_ViTri, ID_Web, ID_CongTy, ID_LoaiHinh, ID_CapBac,
   ID_KinhNghiem, ID_TinhThanh, ID_KhoangLuong, CountTin, TrangThaiTrungLap, KinhNghiemETL, KinhNghiem, KinhNghiemMin,
   KinhNghiemTB, KinhNghiemMax, Luong, LuongETL, LuongMin, LuongTB, LuongMax, HanNopCVDate from Stg_ThongTin;

END