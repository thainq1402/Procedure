CREATE DEFINER=`tuyendungUser`@`%` PROCEDURE `ETL_TrangThaiTrungLap`()
/*Procedure đếm số lượng tin trùng nhau (group by theo Tên công việc, Công Ty, TinhThanh)
Thực hiện: Nguyễn Quốc Thái */

BEGIN
	update Stg_ThongTin t1
    join 
    (select ID,count(*) as TrungLap
    from Stg_ThongTin
    where ID_Nganh = 2 
    group by TenCV, TinhThanh, CongTy 
    ) t2 
    on t1.ID = t2.ID
    set t1.CountTin = t2.TrungLap
    where ID_Nganh = 2 ;
    
    update Stg_ThongTin 
    set TrangThaiTrungLap = (CountTin > 1)
	where ID_Nganh = 2;
END