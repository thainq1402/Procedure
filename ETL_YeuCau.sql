CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_YeuCau`()
BEGIN


-- Bước 1: Lấy các ID có chứa các Hastag

	declare done int default false;
    declare hastag_value varchar(50); 
    declare	cur cursor for select HastagName from Stg_Hastag; 
    declare continue handler for not found set done = true;
    
	TRUNCATE TABLE Stg_HastagChiTiet;
    
-- Bước 0: Cập nhật lại các Hastag mới thêm trong bảng Stg_HastagMappingYeuCau
    INSERT INTO Stg_Hastag 
    SELECT DISTINCT t2.HastagName FROM Stg_HastagMappingYeuCau t2
    LEFT JOIN Stg_Hastag t1 USING (HastagName)
    WHERE t1.HastagName is NULL;

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
        from Stg_ThongTin
        where lower(YeuCau) like ConCat('%',lower(hastag_value),'%');
	end loop;
    close cur;

    -- Bước 2: Tạo mới bảng  Dim_YeuCau 
	TRUNCATE TABLE Dim_YeuCau;
    
    INSERT INTO Dim_YeuCau 
    SELECT t1.ID, t2.NhomYeuCau_1, t2.NhomYeuCau_2, t2.NhomYeuCau_3, t2.ID_Nganh, t2.YeuCau 
    from Stg_HastagChiTiet t1
    JOIN Stg_HasTagMappingYeuCau t2 USING (HastagName);



END