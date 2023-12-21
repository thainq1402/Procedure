CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_ViTri_IT`()
BEGIN
-- v2.0 2023.12.12
-- Thực hiện: Nguyễn Quốc Thái
/*Phân loại vào các vị trí và ngành con tương ứng:
	IT Khác 
	Phát triển phần mềm 
	An toàn thông tin/Bảo mật
	IoT
	Xử lý và phân tích dữ liệu
	IT Helpdesk
	Game
*/
-- Update các công việc liên quan đến vị trí: IT Helpdesk
 -- 14.IT helpdesk
	update Stg_ThongTin 
    set ID_ViTri = 14
    , ID_NganhCon = 5
	where
		ID_Nganh = 2
        and (       
        TenCV like '%Support%' 
		or TenCV like '%Helpdesk%' 
        or TenCV like '%Vi Tính%'
        or TenCV like '%CÔNG NGHỆ THÔNG TIN%'
        or TenCV like '%desk%' 
		or TenCV like '%Office%' 
		or TenCV like '%Giám thị%' 
		or TenCV like '%Chuyên viên IT%' 
		or TenCV like '%Cán bộ hỗ trợ CNTT%' 
		or TenCV like 'Thực tập sinh IT' 
		or TenCV like 'Thực tập IT' 
		or TenCV like '%Nhân viên IT%' 
		or TenCV like 'Nhân viên hỗ trợ%' 
		or TenCV like 'Nhân viên hcns%' 
		-- or TenCV like '%bảo trì%' 
        or TenCV like '%ID admin%' 
		or TenCV like 'Nhân viên phụ trách CNTT%' 
		or TenCV like 'Chuyên viên/trưởng bộ phận IT%' 
		or TenCV like '%Nhân viên IT nội bộ' 
		or TenCV like '%IT trainner%' 
		or TenCV like '%Kỹ sư IT%' 
		or TenCV like '%IT Service Desk%' 
		or TenCV like '%IT Assistant%' 
		or TenCV like '%IT specialist%' 
		or TenCV like '%IT Staff%' 
		or TenCV like '%Infrastructure%' 
		or TenCV like '%Service%' 
		or TenCV like '%hạ tầng%' 
		or TenCV like '%bảo hành%' 
		or TenCV like '%technical%' 
		or TenCV like '%Mạng máy tính%' 
		or TenCV like '%IT Staff%' 
		or TenCV like '%Infrastructure%' 
		or TenCV like '%Service%' 
		or TenCV like '%hạ tầng%' 
		or TenCV like '%bảo hành%' 
		or TenCV like '%technical%' 
		or TenCV like '%Mạng máy tính%' 
		or TenCV like '%CVCC%' 
		or TenCV like '%System Engineer%' 
		or TenCV like '% PLM %' 
		or TenCV like '%Clerk%' 
		or TenCV like '%Facility %' 
		or TenCV like '%IT ENGINEER%' 
		or TenCV like '%Kỹ thuật IT%' 
		or TenCV like '%khối kỹ thuật%' 
		or TenCV like '%vận hành Data Center%' 
		or TenCV like '%Network%' 
		or TenCV like '%kỹ sư vận hành%' 
		or TenCV like '%IT Programer%' 
		or TenCV like '% System Specialist%' 
		or TenCV like '%nhân viên kỹ thuật%' 
		or TenCV like '%vận hành khai thác%' 
		or TenCV like '%Phần cứng%' 
		or TenCV like '%Si %' 
		or TenCV like '%thực tập sinh %' 
		or TenCV like '%it - programer%' 
		or TenCV like '%staff%' 
		or TenCV like '%supervision%' 
		or TenCV like '%google workspace%' 
        or TenCV like '%server engineer%' 
		or TenCV like '%chuyên viên kỹ thuật%' 
		or TenCV like '%filemaker%' 
		or TenCV like '%fresher Engineer%' );
-- 12. AI
update Stg_ThongTin 
  set ID_ViTri = 12, ID_NganhCon = 4
	where
		ID_Nganh = 2
        and (TenCV like '% AI %' 
        or TenCV like '% AI%' 
		or TenCV like '%Machine learning%' 
		or TenCV like '%dán nhãn%' 
		or TenCV like '%big data%' 
        or TenCV like '%bigdata%' 
        or TenCV like '%nlp%' 
		or TenCV like '%Computer vision %' 
        or TenCV like '%Matlab%' 
		or TenCV like '%RPA%' 
		or TenCV like '%khoa học dữ liệu%' 
        or TenCV like '%Data Scientist%' 
        or TenCV like '% gis %' 
        or TenCV like '%gis developer%' 
        or TenCV like '%AI Engineer%');
  -- 13.Data Engineer      
 update Stg_ThongTin 
  set ID_ViTri = 13, ID_NganhCon = 4
	where
		ID_Nganh = 2
        and (TenCV like '%Kỹ sư dữ liệu%' 
		or TenCV like '%Thu thập dữ liệu%' 
		or TenCV like '%Xử lý%' 
		or TenCV like '%Data Engineer%' 
        or TenCV like '%FPGA%' 
		or TenCV like '%Dataops%' 
		or TenCV like '% ETL %' 
		or TenCV like '%AWS%' and TenCV not like '%back%' );

	-- 2.Backend
update Stg_ThongTin 
set ID_ViTri = 2, ID_NganhCon = 1
	where
		ID_Nganh = 2
        and (  TenCV like '%Back%'  
		or TenCV like '%Full%'  
		or TenCV like '%Database%'  
		or TenCV like '%Quản trị dữ liệu%'  
		or TenCV like '%API%'  
		or TenCV like '%quản trị mạng%'  
		or TenCV like '%node.js%'  
		or TenCV like '%nodejs%'  
		or TenCV like '%node js%'  
		or TenCV like '%PHP%'  
		or TenCV like '%Quản trị cơ sở dữ liệu%'  
		or TenCV like '%Ruby%'  
		or TenCV like '%Golang%'  
        or TenCV like '%Quản trị website%'  
		or TenCV like '%Server egineer%'  
		or TenCV like '%Ci/CD%'  
		or TenCV like '%Cơ sở dữ liệu%'  
		or TenCV like '%SQL%'  
		or TenCV like '%NoSQL%'  
		or TenCV like '%magento%'  
		or TenCV like '%application operator%'  
        or TenCV like '%cobol%'  );
 -- Phát triển phần mềm 
			-- 1. Front end
update Stg_ThongTin 
set ID_ViTri = 1, ID_NganhCon = 1
	where
		ID_Nganh = 2
        and (  TenCV like '%Front%'  
        or TenCV like '%Fron%'  
		or TenCV like '%giao diện%'  
		or TenCV like '%Thiết kế%'  
		or TenCV like '%Web developer%'  
		or TenCV like '%Laravel%'  
		or TenCV like '%React Native%'  
		or TenCV like '%react js%'  
        or TenCV like '%reactjs%'  
        or TenCV like '%Web/App%' 
		or TenCV like '%Wordpress%'  
		or TenCV like '%vuejs%'  
        or TenCV like '%html%'  
		or TenCV like '%phát triển web%'  
		or TenCV like '%shopify%'  
		or TenCV like '%sitecore%'  
		or TenCV like '%three.js%'  
		or TenCV like '%nuxt.js%'  
		or TenCV like '%React%' 
        or TenCV like '%angular%'  );
	-- 3.Software develop engineer
update Stg_ThongTin 
set ID_ViTri = 3, ID_NganhCon = 1
	where
		ID_Nganh = 2
        and ( 
 TenCV like '%Software Engineer%'  	
		or TenCV like '%Software Design%'  	
		or TenCV like '%Software Developer%'  	
		or TenCV like '%Software Backend%'  	
		or TenCV like '%Java%'  	
		or TenCV like '%Phần mềm%'  
        or TenCV like '%Phần Mềm%'  	
		or TenCV like '%Software%'  	
		or TenCV like '%Mobile%'  	
		or TenCV like '%.Net%'  	
		or TenCV like '%Lập trình%'  	
		or TenCV like '%ứng dụng%'  	
		or TenCV like '%C++%'  	
		or TenCV like '%IOS%'  	
		or TenCV like '%Android%'  	
		or TenCV like '%Dot Net%'  	
		or TenCV like '%Flutter%'  	
        or TenCV like '%IT Developer%'  
		or TenCV like '%Linux%'  
		or TenCV like '%system engineer%'  
		or TenCV like '%ERP%'  
		or TenCV like '%Net %'  
		or TenCV like '% Net%'  
		or TenCV like '%C#%'  
		or TenCV like '%C Sharp%'  
		or TenCV like '%Blockchain%'  
		or TenCV like '%sản phẩm%'  
		or TenCV like '%stack %'  
		or TenCV like '%outsystem%'  
		or TenCV like '%Abap %'  
		or TenCV like '%Sap%'  
		or TenCV like '%Developer Onsite%' 
        or TenCV like '%Developer Onsite%'  
		or TenCV like '%Mobility Engineer%'  
		or TenCV like '%Fresher Developer%'  
		or TenCV like '%sharepoint%'  
		or TenCV like '%appian%'  
		or TenCV like '%quản trị phần mềm%' );
-- 4.Software architect 
update Stg_ThongTin 
set ID_ViTri = 4, ID_NganhCon = 1
	where
		ID_Nganh = 2
        and ( 
 TenCV like '%Architect%'  
		or TenCV like '%Solution%'  );

-- 5. QA/QC engineer    
 update Stg_ThongTin 
set ID_ViTri = 5, ID_NganhCon = 1
	where
		ID_Nganh = 2       
		and(	
		 TenCV like '%Test%'  
		or TenCV like '%Kiểm thử%'  
		or TenCV like '% QA %'  
        or TenCV like '%QA %'  
		or TenCV like '% QC %'
        or TenCV like '%QC%'
        or TenCV like '% QC'
        or TenCV like '%Chất lượng%'  
        or TenCV like '%QC %'  
		or TenCV like '%Quality control%'  
		or TenCV like '%Quality assurance%'  
        or TenCV like '%automation%'  );

-- 6.Project manager
 update Stg_ThongTin 
set ID_ViTri = 6, ID_NganhCon = 1
	where
		ID_Nganh = 2       
		and(
		 TenCV like '% PM %' 
		or TenCV like '%Project Manager%' 
		or TenCV like '%leader%' 
		or TenCV like '%Manager%' 
		or TenCV like '%Administrator%' 
		or TenCV like '%lead%' 
		or TenCV like '%IT risk %' 
		or TenCV like '%risk%' 
		or TenCV like '%supervisor%' 
		or TenCV like '%Management%' 
		or TenCV like '%Site reliability Engineer%' 
		or TenCV like '%executive%' 
		or TenCV like '%governance%' 
		or TenCV like '%Compliance%' 
		or TenCV like '%Financial Control%' 
		or TenCV like '%TRƯỞNG PHÒNG%' );
			-- 7."Business Analyst/Bridge Software Engineer
 update Stg_ThongTin 
set ID_ViTri = 7, ID_NganhCon = 1
	where
		ID_Nganh = 2       
		and(
		TenCV like '%Business%' 
		or TenCV like '%nghiệp vụ%' 
		or TenCV like '% Brse %' 
		or TenCV like '%Brse %' 
		or TenCV like '%Bridge%' 
		or TenCV like '%Cầu nối%' 
		or TenCV like '%comtor%' 
        or TenCV like '%nhân viên BA%' 
        or TenCV like '%BPM%' 
		or TenCV like '%Application Operation%' 
		or TenCV like '% MIS %' 
        or TenCV like '%Kiểm toán%' -- Kiểm toán viên CNTT
		or TenCV like '%Internal Auditor%' 
		or TenCV like '%Communicator%' 
		or TenCV like '%integrator%' 
		or TenCV like '%SCM%' 
        or TenCV like '%quản lý yêu cầu%' 
        or TenCV like '%trợ lý dụ án %' ) ;

     -- 8.DevOps
 update Stg_ThongTin 
set ID_ViTri = 8, ID_NganhCon = 1
	where
		ID_Nganh = 2       
		and( TenCV like '%Devops%' 
        or TenCV like '%Devop%' 
		or TenCV like '%Cloud%' );
			-- 9. Security 
	 update Stg_ThongTin 
set ID_ViTri = 9, ID_NganhCon = 2
	where
		ID_Nganh = 2       
		and(TenCV like '%Bảo mật%'  
		or TenCV like '%Security%'  
        or TenCV like '%Securities%'  
        or TenCV like '% SOC %' );
	-- 10.IOT 
	 update Stg_ThongTin 
set ID_ViTri = 10, ID_NganhCon = 3
	where
		ID_Nganh = 2       
		 and ( 
 TenCV like '%Embedded software%' 
		or TenCV like '% iot %' 
		or TenCV like '%iot %' 
		or TenCV like '%vi mạch%' 
		or TenCV like '%Embedded %' 
        or TenCV like '%firmware%' 
		or TenCV like '%circuit board%' 
		or TenCV like '%C developer%' 
		or TenCV like '%tự động hoá%' ) ;
-- 11.Data Analyst 
 update Stg_ThongTin 
set ID_ViTri = 11, ID_NganhCon = 4
	where
		ID_Nganh = 2       
		 and ( 
 TenCV like '%Data Analyst%' 
		or TenCV like '%Phân tích dữ liệu%' 
		or TenCV like '%Power BI%' 
		or TenCV like '%Data Analysis%' 
		or TenCV like '%Data Analytics%' 
        or TenCV like '%Báo cáo BI%' 
        or TenCV like '%data analyst%' ) ;
	-- 15.Game
 update Stg_ThongTin 
set ID_ViTri = 15, ID_NganhCon = 6
	where
		ID_Nganh = 2       
		 and ( 
 TenCV like '%Unity%' 
		or TenCV like '%Game%' 
		or TenCV like '%Roblox%' );

-- Update các CV thuộc IT nhưng không được phân vào NganhCon or ViTri nào
	update Stg_ThongTin 
	set ID_ViTri = 16,ID_NganhCon = 0 
	where ID_Nganh = 2 and ID_ViTri is null;
END