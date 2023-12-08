CREATE DEFINER=`dulieutu`@`%` PROCEDURE `ETL_NganhCon_IT`()
/*Procedure sẽ cập nhật cột Vị Trí trong bảng Stg_ThongTin dựa trên ID_ViTri
Thực hiện: Nguyễn Quốc Thái */

BEGIN
    UPDATE Stg_ThongTin 
    SET NganhCon = 
        CASE 
            WHEN ID_ViTri = 1 THEN 'Phát triển phần mềm'
            WHEN ID_ViTri = 2 THEN 'Phát triển phần mềm'  
            WHEN ID_ViTri = 3 THEN 'Phát triển phần mềm'
            WHEN ID_ViTri = 4 THEN 'Phát triển phần mềm'
            WHEN ID_ViTri = 5 THEN 'Phát triển phần mềm'
            WHEN ID_ViTri = 6 THEN 'Phát triển phần mềm'
            WHEN ID_ViTri = 7 THEN 'Phát triển phần mềm'
            WHEN ID_ViTri = 8 THEN 'Phát triển phần mềm'
            WHEN ID_ViTri = 9 THEN 'An toàn thông tin/ bảo mật'
            WHEN ID_ViTri = 10 THEN 'IOT'
            WHEN ID_ViTri = 11 THEN 'Xử lý và phân tích dữ liệu'
            WHEN ID_ViTri = 12 THEN 'Xử lý và phân tích dữ liệu'
            WHEN ID_ViTri = 13 THEN 'Xử lý và phân tích dữ liệu'
            WHEN ID_ViTri = 14 THEN 'IT Helpdesk'
            WHEN ID_ViTri = 15 THEN 'Game'
            ELSE  ViTri
            END
    WHERE ID_Nganh = 2;
END
