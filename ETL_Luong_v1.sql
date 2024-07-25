CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_Luong_v1`()
BEGIN
	/*v3.0 2024.2.19
- Cập nhật thêm ETL Lương theo ngành*/
-- Bước 1: ETL ( Loại bỏ những thành phần không phải số )
update Stg_ThongTin set LuongETL = Luong  WHERE LuongETL is NULL;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Lên đến','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Lên tới','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Tới','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Dưới','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Từ','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Trên','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Đến','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,',','') WHERE Luong like '%USD%' or Luong like 'USD%' or Luong like '%USD'  ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'.','')	WHERE  Luong like '%USD%' or Luong like 'USD%' or Luong like '%USD' ;/*bị nhầm phần Lương 1.5 triêu => 15 triệu*/
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'"','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'VND','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'USD','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'IDR','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'$','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Upto','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'upto','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'to','-') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'up to','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'Mức lương:   ','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'From','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'hấp dẫn từ','') ;
update ignore Stg_ThongTin set LuongETL = replace(LuongETL,'đến','-') ;


	
-- Bước 2: Sử dụng cast và substring để tách ra min max và lương trung bình
	update ignore Stg_ThongTin
    set 
		LuongMin = cast(substring_index(LuongETL,'-',1) as Decimal(12,2)),
        LuongMax = cast(substring_index(LuongETL,'-',-1) as Decimal(12,2)),
        LuongTB = (LuongMin+LuongMax)/2;
	 -- WHERE LuongTB is NULL;

-- Bước 3: Xử lý các trường hợp 12000000-23000000
		update ignore Stg_ThongTin
		set 
			LuongMin = LuongMin * 0.000001,
			LuongTB  = LuongTB  * 0.000001,
			LuongMax = LuongMax * 0.000001
		where (LuongMax >= 500000 or LuongMin >= 500000) ;

-- Bước 4: Xử lý Luong USD 
	-- Note: Lương USD thường chỉ nằm trong khoảng từ 350 - > 10000 (mười nghìn đô - level khá ok) nên
    -- nhân LuongMin,LuongMax,LuongTB với 0.024 - tỷ giá đô hiện tại 
		update ignore Stg_ThongTin
        set 
			LuongMin = LuongMin * 0.024,
            LuongMax = LuongMax * 0.024,
            LuongTB  = LuongTB  * 0.024
		where Luong like '%USD%' or Luong like 'USD%' or Luong like '%USD' 
			or Luong like '%$%' or Luong like '$%' or Luong like '%$' ;

-- Bước 5: Xử lý nhiễu 
-- Cập nhật LuongMin, LuongMax của những tin tuyển dụng không có Lương theo TB Vitri, Capbac, Kinhnghiem
    UPDATE Stg_ThongTin t1
    JOIN (
        SELECT AVG(LuongMin) as LuongMinTB, ID_ViTri, ID_CapBac, ID_KinhNghiem
        FROM Stg_ThongTin t3
        WHERE NOT (t3.Luong  = 'Thoả thuận' OR t3.Luong = 'Cạnh tranh' OR t3.Luong = ' '
			OR t3.Luong is null OR t3.Luong = 'Thương lượng' OR t3.LuongMin=0 
			OR t3.Luong like '%tranh%' OR t3.Luong like '%thoa%' OR t3.Luong like '%Cap%'
			OR t3.Luong like '%Thuong%' OR t3.Luong like 'Negotiable' OR t3.Luong like '0 - 0')
        GROUP BY t3.ID_ViTri, t3.ID_CapBac, ID_KinhNghiem
    ) t2 ON(t2.ID_ViTri = t1.ID_ViTri AND t2.ID_CapBac = t1.ID_CapBac AND t2.ID_KinhNghiem = t2.ID_KinhNghiem)
    SET t1.LuongMin = t2.LuongMinTB
    WHERE (t1.Luong  = 'Thoả thuận' OR t1.Luong = 'Cạnh tranh' OR t1.Luong = ' ' OR t1.Luong = ''
	OR t1.Luong is null OR t1.Luong = 'Thương lượng' OR t1.Luong like  '%Cập nhật%' 
	OR t1.Luong = 'Không có' OR t1.Luong like '%tranh%' OR t1.Luong like '%thoa%' OR t1.LuongMin = 0
	OR t1.Luong like '%Cap%' OR t1.Luong like '%Thuong%' OR t1.Luong like 'Negotiable' );
--    ---------------------
    UPDATE Stg_ThongTin t1
    JOIN (
        SELECT AVG(LuongMax) as LuongMaxTB, ID_ViTri, ID_CapBac, ID_KinhNghiem
        FROM Stg_ThongTin t3 
        WHERE NOT (t3.Luong  = 'Thoả thuận' OR t3.Luong = 'Cạnh tranh' OR t3.Luong = ' '
			OR t3.Luong is null OR t3.Luong = 'Thương lượng' OR t3.LuongMin=0 
			OR t3.Luong like '%tranh%' OR t3.Luong like '%thoa%' OR t3.Luong like '%Cap%'
			OR t3.Luong like '%Thuong%' OR t3.Luong like 'Negotiable' OR t3.Luong like '0 - 0')
		 GROUP BY t3.ID_ViTri, t3.ID_CapBac, ID_KinhNghiem
    ) t2 ON (t2.ID_ViTri = t1.ID_ViTri AND t2.ID_CapBac = t1.ID_CapBac AND t2.ID_KinhNghiem = t1.ID_KinhNghiem)
    SET t1.LuongMax = t2.LuongMaxTB
    WHERE (t1.Luong  = 'Thoả thuận' OR t1.Luong = 'Cạnh tranh' OR t1.Luong = ''
	OR t1.Luong is null OR t1.Luong = 'Thương lượng' OR t1.Luong like  '%Cập nhật%' 
	OR t1.Luong = 'Không có' OR t1.Luong like '%tranh%' OR t1.Luong like '%thoa%' OR t1.LuongMax = 0
	OR t1.Luong like '%Cap%' OR t1.Luong like '%Thuong%' OR t1.Luong like 'Negotiable' );
        
-- Cập nhật Lương min trong các trường hợp không có
	update Stg_ThongTin set LuongMin = LuongMax/1.5  
    where (Luong like 'Lên đến%'
	or Luong like 'Lên tới%'
    or Luong like 'Tới%'
    or Luong like 'Dưới%'
	or Luong LIKE 'upto%'
	or Luong LIKE 'Đến%')
    and LuongMin = LuongMax;
-- --------------------------
    update Stg_ThongTin set LuongMax= LuongMin*1.5  
    where (Luong like 'Từ%'
	or Luong like 'Trên%')
    and LuongMin = LuongMax;

-- Cập nhật Lương max = Luong Min trong trường hợp khuyết 1 trong hai bên
	update Stg_ThongTin set LuongMax = LuongMin where LuongMax = 0;
    update Stg_ThongTin set LuongMin = LuongMax where LuongMin = 0;
-- Cập nhật lại khi LuongMin > LuongMax
	update Stg_ThongTin t1 
    join (select t2.ID, t2.LuongMin, t2.LuongMax from Stg_ThongTin t2
		where LuongMin > LuongMax) t3 ON t3.ID = t1.ID
	set t1.LuongMin = t3.LuongMax, t1.LuongMax = t3.LuongMin;
-- Tính lại LuongTB bằng (LuongMin+LuongMax)/2
	update Stg_ThongTin set LuongTB = (LuongMin + LuongMax)/2;

END