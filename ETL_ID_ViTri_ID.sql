CREATE DEFINER=`dulieutu`@`%` PROCEDURE `ETL_ID_ViTri_IT`()
BEGIN
	update Stg_ThongTin 
    set ID_ViTri = 
		case 
        -- 14.IT helpdesk
        when TenCV like '%Support%' then 14
		when TenCV like '%Helpdesk%' then 14
        when TenCV like '%desk%' then 14
		when TenCV like '%Office%' then 14
		when TenCV like '%Giám thị%' then 14
		when TenCV like '%Chuyên viên IT%' then 14
		when TenCV like '%Cán bộ hỗ trợ CNTT%' then 14
		when TenCV like 'Thực tập sinh IT' then 14
		when TenCV like 'Thực tập IT' then 14
		when TenCV like '%Nhân viên IT%' then 14
		when TenCV like 'Nhân viên hỗ trợ%' then 14
		when TenCV like 'Nhân viên hcns%' then 14
		when TenCV like '%bảo trì%' then 14
		when TenCV like 'Nhân viên phụ trách CNTT%' then 14
		When TenCV like 'Chuyên viên/trưởng bộ phận IT%' then 14
		When TenCV like '%Nhân viên IT nội bộ' then 14
		When TenCV like '%IT trainner%' then 14
		When TenCV like '%Kỹ sư IT%' then 14
		When TenCV like '%IT Service Desk%' then 14
		When TenCV like '%IT Assistant%' then 14
		When TenCV like '%IT specialist%' then 14
		when TenCV like '%IT Staff%' then 14
		when TenCV like '%Infrastructure%' then 14
		when TenCV like '%Service%' then 14
		when TenCV like '%hạ tầng%' then 14
		when TenCV like '%bảo hành%' then 14
		when TenCV like '%technical%' then 14
		when TenCV like '%Mạng máy tính%' then 14
        	when TenCV like '%IT Staff%' then 14
		when TenCV like '%Infrastructure%' then 14
		when TenCV like '%Service%' then 14
		when TenCV like '%hạ tầng%' then 14
		when TenCV like '%bảo hành%' then 14
		when TenCV like '%technical%' then 14
		when TenCV like '%Mạng máy tính%' then 14
		when TenCV like '%CVCC%' then 14
		when TenCV like '%System Engineer%' then 14
		when TenCV like '% PLM %' then 14
		when TenCV like '%Clerk%' then 14
		when TenCV like '%Facility %' then 14
		when TenCV like '%IT ENGINEER%' then 14
		when TenCV like '%Kỹ thuật IT%' then 14
		when TenCV like '%khối kỹ thuật%' then 14
		when TenCV like '%vận hành Data Center%' then 14
		when TenCV like '%Network%' then 14
		when TenCV like '%kỹ sư vận hành%' then 14
		when TenCV like '%IT Programer%' then 14
		when TenCV like '% System Specialist%' then 14
		when TenCV like '%nhân viên kỹ thuật%' then 14
		when TenCV like '%vận hành khai thác%' then 14
		when TenCV like '%Phần cứng%' then 14
		when TenCV like '%Si %' then 14
		when TenCV like '%thực tập sinh %' then 14
		when TenCV like '%it - programer%' then 14
		when TenCV like '%staff%' then 14
		when TenCV like '%supervision%' then 14
		when TenCV like '%google workspace%' then 14
        when TenCV like '%server engineer%' then 14
		when TenCV like '%chuyên viên kỹ thuật%' then 14
		when TenCV like '%filemaker%' then 14
		when TenCV like '%fresher Engineer%' then 14
        else 0
		end
where ID_Nganh = 2;

update Stg_ThongTin 
set ID_ViTri = 
        case 
			-- 12. AI
		when TenCV like '% AI %' then 12
        when TenCV like '% AI%' then 12
		when TenCV like '%Machine learning%' then 12
		when TenCV like '%dán nhãn%' then 12
		when TenCV like '%big data%' then 12
        when TenCV like '%bigdata%' then 12
        when TenCV like '%nlp%' then 12
		when TenCV like '%Computer vision %' then 12
        when TenCV like '%Matlab%' then 12
		when TenCV like '%RPA%' then 12
		when TenCV like '%khoa học dữ liệu%' then 12
        when TenCV like '%Data Scientist%' then 12
        when TenCV like '% gis %' then 12
        when TenCV like '%gis developer%' then 12
        when TenCV like '%AI Engineer%' then 12
			-- 13.Data Engineer
		when TenCV like '%Kỹ sư dữ liệu%' then 13
		when TenCV like '%Thu thập dữ liệu%' then 13
		when TenCV like '%Xử lý%' then 13
		when TenCV like '%Data Engineer%' then 13
        when TenCV like '%FPGA%' then 13
		when TenCV like '%Dataops%' then 13
		when TenCV like '% ETL %' then 13
		when TenCV like '%AWS%' and TenCV not like '%back%' then 13
		else ID_ViTri 
        end
