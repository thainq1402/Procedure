CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_Nganh`()
BEGIN
		/*1. ETL thô các ngành dựa trên ngành mà web tự phân
        Mình làm bảng mapping giữa ngành trên web và Dim Nganh của hệ thống*/

        /*Procedure 
            1.UPDATE các CV có ID_Nganh = 6 hoặc NULL vào các Ngành được phân trong hệ thống */

		UPDATE Stg_ThongTin t 
        LEFT JOIN (SELECT * FROM Stg_NganhMap WHERE ID_Nganh <> 6) n on t.Nganh = n.Nganh_Web 
        SET t.ID_Nganh = n.ID_Nganh 
        WHERE ID_Nganh = 6 or ID_Nganh is NULL;
        
END
