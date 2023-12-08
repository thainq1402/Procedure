CREATE DEFINER=`dulieutu`@`%` PROCEDURE `ETL_ViTri_IT`()
/*Procedure sẽ cập nhật cột Vị Trí trong bảng Stg_ThongTin dựa trên ID_ViTri
Thực hiện: Nguyễn Quốc Thái */

BEGIN
    UPDATE Stg_ThongTin 
    SET ViTri = 
        CASE 
            WHEN ID_ViTri = 1 Then 'FrontEnd'
            WHEN ID_ViTri = 2 Then 'BackEnd'
            WHEN ID_ViTri = 3 Then 'Software Developer/Engineer'
            WHEN ID_ViTri = 4 Then 'Software Architect'
            WHEN ID_ViTri = 5 Then 'Software Tester/QA Engineer'
            WHEN ID_ViTri = 6 Then 'Software Project Manager'
            WHEN ID_ViTri = 7 Then 'Business Analyst/Bridge Software Engineer'
            WHEN ID_ViTri = 8 Then 'DevOps'
            WHEN ID_ViTri = 9 Then 'Security Engineer'
            WHEN ID_ViTri = 10 Then 'IoT'
            WHEN ID_ViTri = 11 Then 'Data Analyst'
            WHEN ID_ViTri = 12 Then 'AI'
            WHEN ID_ViTri = 13 Then 'Data Engineer'
            WHEN ID_ViTri = 14 Then 'IT Helpdesk'
            WHEN ID_ViTri = 15 Then 'Developer Game'
        ELSE ViTri
        END
    WHERE ID_Nganh = 2;
END
