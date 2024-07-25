CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_ID_CapBac`()
BEGIN
-- v3.0 15-05-2024 Nguyễn Quốc Thái
-- Bước 0: Cập nhật lại bảng Stg_CapBacMap: insert thêm những bản ghi
insert ignore into Stg_CapBacMap (CapBacWeb, Web)
select distinct t1.CapBac, t1.Web from Stg_Data_Raw t1
left join Stg_CapBacMap t2 on t1.CapBac = t2.CapBacWeb and t1.Web = t2.Web
where t2.CapBacWeb is null;


-- Bước 1: Thực hiện Mapping
update Stg_Data_Raw t1
join Stg_CapBacMap t2 on  ( t1.CapBac = t2.CapBacWeb and t1.Web = t2.Web)
set t1.ID_CapBac = t2.ID_CapBac 
where t2.ID_CapBac is not null;

END