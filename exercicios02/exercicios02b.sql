/*Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD = código da disciplinas).*/
select MAT from Historico where COD_DISC = 'BD' AND ANO = '2015' AND nota < 5;

/*Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015.*/
select avg(nota) as 'MEDIA de POO' from Historico where COD_DISC = 'POO' AND ANO = '2015';

/*Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015 e 
que esta média seja superior a 6.*/
select avg(nota) as 'MEDIA de POO' from Historico where COD_DISC = 'POO' AND ANO = '2015' AND nota > 6;

/*Encontre quantos alunos não são de Natal.*/
select count(*) from Alunos where cidade != 'Natal';