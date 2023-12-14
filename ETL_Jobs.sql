CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `etl_jobs`()
BEGIN
	/*1. ETL Ngành*/
    /*1.1 Phân loại thô công việc vào các ngành*/
	call ETL_ID_Nganh();
     /*1.1 Phân loại tinh công việc vào ngành IT*/
    call ETL_Nganh_IT();
    /*2. ETL Ngành vị trí & ngành con */		
		/*2.1 ETL vị trí, ngành con cho ngành IT*/
        call ETL_ID_ViTri_IT();
        /*2.2 ETL vị trí, ngành con cho ngành khác IT*/
        update Stg_ThongTin s
		join  (Select v.ID_ViTri, v.ViTri, n.ID_NganhCon,  n.ID_Nganh from Dim_ViTri v, Dim_NganhCon n where v.ID_NganhCon = n.ID_NganhCon) t on s.ID_Nganh = t.ID_Nganh
		set s.ID_NganhCon = t.ID_NganhCon
		, s.ID_ViTri = t.ID_ViTri
		where s.TenCV like concat('%' , t.ViTri , '%')
		and s.ID_Nganh <> 6 and s.ID_Nganh <> 2;

END