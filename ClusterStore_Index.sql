declare @final int = 10, @inicio int = 0;


while @inicio < @final
begin
	insert into gafanhotos
	select nome, profissao, nascimento, sexo, peso, altura, nacionalidade from gafanhotos

	set @inicio = @inicio +1;
end

select count(*) from gafanhotos

sp_help 'gafanhotos'


create clustered columnstore index gafanhotos on gafanhotos
