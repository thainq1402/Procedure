CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_CapBac`()
BEGIN
	update Stg_ThongTin
set ID_CapBac =
	case 
		-- Fresher
		when CapBac like 'Sinh viên%' then 1
		when CapBac like 'Thực tập sinh%' then 1
		when CapBac like 'Cộng tác viên%' then 1
        -- Junior
		when CapBac like 'Mới đi làm%' then 2
		when CapBac like 'Fresher%' then 2
		when CapBac like 'Junior%' then 2
        -- Junior
		when CapBac like 'nhân viên%' then 3
		when CapBac like 'kỹ thuật viên%' then 3
		when CapBac like 'All levels%' then 3
		when CapBac like 'chuyên viên%' then 3
		when CapBac like 'nhân viên%' then 3
		when CapBac like 'Junior%' then 3
		-- Mid level
		when CapBac like 'Giám sát%' then 4
		when CapBac like 'Quản lý%' then 4
		when CapBac like 'Quản lý%' then 4
		when CapBac like 'Middle' then 4
		when CapBac like 'Quản lý%' then 4
		when CapBac like 'Quản lý%' then 4
		when CapBac like 'Trưởng nhóm%' then 4
		when CapBac like 'Trưởng nhóm%' then 4
		when CapBac like 'Trưởng nhóm' then 4
        else 0
        end;
	-- where ID_Nganh = 2;

update Stg_ThongTin 
set ID_CapBac = 
	case 
		-- Senior
		when CapBac like 'Trưởng/Phó phòng%' then 5
		when CapBac like 'Senior%' then 5
		when CapBac like 'Chuyên gia%' then 5
        -- Lead/Principle
		when CapBac like '%Lead%' then 6
		when CapBac like '%cấp cao%' then 6
        -- Project Manager
		when CapBac like 'Giám đốc' then 7
		when CapBac like 'Manager' then 7
		when CapBac like 'PM' then 7
		when CapBac like 'Giám đốc' then 7
        else ID_CapBac
        end;
	-- where ID_Nganh = 2;
END