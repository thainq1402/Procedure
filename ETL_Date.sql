CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_Date`()
BEGIN
	update ignore Stg_Data_Raw
	set HanNopCVDate = str_to_date(hanNopCV,'%Y-%m-%d')
	where (HanNopCVDate is null or  HanNopCVDate<'1900-01-01')
    and HanNopCV <>'Không có';
    
    update ignore Stg_Data_Raw
	set HanNopCVDate = str_to_date(hanNopCV,'%d/%m/%Y')
	where (HanNopCVDate is null or  HanNopCVDate<'1900-01-01')
    and HanNopCV <>'Không có';
    
    update ignore Stg_Data_Raw
	set HanNopCVDate = str_to_date(hanNopCV,'%d-%m-%Y')
	where (HanNopCVDate is null or  HanNopCVDate<'1900-01-01')
    and HanNopCV <>'Không có';
END