where ID_Nganh = 2;


update Stg_ThongTin 
set ID_ViTri = 
        case 
		-- 2.Backend
		when TenCV like '%Back%' then 2 
		when TenCV like '%Full%' then 2 
		when TenCV like '%Database%' then 2 
		when TenCV like '%Quản trị dữ liệu%' then 2 
		when TenCV like '%API%' then 2 
		when TenCV like '%quản trị mạng%' then 2 
		when TenCV like '%node.js%' then 2 
		when TenCV like '%nodejs%' then 2 
		when TenCV like '%node js%' then 2 

		when TenCV like '%PHP%' then 2 
		when TenCV like '%Quản trị cơ sở dữ liệu%' then 2 
		when TenCV like '%Ruby%' then 2 
		when TenCV like '%Golang%' then 2 
        when TenCV like '%Quản trị website%' then 2 
		when TenCV like '%Server egineer%' then 2 
		when TenCV like '%Ci/CD%' then 2 
		when TenCV like '%Cơ sở dữ liệu%' then 2 
		when TenCV like '%SQL%' then 2 
		when TenCV like '%NoSQL%' then 2 
		when TenCV like '%magento%' then 2 
		when TenCV like '%application operator%' then 2 
        when TenCV like '%cobol%' then 2 
		else ID_ViTri 
        end
where ID_Nganh = 2 ;


update Stg_ThongTin 
set ID_ViTri = 
        -- Phát triển phần mềm 
			-- 1. Front end
	case
		when TenCV like '%Front%' then 1 
        when TenCV like '%Fron%' then 1 
		when TenCV like '%giao diện%' then 1 
		when TenCV like '%Thiết kế%' then 1 
		when TenCV like '%Web developer%' then 1 
		when TenCV like '%Laravel%' then 1 
		when TenCV like '%React Native%' then 1 
		when TenCV like '%react js%' then 1 
        when TenCV like '%reactjs%' then 1 
		when TenCV like '%Wordpress%' then 1 
		when TenCV like '%vuejs%' then 1 
        when TenCV like '%html%' then 1 
		when TenCV like '%phát triển web%' then 1 
		when TenCV like '%shopify%' then 1 
		when TenCV like '%sitecore%' then 1 
		when TenCV like '%three.js%' then 1 
		when TenCV like '%nuxt.js%' then 1 
		when TenCV like '%React%' then 1
        when TenCV like '%angular%' then 1 
        else ID_ViTri  
        end
where ID_Nganh = 2 ;

update Stg_ThongTin 
set ID_ViTri = 
			-- 3.Software develop engineer
		case
		when TenCV like '%Software Engineer%' then 3 	
		when TenCV like '%Software Design%' then 3 	
		when TenCV like '%Software Developer%' then 3 	
		when TenCV like '%Software Backend%' then 3 	
		when TenCV like '%Java%' then 3 	
		when TenCV like '%Phần mềm%' then 3 
        when TenCV like '%Phần Mềm%' then 3 	
		when TenCV like '%Software%' then 3 	
		when TenCV like '%Mobile%' then 3 	
		when TenCV like '%.Net%' then 3 	
		when TenCV like '%Lập trình%' then 3 	
		when TenCV like '%ứng dụng%' then 3 	
		when TenCV like '%C++%' then 3 	
		when TenCV like '%IOS%' then 3 	
		when TenCV like '%Android%' then 3 	
		when TenCV like '%Dot Net%' then 3 	
		when TenCV like '%Flutter%' then 3 	
        when TenCV like '%IT Developer%' then 3 
		when TenCV like '%Linux%' then 3 
		when TenCV like '%system engineer%' then 3 
		when TenCV like '%ERP%' then 3 
		when TenCV like '%Net %' then 3 
		when TenCV like '% Net%' then 3 
		when TenCV like '%C#%' then 3 
		when TenCV like '%C Sharp%' then 3 
		when TenCV like '%Blockchain%' then 3 
		when TenCV like '%sản phẩm%' then 3 
		when TenCV like '%stack %' then 3 
		when TenCV like '%outsystem%' then 3 
		when TenCV like '%Abap %' then 3 
		when TenCV like '%Sap%' then 3 
		when TenCV like '%Developer Onsite%' then 3
        when TenCV like '%Developer Onsite%' then 3 
		when TenCV like '%Mobility Engineer%' then 3 
		when TenCV like '%Fresher Developer%' then 3 
		when TenCV like '%sharepoint%' then 3 
		when TenCV like '%appian%' then 3 
		when TenCV like '%quản trị phần mềm%' then 3
        
        else ID_ViTri 
        end 
