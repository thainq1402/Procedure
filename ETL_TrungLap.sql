CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_TrungLap`()
BEGIN
    UPDATE Stg_ThongTin_raw t1 
    JOIN (
        SELECT TenCV, ID_TinhThanh, ID_CongTy, COUNT(Link) as TrungLap
        FROM Stg_ThongTin_raw t2 
        GROUP BY ID_TinhThanh, ID_CongTy, TenCV
    ) t2 ON t1.ID_CongTy = t2.ID_CongTy AND t1.ID_TinhThanh = t2.ID_TinhThanh AND t1.TenCV = t2.TenCV 
    SET t1.CountTin = t2.TrungLap, t1.TrangThaiTrungLap = CASE WHEN t2.TrungLap > 1 THEN 1 ELSE 0 END;
END;
