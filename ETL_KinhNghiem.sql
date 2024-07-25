CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_KinhNghiem`()
BEGIN
-- Ver 1.0 2023-18-12
-- Thực hiện: Nguyễn Quốc Thái 

-- Bước 0: Set cột KinhNghiemETL = KinhNghiem
	update Stg_Data_Raw set KinhNghiemETL = KinhNghiem where KinhNghiemETL is null;
-- Bước 1: ETL Dữ liệu ( bỏ đi các từ phía trước không cần thiết )
	-- update chỉ cập nhật Kinh Nghiem mới đổ vào csdl
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'Kinh nghiệm:','') ;
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'Kinh nghiệm','') ;
    update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'kinh nghiệm','');
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'Lên đến','');
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'Trên','') ;
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'Dưới','') ;
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'Hơn','') ;
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'đến','-') ;
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'một','1') ;
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'Từ','') ;
	update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'Trên','') ;
    update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'>','');
    update Stg_Data_Raw set  KinhNghiemETL= replace(KinhNghiemETL,'<','');
	
	

-- Bước 2: Sử dụng hàm cast, substring_index để lấy ra min max và tính trung bình
	-- update chỉ cập nhật Kinh Nghiem mới đổ vào csdl
	update ignore Stg_Data_Raw
    set 
		KinhNghiemMin = cast(substring_index(KinhNghiemETL,'-',1) as Decimal(5,2)), -- Min
		KinhNghiemMax = cast(substring_index(KinhNghiemETL,'-',-1) as Decimal(5,2)), -- Max
        KinhNghiemTB = (KinhNghiemMin + KinhNghiemMax)/2;
-- Bước 3: Update các trường hợp kinh nghiệm 'Tháng'
	Update ignore Stg_Data_Raw
    set 
		KinhNghiemMin = KinhNghiemMin /12,
        KinhNghiemMax = KinhNghiemMax /12,
        KinhNghiemTB  = KinhNghiemTB /12
	where (KinhNghiemETL like  '%Tháng' or KinhNghiemETL like '%Tháng%');
-- Bước 4:update KinhNghiemMin,KinhNghiemMax  của những tin tuyển dụng không có KinhNghiemMin,KinhNghiemMax theo Cấp bậc và theo ngành con 

-- KinhNghiemMin
	update Stg_Data_Raw t1
	join (
			select AVG(KinhNghiemMin) as KinhNghiemMinTB, ID_CapBac, ID_ViTri from Stg_Data_Raw t2 
			where not (t2.KinhNghiem is null or t2.KinhNghiem = 'Không có' or t2.KinhNghiem = 'Không yêu cầu kinh nghiệm' 
			or t2.KinhNghiem = 'Tất cả kinh nghiệm' or t2.KinhNghiem = 'Chưa có kinh nghiệm' or t2.KinhNghiemMin =0 or t2.KinhNghiem = ' ' 
			or t2.Kinhnghiem like '%cập%') 
			group by t2.ID_CapBac, t2.ID_ViTri
            ) t3 on ( t3.ID_CapBac = t1.ID_CapBac and t3.ID_ViTri = t1.ID_ViTri ) 
		set t1.KinhNghiemMin  = t3.KinhNghiemMinTB
		where (t1.KinhNghiem is null or t1.KinhNghiem = 'Không có' or t1.KinhNghiem = 'Không yêu cầu kinh nghiệm' or t1.KinhNghiemMin = 0
		or t1.KinhNghiem = 'Tất cả kinh nghiệm' or t1.KinhNghiem = 'Chưa có kinh nghiệm' or t1.KinhNghiem = ' ' or t1.Kinhnghiem like '%cập%');
        
-- KinhNghiemMax
	update Stg_Data_Raw t1
	join (
			select AVG(KinhNghiemMax) as KinhNghiemMaxTB, ID_CapBac, ID_ViTri from Stg_Data_Raw t2 
			where not (t2.KinhNghiem is null or t2.KinhNghiem = 'Không có' or t2.KinhNghiem = 'Không yêu cầu kinh nghiệm' 
			or t2.KinhNghiem = 'Tất cả kinh nghiệm' or t2.KinhNghiem = 'Chưa có kinh nghiệm' or t2.KinhNghiemMax = 0 or t2.KinhNghiem = ' '
			or t2.Kinhnghiem like '%cập%') 
			group by t2.ID_CapBac, t2.ID_ViTri
            ) t3 on ( t3.ID_CapBac = t1.ID_CapBac and t3.ID_ViTri = t1.ID_ViTri ) 
		set t1.KinhNghiemMax  = t3.KinhNghiemMaxTB
		where (t1.KinhNghiem is null or t1.KinhNghiem = 'Không có' or t1.KinhNghiem = 'Không yêu cầu kinh nghiệm' or t1.KinhNghiemMax = 0
		or t1.KinhNghiem = 'Tất cả kinh nghiệm' or t1.KinhNghiem = 'Chưa có kinh nghiệm' or t1.KinhNghiem = ' ' or  t1.Kinhnghiem like '%cập%');
        
-- Bước 5: Cập nhật KinhNghiemMin cho các trường hợp không có 
	update Stg_Data_Raw 
    set KinhNghiemMin = KinhNghiemMax/1.8 
    where (
		KinhNghiem like 'Lên đến%'
        or KinhNghiem like 'dưới %');
	-- Cập nhật KinhNghiemMax cho các trường hợp không có 
	update Stg_Data_Raw 
    set KinhNghiemMax = KinhNghiemMin * 1.8
    where (
		KinhNghiem like 'lên đến%'
        or KinhNghiem like 'trên%'
        or KinhNghiem like 'hơn%'
    );
-- Bước 6: Cập nhật KinhNghiemMax = KinhNghiemMin trong trường hợp khuyết 1 trong 2 bên 
	update Stg_Data_Raw set KinhNghiemMin = KinhNghiemMax where	KinhNghiemMin = 0;
    update Stg_Data_Raw set KinhNghiemMax = KinhNghiemMin where KinhNghiemMax = 0;
-- Bước 6: Bổ sung xử lý các trường hợp có KinhNghiemTB  = 0. Set các giá trị của trường KinhNghiemMin, KinhNghiemTB, KinhNghiemMax bằng các giá 
-- trị trung bình của các dữ liệu ở bảng đã chuẩn hoá trước đó.
	UPDATE Stg_Data_Raw t1
	JOIN (
		SELECT 
			t3.ID_CapBac, 
			t3.ID_ViTri, 
			AVG(t3.KinhNghiemMin) AS KNMin, 
			AVG(t3.KinhNghiemTB) AS KNTB, 
			AVG(t3.KinhNghiemMax) AS KNMax 
		FROM Fact_back_up t3
		WHERE t3.ID_CapBac != 8 and t3.ID_CapBac != 6
		  AND t3.ID_ViTri IS NOT NULL 
		  AND t3.ID_CapBac IS NOT NULL
		GROUP BY t3.ID_CapBac, t3.ID_ViTri
	) t2 
	ON t1.ID_CapBac = t2.ID_CapBac 
	AND t1.ID_ViTri = t2.ID_ViTri
	SET 
		t1.KinhNghiemMin = t2.KNMin, 
		t1.KinhNghiemTB = t2.KNTB, 
		t1.KinhNghiemMax = t2.KNMax
	WHERE t1.KinhNghiemTB IS NULL 
	   OR t1.KinhNghiemTB = 0;
-- Bước 7: Tính lại Phần KinhNghiemTB sau khi đã update xong
	update Stg_Data_Raw set KinhNghiemTB = (KinhNghiemMin + KinhNghiemMax)/2;

-- Bước 8: Thực hiện mapping kinh nghiệm cho bảng Stg_Data_Raw 
	update Stg_Data_Raw t1
    join Dim_KinhNghiem t2 on t1.KinhNghiemTB between  t2.Min and t2.Max 
    set t1.ID_KinhNghiem = t2.ID_KinhNghiem;
    
-- Bước 9: gán các Kinh Nghiệm TB = 0 -> Không yêu cầu
	update Stg_Data_Raw t1
    set ID_KinhNghiem = 1
    where KinhNghiemTB = 0;
    
END