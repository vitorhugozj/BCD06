create database school_lesson;

use school_lesson;

create table alunos
(
aluno_id integer primary key,
nome varchar (100) not null,
data_nascimento date,
endereco varchar (100) not null,
telefone varchar (20) not null
);

INSERT INTO Alunos (aluno_id, nome, data_nascimento, endereco, telefone)
VALUES
 (1, 'João Silva', '1995-03-15', 'Rua A, 123', '(11) 1234-5678'),
 (2, 'Maria Santos', '1998-06-22', 'Av. B, 456', '(11) 9876-5432'),
 (3, 'Carlos Oliveira', '1997-01-10', 'Rua C, 789', '(11) 5678-1234'),
 (4, 'Ana Pereira', '1999-09-05', 'Av. D, 987', '(11) 4321-8765'),
 (5, 'Pedro Rodrigues', '1996-07-18', 'Rua E, 654', '(11) 3456-7890'),
 (6, 'Sara Costa', '2000-04-30', 'Av. F, 321', '(11) 8765-4321');

create table professores
(
professor_id integer primary key,
nome varchar (100) not null,
data_contratacao date
);

INSERT INTO Professores (professor_id, nome, data_contratacao)
VALUES
 (1, 'Ana Lima', '2010-08-15'),
 (2, 'José Santos', '2005-04-20'),
 (3, 'Márcio Oliveira', '2012-11-10'),
 (4, 'Cláudia Pereira', '2014-03-25'),
 (5, 'Fernanda Rodrigues', '2018-09-08'),
 (6, 'Ricardo Costa', '2019-12-01');


create table disciplinas
(
disciplina_id integer primary key,
nome_disciplina varchar (100) not null,
codigo_disciplina varchar (100) not null,
carga_horaria int
);

INSERT INTO Disciplinas (disciplina_id, nome_disciplina, codigo_disciplina, carga_horaria)
VALUES
 (1, 'Programação em C', 'PC101', 60),
 (2, 'Banco de Dados', 'BD201', 45),
 (3, 'Desenvolvimento Web', 'DW301', 75),
 (4, 'Algoritmos Avançados', 'AA401', 60),
 (5, 'Inteligência Artificial', 'IA501', 90),
 (6, 'Segurança da Informação', 'SI601', 45);

create table turmas
(
turma_id integer primary key,
ano_escolar int,
foreign key(turma_id) references disciplinas(disciplina_id),
foreign key (turma_id) references professores(professor_id)
);

INSERT INTO Turmas (turma_id, ano_escolar, disciplina_id, professor_id)
VALUES
 (101, 2023, 1, 1),
 (102, 2023, 2, 2),
 (103, 2023, 3, 3),
 (104, 2023, 4, 4),
 (105, 2023, 5, 5),
 (106, 2023, 6, 6);

create table notas 
(
nota_id integer primary key,
aluno_id integer,
disciplina_id integer,
data_avaliacao date,
nota int,
foreign key (nota_id) references alunos(aluno_id),
foreign key (nota_id) references disciplinas (disciplina_id)
);

INSERT INTO Notas (nota_id, aluno_id, disciplina_id, data_avaliacao, nota)
VALUES
 (1, 1, 1, '2023-03-10', 85),
 (2, 2, 1, '2023-03-10', 78),
 (3, 3, 1, '2023-03-10', 92),
 (4, 4, 2, '2023-03-15', 88),
 (5, 5, 2, '2023-03-15', 95),
 (6, 6, 2, '2023-03-15', 75);

create table presenca
(
presenca_id integer primary key,
aluno_id integer,
turma_id integer,
data_aula date,
presenca varchar (100) not null
);

INSERT INTO Presenca (presenca_id, aluno_id, turma_id, data_aula, presenca)
VALUES
 (1, 1, 101, '2023-03-10', 'presente'),
 (2, 2, 101, '2023-03-10', 'presente'),
 (3, 3, 101, '2023-03-10', 'presente'),
 (4, 4, 102, '2023-03-15', 'ausente'),
 (5, 5, 102, '2023-03-15', 'presente'),
 (6, 6, 102, '2023-03-15', 'presente');

