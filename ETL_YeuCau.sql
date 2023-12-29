CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_YeuCau`()
SET NAMES utf8;
BEGIN
	declare done int default false;
    declare hastag_value varchar(50); 
    declare	cur cursor for select HastagName from Stg_Hastag; 
    declare continue handler for not found set done = true;
    
    drop table if exists Stg_HastagChiTiet;
    
    create table Stg_HastagChiTiet(
    ID int(11),
    Hastag varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci);
    
    select 1;
    
    open cur;
    read_loop: LOOP
		fetch cur into hastag_value;
        select hastag_value; 
		if done then 
			leave read_loop;
		end if;
        
        -- insert the match records into the temporary table 
        insert ignore into Stg_HastagChiTiet (ID,Hastag)
        select ID, cast(hastag_value as CHAR CHARACTER set utf8mb4)
        from Stg_ThongTin
        where lower(YeuCau) like ConCat('%',lower(hastag_value),'%');
	end loop;
    close cur;
END


