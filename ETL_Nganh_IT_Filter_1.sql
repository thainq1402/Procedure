CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_Nganh_IT_v1`()
BEGIN
	/*Procedure này sẽ update ID_Nganh của các công việc không
    v2.0 Thực hiện: Nguyễn Quốc Thái 2023.9.12*/
	/*Procedure ETL Nganh:
    Filter 1 dùng Ngành lấy được từ trên các trang tuyển dụng để phân loại trước
		1. Set ID_Nganh của các công việc CHỨA các keyword không liên quan đến IT
		2. Sau khi lọc xong các công việc không liên quan tới IT và set ID_Nganh của các công việc đó bằng 6 
		ta sẽ set các ID_Nganh còn lại bằng 2 -- Ngành IT
  	*/
    
    
    update Stg_ThongTin 
	set ID_Nganh_Temp = 6 
    where 
	(
         -- Nganh keyword
		 Nganh like '%Kiến%' -- Kiến trúc
         or Nganh like '%Tiếp %'-- Tiếp thị 284
         or Nganh like '%Thu %' -- Thu mua 678
         or Nganh like '%Dịch%' -- Giao dịch, dịch thuật 3033
         or (Nganh like '%Ngân %'and Nganh not like '%CNT%') -- Ngân hàng - ko lquan đến CNTT
         or (Nganh like '%Đào %' and Nganh not like '%CNT%') -- Đào tạo không liên quan đến cntt
         or (Nganh like '%Đầu%'  and Nganh not like '%CNT%') -- Đầu tư
         or (Nganh like '%Kinh%' and Nganh not like '%CNT%') -- Kinh tế 
         or (Nganh like '%Giải%' and Nganh not like '%CNT%') -- Giải trí
         or (Nganh like '%Môi%'  and Nganh not like '%CNT%') -- Môi trường 375 / Mới thực tập
         or (Nganh like '%điều%'  and Nganh not like '%CNT%') -- Nhân sự, điều hành 480
         or (Nganh like '%Chính%'  and Nganh not like '%CNT%') -- Tài chính chính sách ... 2433
         or (Nganh like '%giá%'  and Nganh not like '%CNT%') -- định giá
         or Nganh like '%Kiểm%'  and (Nganh not like '%CNT%' or Nganh not like 'IT %')
         or (Nganh like '%Ngành Khác%' and Nganh not like 'CNT%') -- Ngành khác 
         or (Nganh like '%Phiên%'  and (Nganh not like '% CNTT%' and Nganh not like 'IT %')) -- Phiên dịch viên 510
         or (Nganh like '%Toán%'  and (Nganh not like '% CNTT%' and Nganh not like 'IT %')) -- Kế toán kiểm toán 2535
         or Nganh like '%Bất %' -- Bất động sản 264
         or Nganh like '%Nhân %' -- Nhân sự/ nhân lực 630 
         or Nganh like '%Bảo %' -- Bảo hiểm
         or Nganh like '%Điện%' -- Điện / điện tử 
         or Nganh like '%Kỹ %' -- Kỹ thuật
         or Nganh like '%In %' -- Tín dụng 66
         or Nganh like '%Y tế%' -- Y tế 10
         or Nganh like '%Y tá%' -- y tá 1
         or Nganh like '%Đạo %' -- Giáo dục/đạo diễn 949
         or Nganh like '%Nông %' -- Nông nghiệp 121
         or Nganh like '%Vật%' -- Quản lý cơ sở vật chất 132
         or Nganh like '%F&B%' -- F&B - 40
         or Nganh like '%Chứng%' -- Chứng khoán 885
         or Nganh like '%Vận%' -- Vận tải/ Quản lý văn phòng 1389
         or Nganh like '%Khách%' -- Khách sạn nhà hàng 190
         or Nganh like '%Du lịch%' -- du lịch 88
         or Nganh like '%Viễn%' -- viễn thông 279
		 or Nganh like '%Bán%' -- Bán hàng, Bán lẻ 9649 
		--  or Nganh like '%Kiểm%' -- Marketing/Kế toán/Kiểm toán - 5889 
         or Nganh like '%Kế%'  and (Nganh not like '%CNTT%' and Nganh not like '%Phần mềm%') -- Kế toán/ kiểm toán/ thiết kế
		 or Nganh like '%Dệt%' -- Dệt may 320 
		 or Nganh like '%Đồ gỗ%' -- Đồ gỗ 89
		 or Nganh like '%Lao%' -- Lao động phổ thông 462
		 or Nganh like '%Pháp%' -- Pháp luật, pháp lý 656
		 or Nganh like '%Xây%' -- Xây dựng 993 
		 or Nganh like '%Xuất%' -- Xuất nhập khẩu 1508
		 or Nganh like '%Sinh%'-- Công nghệ sinh học 253
		 or Nganh like '%Hoá học%' -- Hoá học 230
		 or Nganh like '%Thực phẩm%' -- Thực phẩm 405 
         or Nganh like '%Khí%' -- Cơ Khí, Dầu khí 1573
         or Nganh like '%CEO%' -- CEO 9 
         or Nganh like '%Bác%'  -- 10 Bác sĩ
         or Nganh like '%Dược%' -- Dược sĩ
         or Nganh like '%Thuỷ%' -- Thuỷ sản
         or Nganh like '%Thất%' -- Nội thất/Ngoại Thất 78
         or Nganh like '%Người%' -- Ng nước ngoài
         or Nganh like '%Thời%' -- Thời trang -- 554
         or Nganh like '%Quảng%'  -- Quảng cáo 
         or Nganh like '%Ô tô%' -- Ô to 
         or Nganh like '%Thuê%'  -- Cho thuê 30 
         or Nganh like '%chuyển%' -- Vận chuyển/ chuyển đổi số 496
         or Nganh like '%nghiên%' -- Nghiên cứu 50
         or Nganh like '%Hải%' -- Hải sản
         or Nganh like '%Lương thưởng%' -- Lương thưởng 
         or Nganh like '%Lâm%' -- Lâm nghiệp 81
         or Nganh like '%Khai%' -- Khai thác mỏ 2
         or Nganh like '%Khoáng%' -- Khoáng sản 8
         or Nganh like '%Mỹ%' -- Mỹ thuật 510
         or Nganh like 'Khác' -- Mỹ thuật 
         or Nganh like '%May mặc%' -- May mặc 23
         or Nganh like '%Cửa hàng%' -- Quản lý cửa hàng 14
         or Nganh like '%Chuỗi%' -- Chuỗi cung ứng 42
         or Nganh like '%Xe%' -- Quản lý đội xe 11
         or Nganh like '%chuẩn%' -- Quản lý tiêu chuẩn và chất lượng
         or Nganh like '%Hiệu%' -- Quản lý thương hiệu or hiệu suất ... 42
         or Nganh like '%Đơn hàng%' -- Quản lý đơn hàng 32
		 or Nganh like '%Lắp%' -- Lắp ráp
         or Nganh like '% Kho %' -- Quản lý kho 437
         or Nganh like '% Quỹ%' -- Quản lý quỹ 16 
         or Nganh like '%Khu %' -- Quản lý khu vực 21
         or Nganh like '%Tuyển%' -- Tuyển dụng 142
         or Nganh like '%Phi %' -- Phi lợi nhuận 20
         or Nganh like 'Khác' -- Ngành khác 10
        );
    UPDATE Stg_ThongTin 
    SET ID_Nganh_Temp = 2 
    WHERE ID_Nganh_Temp IS NULL;
    
END