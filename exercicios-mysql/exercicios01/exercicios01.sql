use cadastro;

/*01 - Uma lista com o nome de todas as gafanhotas*/
select nome from gafanhotos where sexo = 'F';

/*02 - Uma lista com os dados de todos aqueles que nasceram entre 1/Jan/2000 e 31/Dez/2015*/
select * from gafanhotos where nascimento between '2000-01-01' and '2015-12-31';

/*03 - Uma lista com o nome de todos os homens que trabalham como programadores*/
select nome from gafanhotos where sexo = 'M' and profissao = 'programador';

/*04 - Uma lista com os dados de todas as mulheres que nasceram no Brasil e que têm seu nome iniciando com a letra J*/
select * from gafanhotos where nacionalidade = 'Brasil' and nome like 'J%';

/*05 - Uma lista com o nome e nacionalidade de todos os homens que têm Silva no nome, não nasceram no Brasil e pesam menos de 100kg*/
select nome, nacionalidade from gafanhotos where sexo = 'M' and nome like '%Silva%' and nacionalidade != 'Brasil' and peso < '100';

/*06 - Qual é a maior altura entre gafanhotos homens que moram no Brasil?*/
select max(altura) from gafanhotos where sexo = 'M' and nacionalidade = 'Brasil';

/*07 - Qual é a média de peso dos gafanhotos cadastrados?*/
select avg(peso) from gafanhotos;

/*08 - Qual é o menor peso entre as gafanhotos mulheres que nasceram fora do Brasil e entre 01/Jan/1990 e 31/Dez/2000*/
select min(peso) from gafanhotos where sexo = 'F' and nacionalidade != 'Brasil' and nascimento between '1990-01-01' and '2000-12-31';

/*09 - Quantas gafanhotos mulheres têm mais de 1.90m de altura?*/
select count(*) from gafanhotos where sexo = 'F' and altura > '1.90';