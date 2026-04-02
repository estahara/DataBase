CREATE TABLE cidade
(
codcid int PRIMARY KEY,
nome varchar(40) NOT NULL,
uf char(2) NOT NULL
);

CREATE TABLE aluno
(
codalu int PRIMARY KEY,
cpf char(11) NOT NULL UNIQUE,
nome varchar(40) NOT NULL,
telefone varchar(20),
cidade int,
CONSTRAINT fk_cidade FOREIGN KEY (cidade) REFERENCES cidade(codcid)
);

CREATE TABLE curso
(
codcur int PRIMARY KEY,
nome varchar(30) NOT NULL,
cargahoraria int CHECK (cargahoraria > 0)
);

CREATE TABLE matricula
(
  codalu int,
  codcur int,
  nota decimal(4,2) CHECK (nota>=0 and nota <=10),
  PRIMARY KEY (codalu,codcur),
  CONSTRAINT fk_aluno FOREIGN KEY (codalu) REFERENCES aluno(codalu),
  CONSTRAINT fk_curso FOREIGN KEY (codcur) REFERENCES curso(codcur)
);

--01
alter table matricula add datacurso date;

--02
alter table curso add preco decimal(10,2) check (preco>0);

--03
create table categoria
(
  codcat int primary key,
  descricao varchar(20) not null
);

alter table curso add categoria int;
alter table curso add constraint fk_categoria foreign key(categoria) references categoria(codcat);


--EX1

insert into cidade values
(1, 'São Carlos', 'SP'),
(2, 'Araraquara', 'SP'),
(3, 'Londrina', 'PR'),
(4, 'Rio de Janeiro', 'RJ');

Select * from cidade;

insert into aluno values
(1, '1111', 'Maria', '9999-9999', 1),
(2, '22222', 'Celso', '8888-8888', 1),
(3, '3333', 'Joaquim', '7777-7777', null),
(4, '4444', 'Florinda', '6666-6666', 3);

select * from aluno;

--Ex3
insert into categoria values
(1, 'Programação'),
(2, 'Banco de Dados'),
(3, 'Machine Learning'),
(4, 'Redes');

--Ex4
insert into curso values
(1, 'Java', 30, 1400, 1),
(2, 'PostgreSQL', 30, 600, 2),
(3, 'Deep Learning', 20, 1000, 4),
(4, 'Python', 20, 500, 1);

--Ex5
insert into matricula values
(1, 1, 9.5, '2024-02-14'),
(1, 2, 10, '2024-03-01'),
(2, 4, 8.5, '2023-12-10'),
(4, 2, 9, '2024-04-01');

--Ex6
insert into matricula values
(2, 4, 9, '2024-04-10'); --da erro, violacao de PK

--7
alter table matricula drop constraint matricula_pkey;
alter table matricula add constraint matricula_pkey 
primary key (codalu, codcur, datacurso);

select * from matricula;

--Ex8
update aluno
set cidade=2
where codalu=3;

select * from aluno;

--Ex9
delete from categoria
where codcat=4; --viola FK

alter table curso
drop constraint fk_categoria;

alter table curso
add constraint fk_categoria
foreign key (categoria)
references categoria(codcat)
on update cascade on delete set null;

select * from curso;

--Ex10
update curso
set categoria=3
where codcur=3;

select * from curso;

--Ex11
update curso
set codcur=200
where codcur=2; --viola fk

alter table matricula
drop constraint fk_curso;

alter table matricula
add constraint fk_curso
foreign key(codcur) references curso(codcur)
on update cascade;

select * from curso;
select * from matricula;

--Ex12
delete from cidade
where uf='RJ';

select * from cidade;

--Ex13
update curso
set cargahoraria = cargahoraria + 10
where categoria = 1 or categoria = 2;


