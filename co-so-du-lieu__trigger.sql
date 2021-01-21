create database vd1
create table lop(malop char(5) primary key,tenlop char(10),siso int)
create table hv(mahv char(5) primary key,malop char(5))

create trigger dk1 on lop
for insert
as
declare @i int
select @i=(select siso from inserted)
if @i<>0
begin print'si so fai =0'
rollback tran
end

alter trigger dk2 on lop
for update
as
declare @i int
select @i=(select count(*) from inserted where siso<>(select count(*) from hv where hv.malop=inserted.malop))
if @i>0
begin
	print'ko cho sua'
	rollback
end

create trigger dk3 on hv
for insert
as
update lop set siso=siso+1 from inserted,lop where inserted.malop=lop.malop

select* from lop
select *from hv
delete hv
insert into lop values(1,1,0)
insert into hv values('01','1')
insert into hv values('02','1')
insert into hv values('03','1')