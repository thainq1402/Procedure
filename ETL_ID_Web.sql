CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_Web`()
BEGIN
/*
    -- 1. Drop table if exists
    DROP TABLE IF EXISTS Dim_Web;
    
    -- 2. Create table Dim_Web
    CREATE TABLE `Dim_Web` (
      `ID_Web` INT(11) NOT NULL AUTO_INCREMENT,
      `Web` VARCHAR(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
      PRIMARY KEY (`ID_Web`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

    -- 3. Insert distinct values into Dim_Web
    INSERT INTO Dim_Web (`Web`)
    SELECT DISTINCT `Web` FROM Stg_Data_Raw;
*/
    -- 4. Update ID_Web from Stg_Data_Raw_raw
    UPDATE Stg_Data_Raw t1
    JOIN Dim_Web t2 ON t1.Web = t2.Web
    SET t1.ID_Web = t2.ID_Web, t1.Image = t2.Image
    WHERE t1.ID_Web is null;
END