CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_Luong`()
BEGIN
	/*v3.0 2023.12.16
- Cập nhật thêm ETL Lương theo ngành*/
-- Bước 1: ETL ( Loại bỏ những thành phần không phải số )
update Stg_Data_Raw set LuongETL = Luong  WHERE LuongETL is NULL;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Lên đến','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Lên tới','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Tới','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Dưới','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Từ','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Trên','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Đến','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,',','') WHERE Luong like '%USD%' or Luong like 'USD%' or Luong like '%USD'  ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'.','')	WHERE  Luong like '%USD%' or Luong like 'USD%' or Luong like '%USD' ;/*bị nhầm phần Lương 1.5 triêu => 15 triệu*/
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'"','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'VND','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'USD','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'IDR','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'$','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Upto','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'upto','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'to','-') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'up to','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'Mức lương:','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'From','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'hấp dẫn từ','') ;
update ignore Stg_Data_Raw set LuongETL = replace(LuongETL,'đến','-') ;


	
-- Bước 2: Sử dụng cast và substring để tách ra min max và lương trung bình
	update ignore Stg_Data_Raw
    set 
		LuongMin = cast(substring_index(LuongETL,'-',1) as Decimal(12,2)),
        LuongMax = cast(substring_index(LuongETL,'-',-1) as Decimal(12,2)),
        LuongTB = (LuongMin+LuongMax)/2
	 WHERE LuongTB is NULL;

-- Bước 3: Xử lý các trường hợp 12000000-23000000
		update ignore Stg_Data_Raw
		set 
			LuongMin = LuongMin * 0.000001,
			LuongTB  = LuongTB  * 0.000001,
			LuongMax = LuongMax * 0.000001
		where (LuongMax >= 500000 or LuongMin >= 500000) ;

-- Bước 4: Xử lý Luong USD 
	-- Note: Lương USD thường chỉ nằm trong khoảng từ 350 - > 10000 (mười nghìn đô - level khá ok) nên
    -- nhân LuongMin,LuongMax,LuongTB với 0.024 - tỷ giá đô hiện tại 
		update ignore Stg_Data_Raw
        set 
			LuongMin = LuongMin * 0.024,
            LuongMax = LuongMax * 0.024,
            LuongTB  = LuongTB  * 0.024
		where Luong like '%USD%' or Luong like 'USD%' or Luong like '%USD' 
			or Luong like '%$%' or Luong like '$%' or Luong like '%$' ;

-- Bước 5: Xử lý nhiễu 
-- Cập nhật LuongMin, LuongMax của những tin tuyển dụng không có Lương theo TB Ngành Con,Cấp bậc, Vị trí
	UPDATE Stg_Data_Raw t1
	join (
		SELECT AVG(LuongMin) as LuongMinTB,ID_NganhCon,ID_CapBac,ID_ViTri
		FROM Stg_Data_Raw t3
		WHERE not (t3.Luong  = 'Thoả thuận' or t3.Luong = 'Cạnh tranh' or t3.Luong = ' '
			or t3.Luong is null or t3.Luong = 'Thương lượng' or t3.LuongMin=0 
			or t3.Luong like '%tranh%' or t3.Luong like '%thoa%' or t3.Luong like '%Cap%'
			or t3.Luong like '%Thuong%' or t3.Luong like 'Negotiable' or t3.Luong like '0 - 0')
		GROUP BY t3.ID_NganhCon,t3.ID_CapBac,t3.ID_ViTri
	)t2  on (t2.ID_NganhCon = t1.ID_NganhCon and t2.ID_CapBac = t1.ID_CapBac and t2.ID_ViTri = t1.ID_ViTri)
	set t1.LuongMin = t2.LuongMinTB 
	where (t1.Luong  = 'Thoả thuận' or t1.Luong = 'Cạnh tranh' or t1.Luong = ' '
	or t1.Luong is null or t1.Luong = 'Thương lượng' or t1.Luong like  '%Cập nhật%' 
	or t1.Luong = 'Không có' or t1.Luong like '%tranh%' or t1.Luong like '%thoa%' or t1.LuongMin = 0
	or t1.Luong like '%Cap%' or t1.Luong like '%Thuong%' or t1.Luong like 'Negotiable' );
--    ---------------------
	UPDATE Stg_Data_Raw t1
	join (
		SELECT AVG(LuongMax) as LuongMaxTB,ID_NganhCon,ID_CapBac,ID_ViTri
		FROM Stg_Data_Raw t3
		WHERE not (t3.Luong  = 'Thoả thuận' or t3.Luong = 'Cạnh tranh' or t3.Luong = ' '
			or t3.Luong is null or t3.Luong = 'Thương lượng' or t3.LuongMax=0 
			or t3.Luong like '%tranh%' or t3.Luong like '%thoa%' or t3.Luong like '%Cap%'
			or t3.Luong like '%Thuong%' or t3.Luong like 'Negotiable' or t3.Luong like '0 - 0')
		GROUP BY t3.ID_NganhCon,t3.ID_CapBac,t3.ID_ViTri
	)t2  on (t2.ID_NganhCon = t1.ID_NganhCon and t2.ID_CapBac = t1.ID_CapBac and t2.ID_ViTri = t1.ID_ViTri)
	set t1.LuongMax = t2.LuongMaxTB 
	where (t1.Luong  = 'Thoả thuận' or t1.Luong = 'Cạnh tranh' or t1.Luong = ' '
	or t1.Luong is null or t1.Luong = 'Thương lượng' or t1.Luong like  '%Cập nhật%' 
	or t1.Luong = 'Không có' or t1.Luong like '%tranh%' or t1.Luong like '%thoa%' or t1.LuongMax = 0
	or t1.Luong like '%Cap%' or t1.Luong like '%Thuong%' or t1.Luong like 'Negotiable' );

-- Bổ sung, chuẩn hoá các bản ghi có mức lương trung bình  =0 
UPDATE Stg_Data_Raw t1
	JOIN (
		SELECT 
			t3.ID_CapBac, 
			t3.ID_ViTri, 
			AVG(t3.LuongMin) AS LuongMin, 
			AVG(t3.LuongTB) AS LuongTB, 
			AVG(t3.LuongMax) AS LuongMax 
		FROM Fact_back_up t3
		WHERE t3.ID_CapBac != 8 and t3.ID_CapBac !=6
		  AND t3.ID_ViTri IS NOT NULL 
		  AND t3.ID_CapBac IS NOT NULL
		GROUP BY t3.ID_CapBac, t3.ID_ViTri
	) t2 
	ON t1.ID_CapBac = t2.ID_CapBac 
	AND t1.ID_ViTri = t2.ID_ViTri
	SET 
		t1.LuongMin = t2.LuongMin, 
		t1.LuongTB = t2.LuongTB, 
		t1.LuongMax = t2.LuongMax
	WHERE t1.LuongTB IS NULL 
	   OR t1.LuongTB = 0;
    
-- Cập nhật Lương min trong các trường hợp không có
	update Stg_Data_Raw set LuongMin = LuongMax/1.5  
    where (Luong like 'Lên đến%'
	or Luong like 'Lên tới%'
    or Luong like 'Tới%'
    or Luong like 'Dưới%'
	or Luong LIKE 'upto%'
	or Luong LIKE 'Đến%')
    and LuongMin = LuongMax;
-- --------------------------
    update Stg_Data_Raw set LuongMax= LuongMin*1.5  
    where (Luong like 'Từ%'
	or Luong like 'Trên%')
    and LuongMin = LuongMax;

-- Cập nhật Lương max = Luong Min trong trường hợp khuyết 1 trong hai bên
	update Stg_Data_Raw set LuongMax = LuongMin where LuongMax = 0;
    update Stg_Data_Raw set LuongMin = LuongMax where LuongMin = 0;

-- Tính lại LuongTB bằng (LuongMin+LuongMax)/2
	update Stg_Data_Raw set LuongTB = (LuongMin + LuongMax)/2;
-- Cập nhật theo Dim_Luong 
	update Stg_Data_Raw t1
	join Dim_KhoangLuong t2 on t1.LuongTB between t2.LuongMin and t2.LuongMax
	set t1.ID_KhoangLuong = t2.KhoangLuongID;
END