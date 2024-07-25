
DELIMITER //
CREATE EVENT ETL_Stg_ThongTin_raw
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(CURRENT_DATE, '01:00:00') -- Set the time to 1:00 AM
DO
BEGIN
    CALL ETL_Tong(); -- Replace with your actual stored procedure name
END;
//
DELIMITER ;