-- 1.Qual é o nome do professor que ministra a disciplina com código "BD201"?
 
  	select turmas.turma_id, professores.nome,disciplinas.codigo_disciplina from turmas 
  	join professores on turmas.professor_id = professores.professor_id
  	join disciplinas on turmas.disciplina_id = disciplinas.disciplina_id
  	where codigo_disciplina = 'BD201';
  
 -- 2.Para a disciplina com código "PC101", obtenha a lista de alunos que obtiveram notas maiores que 80.

  	select notas.nota, alunos.nome, disciplinas.codigo_disciplina from alunos
  	inner join notas on alunos.aluno_id = notas.aluno_id
  	inner join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
  	where disciplinas.codigo_disciplina = 'PC101' and notas.nota > 80;
 
 -- 3.Quais alunos estiveram presentes na aula da turma com ID 101 na data '2023-03-10'?

  	select alunos.nome, presenca.presenca, presenca.data_aula from alunos
  	inner join presenca on alunos.aluno_id = presenca.aluno_id
  	where presenca.turma_id = '101' and presenca.data_aula = '2023-03-10' and presenca.presenca ='presente';
 
 -- 4.Calcule a média das notas dos alunos na disciplina com código "IA501".

  	select avg(nota) as media from notas
  	inner join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
  	where disciplinas.codigo_disciplina = 'IA501';

 -- 5.Liste todos os alunos e as disciplinas que eles estão matriculados. Inclua os alunos que não estão matriculados em nenhuma disciplina.

  	select alunos.nome, disciplinas.nome_disciplina from alunos
  	left join notas on alunos.aluno_id = notas.aluno_id
  	left join disciplinas on notas.disciplina_id = disciplinas.disciplina_id;
 
 -- 6.Liste todos os alunos que não têm notas registradas.

  	select notas.nota, alunos.nome from alunos
  	left join notas on alunos.aluno_id = notas.aluno_id
  	where notas.nota is null;
 
 -- 7.Quais disciplinas têm menos de 40 horas de carga horária ou mais de 100 horas de carga horária?

  	select disciplinas.nome_disciplina as nome_disciplinas from disciplinas
  	where carga_horaria < 40 or carga_horaria > 100;
 
 -- 8.Encontre o nome dos professores que não estão ministrando a disciplina "IA501".

  	select turmas.turma_id, professores.nome, disciplinas.codigo_disciplina from turmas
  	inner join professores on turmas.professor_id = professores.professor_id
  	inner join disciplinas on turmas.disciplina_id = disciplinas.disciplina_id
  	where not codigo_disciplina = 'IA501';

 -- 9.Quais turmas não têm professores atribuídos?

  	select turmas.ano_escolar, professores.nome from turmas
  	inner join professores on turmas.professor_id = professores.professor_id
  	where professores.professor_id is null;

 -- 10.Liste as disciplinas e seus códigos onde pelo menos um aluno obteve uma nota menor que 60.

  	select disciplinas.nome_disciplina, disciplinas.codigo_disciplina from disciplinas
  	left join notas on disciplinas.disciplina_id = notas.disciplina_id
  	left join alunos on notas.aluno_id = notas.aluno_id
  	where notas.nota < 60;

 -- 11.Qual é a média das notas dos alunos na disciplina com código "DW301" entre '2023-03-01' e '2023-03-31'?
 
  	select avg (nota) as media from notas 
  	inner join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
  	where disciplinas.codigo_disciplina = 'DW301' and notas.data_avaliacao between '2023-03-01' and '2023-03-31';

 -- 12.Liste todos os alunos que estão matriculados em mais de uma disciplina.
   
  	 select alunos.nome, count(alunos.aluno_id) as matricula from alunos
  	 inner join notas on alunos.aluno_id = notas.disciplina_id
  	 inner join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
  	 group by alunos.nome having matricula > 1;

 -- 13.Quais são os anos escolares distintos das turmas onde pelo menos um aluno faltou?
  
  	select turmas.ano_escolar from turmas
  	inner join presenca on turmas.turma_id = presenca.turma_id
  	where presenca = 'ausente';

 -- 14.Mostre o nome dos professores que estão ministrando a disciplina "PC101" ou "BD201".

  	select professores.nome from professores
  	inner join turmas on professores.professor_id = turmas.professor_id
  	inner join disciplinas on turmas.disciplina_id = disciplinas.disciplina_id
  	where disciplinas.codigo_disciplina = 'PC101' or disciplinas.codigo_disciplina = 'BD201';

 -- 15.Qual é o nome do aluno que faltou em todas as aulas?
  
  	select alunos.nome from alunos
  	inner join presenca on alunos.aluno_id = presenca.aluno_id
  	where not presenca.presenca = 'presente';

 -- 16.Liste as disciplinas e seus códigos onde todos os alunos obtiveram uma nota maior ou igual a 70.

  	select disciplinas.nome_disciplina, disciplinas.codigo_disciplina, min(nota) as menor_nota from disciplinas
  	inner join notas on disciplinas.disciplina_id = notas.disciplina_id
  	group by disciplinas.nome_disciplina, disciplinas.codigo_disciplina having menor_nota >= 70;

 -- 17.Quais alunos obtiveram notas entre 80 e 90 na disciplina "IA501" ou "DW301"?
 
  	select alunos.nome from alunos
  	inner join notas on alunos.aluno_id = notas.aluno_id
  	inner join disciplinas on notas.disciplina_id = disciplinas.disciplina_id
  	where disciplinas.codigo_disciplina = 'IA501' and notas.nota between 80 and 90
  	or disciplinas.codigo_disciplina = 'DW201' and notas.nota between 80 and 90;

 -- 18.Encontre o nome dos professores que não estão ministrando nenhuma disciplina com carga horária superior a 60 horas.
 
  	select professores.nome from professores
  	inner join turmas on professores.professor_id = turmas.professor_id
  	inner join disciplinas on turmas.disciplina_id = disciplinas.disciplina_id
  	where disciplinas.carga_horaria <= 60;

 -- 19.Quais são as datas de aulas para a disciplina com código "AA401" entre '2023-04-01' e '2023-04-30' onde pelo menos um aluno faltou?
  
  	select presenca.data_aula from presenca
  	join turmas on presenca.turma_id = turmas.turma_id
  	join disciplinas on turmas.disciplina_id = disciplinas.disciplina_id
  	where disciplinas.codigo_disciplina = "AA401" 
  	and presenca.data_aula between "2023-04-01" and "2023-04-30" 
  	and not presenca.presenca = "presente"; 

 -- 20.Liste os nomes dos alunos que não faltaram em nenhuma aula.
  
  	select alunos.nome from alunos
  	join presenca on alunos.aluno_id = presenca.aluno_id
  	where not presenca.presenca = "ausente";
