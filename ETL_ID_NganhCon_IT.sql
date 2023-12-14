CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_NganhCon`()
BEGIN
    UPDATE Stg_ThongTin t1  
    SET ID_NganhCon = 
        CASE 
            WHEN ID_ViTri = 0  THEN 0
            WHEN ID_ViTri = 1 THEN 1
            WHEN ID_ViTri = 2 THEN 1  
            WHEN ID_ViTri = 3 THEN 1
            WHEN ID_ViTri = 4 THEN 1
            WHEN ID_ViTri = 5 THEN 1
            WHEN ID_ViTri = 6 THEN 1
            WHEN ID_ViTri = 7 THEN 1
            WHEN ID_ViTri = 8 THEN 1
            WHEN ID_ViTri = 9 THEN 2
            WHEN ID_ViTri = 10 THEN 3
            WHEN ID_ViTri = 11 THEN 4
            WHEN ID_ViTri = 12 THEN 4
            WHEN ID_ViTri = 13 THEN 4
            WHEN ID_ViTri = 14 THEN 5 
            WHEN ID_ViTri = 15 THEN 6
            WHEN ID_ViTri = 16 THEN 7
            ELSE  ID_NganhCon
            END;
END