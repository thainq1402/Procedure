CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_NganhCon_IT`()
/*Procedure sẽ cập nhật cột NganhCon trong bảng Stg_ThongTin dựa trên ID_NganhCon
Thực hiện: Nguyễn Quốc Thái */

BEGIN
    UPDATE Stg_ThongTin t1 
    INNER JOIN Dim_NganhCon t2 USING(ID_NganhCon)
    SET t1.NganhCon = t2.NganhCon;
END
