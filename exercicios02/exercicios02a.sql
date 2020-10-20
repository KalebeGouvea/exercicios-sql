create database Universidade default charset=utf8;

use Universidade;

create table Alunos (
	MAT int(10) unsigned not null,
    nome varchar(60) not null,
    endereco varchar(100) not null,
    cidade varchar(45) not null,
    primary key(MAT)
) default charset=utf8;

create table Disciplinas (
	COD_DISC varchar(3) not null,
    nome_disc varchar(60) not null,
    carga_hor int(5) unsigned not null,
    primary key(COD_DISC)
) default charset=utf8;

create table Professores (
	COD_PROF int(6) unsigned not null,
    nome varchar(60) not null,
    endereco varchar(100) not null,
    cidade varchar(45) not null,
    primary key(COD_PROF)
) default charset=utf8;

create table Turma (
	COD_DISC varchar(3) not null,
    COD_TURMA int(2) unsigned not null,
	COD_PROF int(6) unsigned not null,
    ANO smallint(4) unsigned not null,
    horario varchar(13) not null,
    primary key(COD_DISC, COD_TURMA, COD_PROF, ANO),
    foreign key(COD_DISC) references Disciplinas(COD_DISC),
    foreign key(COD_PROF) references Professores(COD_PROF)
) default charset=utf8;

create table Historico(
	MAT int(10) unsigned not null,
	COD_DISC varchar(3) not null,
    COD_TURMA int(2) unsigned not null,
	COD_PROF int(6) unsigned not null,
    ANO smallint(4) unsigned not null,
    frequencia decimal(5,2) unsigned not null,
    nota decimal(4,2) unsigned not null,
    primary key(MAT, COD_DISC, COD_TURMA, COD_PROF, ANO),
	foreign key(MAT) references Alunos(MAT),
	foreign key(COD_DISC, COD_TURMA, COD_PROF, ANO) references Turma(COD_DISC, COD_TURMA, COD_PROF, ANO)
) default charset=utf8;

insert into Alunos values 
('2015010101', 'JOSE DE ALENCAR', 'RUA DAS ALMAS', 'NATAL'),
('2015010102', 'JOÃO JOSÉ', 'AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
('2015010103', 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
('2015010104', 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
('2015010105', 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
('2015010106', 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');

insert into Disciplinas values
('BD', 'BANCO DE DADOS', '100'),
('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', '100'),
('WEB', 'AUTORIA WEB', '50'),
('ENG', 'ENGENHARIA DE SOFTWARE', '80');

insert into Professores values
('212131', 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
('122135', 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
('192011', 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');

insert into Turma values
('BD', '1', '212131', '2015', '11H-12H'),
('BD', '2', '212131', '2015', '13H-14H'),
('POO', '1', '192011', '2015', '08H-09H'),
('WEB', '1', '192011', '2015', '07H-08H'),
('ENG', '1', '122135', '2015', '10H-11H');

INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010101', 'BD', '1', '212131', '2015', '78.9', '7.2');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010101', 'POO', '1', '192011', '2015', '64.4', '6.25');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010101', 'WEB', '1', '192011', '2015', '100', '10');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010101', 'ENG', '1', '122135', '2015', '96', '9.25');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010102', 'BD', '2', '212131', '2015', '80', '8.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010102', 'POO', '1', '192011', '2015', '70', '9');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010102', 'WEB', '1', '192011', '2015', '75', '3.4');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010102', 'ENG', '1', '122135', '2015', '98', '9.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010103', 'BD', '1', '212131', '2015', '82', '7.75');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010103', 'POO', '1', '192011', '2015', '75', '9');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010103', 'WEB', '1', '192011', '2015', '78', '9');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010103', 'ENG', '1', '122135', '2015', '62', '2.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010104', 'BD', '2', '212131', '2015', '81', '2.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010104', 'POO', '1', '192011', '2015', '80', '4');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010104', 'WEB', '1', '192011', '2015', '92', '8');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010104', 'ENG', '1', '122135', '2015', '64.5', '5.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010105', 'BD', '1', '212131', '2015', '88', '7.8');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010105', 'POO', '1', '192011', '2015', '100', '4.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010105', 'WEB', '1', '192011', '2015', '95.5', '8');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010105', 'ENG', '1', '122135', '2015', '72.4', '5.8');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010106', 'BD', '2', '212131', '2015', '78.7', '4.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010106', 'POO', '1', '192011', '2015', '95', '8.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010106', 'WEB', '1', '192011', '2015', '91.8', '7.5');
INSERT INTO `Universidade`.`Historico` (`MAT`, `COD_DISC`, `COD_TURMA`, `COD_PROF`, `ANO`, `frequencia`, `nota`) VALUES ('2015010106', 'ENG', '1', '122135', '2015', '76.5', '6.8');