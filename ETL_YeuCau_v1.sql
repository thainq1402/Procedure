CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_YeuCau`()
BEGIN
-- Bước 1: Lấy các ID có chứa các Hastag

	declare done int default false;
    declare hastag_value varchar(50); 
    declare	cur cursor for select HastagName from Stg_Hastag; 
    declare continue handler for not found set done = true;
    
	TRUNCATE TABLE Stg_HastagChiTiet;

    
    open cur;
    read_loop: LOOP
		fetch cur into hastag_value;
        -- select hastag_value; 
		if done then 
			leave read_loop;
		end if;
        
        -- insert the match records into the temporary table 
        insert ignore into Stg_HastagChiTiet (ID,HastagName)
        select ID, cast(hastag_value as CHAR CHARACTER set utf8mb4)
        from Stg_ThongTin_raw
        where lower(YeuCau) like ConCat('%',lower(hastag_value),'%');
	end loop;
    close cur;

    -- Bước 2: Tạo mới bảng  Dim_YeuCau 
	TRUNCATE TABLE Dim_YeuCau;
    
    insert into Dim_YeuCau 
	select t1.ID,t4.NhomYeuCau_1 ,t4.NhomYeuCau_2, t4.YeuCau 
	from (Stg_HastagChiTiet t1
	join (
	select * from Stg_Hastag t2 
    join Stg_HasTagMappingYeuCau t3 using(HastagName)) t4 using (HastagName));

END