where ID_Nganh = 2 ;

update Stg_ThongTin 
set ID_ViTri  =
	case
			-- 4.Software architect 
		when TenCV like '%Architect%' then 4 
		when TenCV like '%Solution%' then 4 
			-- 5. QA/QC engineer
		when TenCV like '%Test%' then 5 
		when TenCV like '%Kiểm thử%' then 5 
		when TenCV like '% QA %' then 5 
        when TenCV like '%QA %' then 5 
		when TenCV like '% QC %' then 5 
        when TenCV like '%Chất lượng%' then 5 
        when TenCV like '%QC %' then 5 
		when TenCV like '%Quality control%' then 5 
		when TenCV like '%Quality assurance%' then 5 
        when TenCV like '%automation%' then 5 
        else ID_ViTri 
        end
where ID_Nganh = 2 ;

update Stg_ThongTin 
set ID_ViTri = 
	case 
			-- 6.Project manager
		when TenCV like '% PM %' then 6
		when TenCV like '%Project Manager%' then 6
		when TenCV like '%leader%' then 6
		when TenCV like '%Manager%' then 6
		when TenCV like '%Administrator%' then 6
		when TenCV like '%lead%' then 6
		when TenCV like '%IT risk %' then 6
		when TenCV like '%risk%' then 6
		when TenCV like '%supervisor%' then 6
		when TenCV like '%Management%' then 6
		when TenCV like '%Site reliability Engineer%' then 6
		when TenCV like '%executive%' then 6
		when TenCV like '%governance%' then 6
		when TenCV like '%Compliance%' then 6
		when TenCV like '%Financial Control%' then 6
		when TenCV like '%TRƯỞNG PHÒNG%' then 6
			-- 7."Business Analyst/Bridge Software Engineer
		when TenCV like '%Business%' then 7
		when TenCV like '%nghiệp vụ%' then 7
		when TenCV like '% Brse %' then 7
		when TenCV like '%Brse %' then 7
		when TenCV like '%Bridge%' then 7
		when TenCV like '%Cầu nối%' then 7
		when TenCV like '%comtor%' then 7
        when TenCV like '%nhân viên BA%' then 7
        when TenCV like '%BPM%' then 7
		when TenCV like '%Application Operation%' then 7
		when TenCV like '% MIS %' then 7
		when TenCV like '%Internal Auditor%' then 7
		when TenCV like '%Communicator%' then 7
		when TenCV like '%integrator%' then 7
		when TenCV like '%SCM%' then 7
        when TenCV like '%quản lý yêu cầu%' then 7
        when TenCV like '%trợ lý dụ án %' then 7
		else ID_ViTri 
        end
where ID_Nganh = 2 ;

update Stg_ThongTin 
set ID_ViTri = 
        case 
        -- 8.DevOps
		when TenCV like '%Devops%' then 8
        when TenCV like '%Devop%' then 8
		when TenCV like '%Cloud%' then 8
			-- 9. Security 
		when TenCV like '%Bảo mật%' then 9 
		when TenCV like '%Security%' then 9 
        when TenCV like '%Securities%' then 9 
        when TenCV like '% SOC %' then 9 
		else ID_ViTri 
        end
where ID_Nganh = 2 ;

update Stg_ThongTin 
set ID_ViTri = 
        case 
			-- 10.IOT 
		when TenCV like '%Embedded software%' then 10
		when TenCV like '% iot %' then 10
		when TenCV like '%iot %' then 10
		when TenCV like '%vi mạch%' then 10
		when TenCV like '%Embedded %' then 10
        when TenCV like '%firmware%' then 10
		when TenCV like '%circuit board%' then 10
		when TenCV like '%C developer%' then 10
		when TenCV like '%tự động hoá%' then 10
		else ID_ViTri 
        end
where ID_Nganh = 2 ;

update Stg_ThongTin 
set ID_ViTri = 
        case 
			-- 11.Data Analyst 
		when TenCV like '%Data Analyst%' then 11
		when TenCV like '%Phân tích dữ liệu%' then 11
		when TenCV like '%Power BI%' then 11
		when TenCV like '%Data Analysis%' then 11
		when TenCV like '%Data Analytics%' then 11
        when TenCV like '%Báo cáo BI%' then 11
        when TenCV like '%data analyst%' then 11
        
		else ID_ViTri 
        end
where ID_Nganh = 2 ;



update Stg_ThongTin 
set ID_ViTri = 
        case 
			-- 15.Game
		when TenCV like '%Unity%' then 15
		when TenCV like '%Game%' then 15
		when TenCV like '%Roblox%' then 15
		else ID_ViTri 
        end
where ID_Nganh = 2 ;
END