CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_KinhNghiem`()
BEGIN
-- Ver 1.0 2023-18-12
-- Thực hiện: Nguyễn Quốc Thái 

-- Bước 0: Set cột KinhNghiemETL = KinhNghiem
	update Stg_ThongTin set KinhNghiemETL = KinhNghiem where KinhNghiemETL is null;
-- Bước 1: ETL Dữ liệu ( bỏ đi các từ phía trước không cần thiết )
	-- update chỉ cập nhật Kinh Nghiem mới đổ vào csdl
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'Kinh nghiệm:','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'Lên đến','');
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'Trên','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'Dưới','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'Hơn','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'đến','-') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'một','1') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'Từ','') ;
	update Stg_ThongTin set  KinhNghiemETL= replace(KinhNghiemETL,'Trên','') ;

-- Bước 2: Sử dụng hàm cast, substring_index để lấy ra min max và tính trung bình
	-- update chỉ cập nhật Kinh Nghiem mới đổ vào csdl
	update ignore Stg_ThongTin
    set 
		KinhNghiemMin = cast(substring_index(KinhNghiemETL,'-',1) as Decimal(5,2)), -- Min
		KinhNghiemMax = cast(substring_index(KinhNghiemETL,'-',-1) as Decimal(5,2)), -- Max
        KinhNghiemTB = (KinhNghiemMin + KinhNghiemMax)/2;
-- Bước 3: Update các trường hợp kinh nghiệm 'Tháng'
	Update ignore Stg_ThongTin
    set 
		KinhNghiemMin = KinhNghiemMin /12,
        KinhNghiemMax = KinhNghiemMax /12,
        KinhNghiemTB  = KinhNghiemTB /12
	where (KinhNghiemETL like  '%Tháng' or KinhNghiemETL like '%Tháng%');
-- Bước 4:update KinhNghiemMin,KinhNghiemMax  của những tin tuyển dụng không có KinhNghiemMin,KinhNghiemMax theo Cấp bậc và theo ngành con 

-- KinhNghiemMin
	update Stg_ThongTin t1
	join (
			select AVG(KinhNghiemMin) as KinhNghiemMinTB, ID_CapBac, ID_NganhCon from Stg_ThongTin t2 
			where not (t2.KinhNghiem is null or t2.KinhNghiem = 'Không có' or t2.KinhNghiem = 'Không yêu cầu kinh nghiệm' 
			or t2.KinhNghiem = 'Tất cả kinh nghiệm' or t2.KinhNghiem = 'Chưa có kinh nghiệm' or t2.KinhNghiemMin =0 or t2.KinhNghiem = ' ' 
			or t2.Kinhnghiem like '%cập%') 
			group by t2.ID_CapBac, t2.ID_NganhCon 
            ) t3 on ( t3.ID_CapBac = t1.ID_CapBac and t3.ID_NganhCon = t1.ID_NganhCon ) 
		set t1.KinhNghiemMin  = t3.KinhNghiemMinTB
		where (t1.KinhNghiem is null or t1.KinhNghiem = 'Không có' or t1.KinhNghiem = 'Không yêu cầu kinh nghiệm' 
		or t1.KinhNghiem = 'Tất cả kinh nghiệm' or t1.KinhNghiem = 'Chưa có kinh nghiệm' or t1.KinhNghiem = ' ' or t1.Kinhnghiem like '%cập%');
        
-- KinhNghiemMax
	update Stg_ThongTin t1
	join (
			select AVG(KinhNghiemMax) as KinhNghiemMaxTB, ID_CapBac, ID_NganhCon from Stg_ThongTin t2 
			where not (t2.KinhNghiem is null or t2.KinhNghiem = 'Không có' or t2.KinhNghiem = 'Không yêu cầu kinh nghiệm' 
			or t2.KinhNghiem = 'Tất cả kinh nghiệm' or t2.KinhNghiem = 'Chưa có kinh nghiệm' or t2.KinhNghiemMax = 0 or t2.KinhNghiem = ' '
			or t2.Kinhnghiem like '%cập%') 
			group by t2.ID_CapBac, t2.ID_NganhCon 
            ) t3 on ( t3.ID_CapBac = t1.ID_CapBac and t3.ID_NganhCon = t1.ID_NganhCon ) 
		set t1.KinhNghiemMax  = t3.KinhNghiemMaxTB
		where (t1.KinhNghiem is null or t1.KinhNghiem = 'Không có' or t1.KinhNghiem = 'Không yêu cầu kinh nghiệm' 
		or t1.KinhNghiem = 'Tất cả kinh nghiệm' or t1.KinhNghiem = 'Chưa có kinh nghiệm' or t1.KinhNghiem = ' ' or  t1.Kinhnghiem like '%cập%');
        
-- Bước 5: Cập nhật KinhNghiemMin cho các trường hợp không có 
	update Stg_ThongTin 
    set KinhNghiemMin = KinhNghiemMax/1.8 
    where (
		KinhNghiem like 'Lên đến%'
        or KinhNghiem like 'dưới %');
	-- Cập nhật KinhNghiemMax cho các trường hợp không có 
	update Stg_ThongTin 
    set KinhNghiemMax = KinhNghiemMin * 1.8
    where (
		KinhNghiem like 'lên đến%'
        or KinhNghiem like 'trên%'
        or KinhNghiem like 'hơn%'
    );
-- Bước 6: Cập nhật KinhNghiemMax = KinhNghiemMin trong trường hợp khuyết 1 trong 2 bên 
	update Stg_ThongTin set KinhNghiemMin = KinhNghiemMax where	KinhNghiemMin = 0;
    update Stg_ThongTin set KinhNghiemMax = KinhNghiemMin where KinhNghiemMax = 0;

-- Bước 7: Tính lại Phần KinhNghiemTB sau khi đã update xong
	update Stg_ThongTin set KinhNghiemTB = (KinhNghiemMin + KinhNghiemMax)/2;

-- Bước 8: Thực hiện mapping kinh nghiệm cho bảng Stg_ThongTin 
	update Stg_ThongTin t1
    join Dim_KinhNghiem t2 on t1.KinhNghiemTB between  t2.Min and t2.Max 
    set t1.ID_KinhNghiem = t2.ID_KinhNghiem;
    
-- Bước 9: gán các Kinh Nghiệm TB = 0 -> Không yêu cầu
	update Stg_ThongTin t1
    set ID_KinhNghiem = 1
    where KinhNghiemTB = 0;
    
END