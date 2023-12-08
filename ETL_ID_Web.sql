CREATE DEFINER=`dulieutu`@`%` PROCEDURE `ETL_ID_Web`()
BEGIN
	update Stg_ThongTin 
	set ID_Web = 
		case 
			when Web = 'CareerBuilder' then 1
			when Web = 'TopCv' then 2
			when Web = 'CareerLink' then 3
			when Web = 'Devwork' then 4
			when Web = 'Glints' then 5
			when Web = 'TopDev' then 6
			when Web = 'Vieclam24h' then 7
			when Web = 'Viecoi' then 8
			when Web = 'VietnamWorks' then 9
			else 0 	
			end
where ID_Nganh = 2;
END