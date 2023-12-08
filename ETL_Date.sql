CREATE DEFINER=`dulieutu`@`%` PROCEDURE `ETL_Date`()
BEGIN
	update ignore dulieutu_TTTuyenDung.Stg_ThongTin
	set HanNopCVDate = str_to_date(hanNopCV,'%Y-%m-%d')
	where HanNopCVDate is null;

	update ignore dulieutu_TTTuyenDung.Stg_ThongTin
	set HanNopCVDate = str_to_date(hanNopCV,'%d/%m/%Y')
	where HanNopCVDate is null;
END