CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_CongTy`()
BEGIN
	-- 1. drop table if exist 
	drop table if exists Dim_CongTy ;
    
	-- 2. create table Dim_CongTy 
    CREATE TABLE Dim_CongTy (
    ID_CongTy INT AUTO_INCREMENT PRIMARY KEY,
    CongTy VARCHAR(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
	);

	-- 3. select distinct CongTy from Stg_ThongTin to Dim_CongTy
	INSERT INTO Dim_CongTy (CongTy)
	SELECT DISTINCT CongTy FROM Stg_ThongTin;
	-- WHERE ID_Nganh = 2;


	-- 4.Update ID_CongTy in Stg_ThongTin 
	UPDATE Stg_ThongTin t1
	INNER JOIN Dim_CongTy t2 using(ID_CongTy)
	SET t1.ID_CongTy = t2.ID_CongTy;
	-- WHERE t1.ID_Nganh = 2;
    
END