/*Implemente as consultas abaixo considerando o modelo conceitual acima e utilizando para
realizar a junção SOMENTE os comandos INNER join, LEFT OUTER join ou RIGHT OUTER join.*/

/*Listar os nomes dos assinantes, seguido dos dados do endereço e os telefones
correspondentes.*/
select a.nome, e.ds_endereco, e.complemento, e.bairro, e.CEP, t.ddd, t.n_fone from assinante as a
left outer join endereco as e on a.cd_assinante = e.cd_assinante
left outer join telefone as t on e.cd_endereco = t.cd_endereco;

/*Listar os nomes dos assinantes, seguido do seu ramo, ordenados por ramo e posteriormente 
por nome.*/
select a.nome, r.ds_ramo from assinante as a
left outer join ramo as r on a.cd_ramo = r.cd_ramo
order by r.ds_ramo, a.nome;

/*Listar os assinantes do município de Pelotas que são do tipo residencial.*/
select a.cd_assinante, a.nome, m.ds_municipio, t.ds_tipo from assinante as a
left outer join endereco as e on a.cd_assinante = e.cd_assinante
join municipio as m on m.cd_municipio = e.cd_municipio
join tipo as t on t.cd_tipo = a.cd_tipo
where m.ds_municipio = 'Pelotas' and t.ds_tipo = 'Residencial';

/*Listar os nomes dos assinantes que possuem mais de um telefone.*/
select a.nome, count(a.cd_assinante) as 'Qtd de números' from assinante as a
join endereco as e on a.cd_assinante = e.cd_assinante
join telefone as t on e.cd_endereco = t.cd_endereco
group by a.nome
having count(a.cd_assinante) > 1;

/*Listar os nomes dos assinantes seguido do número do telefone, tipo de assinante
comercial, com endereço em Natal ou João Câmara.*/
select a.nome, tf.n_fone, tp.ds_tipo, m.ds_municipio from assinante as a
left outer join endereco as e on e.cd_assinante = a.cd_assinante
join telefone as tf on tf.cd_endereco = e.cd_endereco
join tipo as tp on tp.cd_tipo = a.cd_tipo
join municipio as m on m.cd_municipio = e.cd_municipio
where m.ds_municipio = 'Natal' or m.ds_municipio = 'João Câmara';