
   select * from (select A.*, @ROWNUM:=@ROWNUM+1 Rnum 
   					from (select *,(SELECT @ROWNUM:=0) R from board order by ref desc ,re_step asc,re_level asc) A) r;