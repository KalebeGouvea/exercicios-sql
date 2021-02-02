use cadastrodb;
select * from produtos;

/*Pesquise os itens que foram vendidos sem desconto. As colunas presentes no resultado da 
consulta são: ID_NF, ID_ITEM, COD_PROD E VALOR_UNIT.*/
select ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT from produtos where DESCONTO is not null;

/*Pesquise os itens que foram vendidos com desconto. As colunas presentes no resultado da 
consulta são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT E O VALOR VENDIDO. OBS: O valor vendido
é igual ao VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)).*/
select ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)) as VALOR_VENDIDO from produtos;

/*Altere o valor do desconto (para zero) de todos os registros onde este campo é nulo.*/
update produtos set desconto = '0' where desconto is null;

/*Pesquise os itens que foram vendidos. As colunas presentes no resultado da consulta
são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_TOTAL, DESCONTO, VALOR_VENDIDO. 
OBS: O VALOR_TOTAL é obtido pela fórmula: QUANTIDADE * VALOR_UNIT. O VALOR_VENDIDO
é igual a VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)).*/
select ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, 
QUANTIDADE * VALOR_UNIT as VALOR_TOTAL, 
DESCONTO, 
VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)) as VALOR_VENDIDO
from produtos;

/*Pesquise o valor total das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_TOTAL. OBS: O VALOR_TOTAL 
é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. Agrupe o resultado da consulta por ID_NF.*/
select ID_NF, SUM(QUANTIDADE * VALOR_UNIT) as VALOR_TOTAL from produtos
group by ID_NF
order by VALOR_TOTAL desc;

/*Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_VENDIDO. OBS: O VALOR_TOTAL 
é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. O VALOR_VENDIDO é igual a 
∑ VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)). Agrupe o resultado da consulta por ID_NF.*/
select ID_NF, SUM(VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100))) as VALOR_VENDIDO from produtos
group by ID_NF
order by VALOR_VENDIDO desc;

/*Consulte o produto que mais vendeu no geral. As colunas presentes no resultado da consulta são: 
COD_PROD, QUANTIDADE. Agrupe o resultado da consulta por COD_PROD.*/
select COD_PROD, SUM(QUANTIDADE) from produtos
group by COD_PROD
order by SUM(QUANTIDADE) desc;

/*Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto.
As colunas presentes no resultado da consulta são: ID_NF, COD_PROD, QUANTIDADE.
Agrupe o resultado da consulta por ID_NF, COD_PROD.*/
select ID_NF, COD_PROD, SUM(QUANTIDADE) from produtos
where quantidade > 10
group by ID_NF, COD_PROD;

/*Pesquise o valor total das NF, onde esse valor seja maior que 500, e ordene o
resultado do maior valor para o menor. As colunas presentes no resultado da consulta
são: ID_NF, VALOR_TOT. OBS: O VALOR_TOTAL é obtido pela fórmula: 
∑ QUANTIDADE * VALOR_UNIT. Agrupe o resultado da consulta por ID_NF.*/
select ID_NF, SUM(QUANTIDADE * VALOR_UNIT) as VALOR_TOTAL from produtos
group by ID_NF
having VALOR_TOTAL > 500
order by VALOR_TOTAL desc;

/*Qual o valor médio dos descontos dados por produto. As colunas presentes no
resultado da consulta são: COD_PROD, MEDIA. Agrupe o resultado da consulta por
COD_PROD.*/
select COD_PROD, avg(desconto) as MEDIA from produtos
group by COD_PROD;

/*Qual o menor, maior e o valor médio dos descontos dados por produto. As colunas
presentes no resultado da consulta são: COD_PROD, MENOR, MAIOR, MEDIA. Agrupe
o resultado da consulta por COD_PROD.*/
select COD_PROD, min(desconto) as MENOR, max(desconto) as MAIOR, avg(desconto) as MEDIA from produtos
group by COD_PROD;

/*Quais as NF que possuem mais de 3 itens vendidos. As colunas presentes no resultado
da consulta são: ID_NF, QTD_ITENS. OBS:: NÃO ESTÁ RELACIONADO A QUANTIDADE
VENDIDA DO ITEM E SIM A QUANTIDADE DE ITENS POR NOTA FISCAL. Agrupe o
resultado da consulta por ID_NF.*/
select ID_NF, sum(QUANTIDADE) as QTD_ITENS from produtos where QUANTIDADE > 3
group by ID_NF;