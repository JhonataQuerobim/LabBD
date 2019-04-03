drop table Movimentacao;
drop table Correntista;
drop table Possui;
drop table Poupanca;
drop table Corrente;
drop table Conta;
drop table Agencia;
drop table Cliente;
drop table Banco;

create table Banco
	(nrobanco integer constraint disciplina_pk primary key,
		cnpj integer,
		endereco_cep varchar2(10),
		endereco_estado varchar2(2),
		endereco_logradouro varchar2(50),
		endereco_nro integer,
		endereco_compl varchar2(50));

create table Cliente
	(cpf varchar2(15) constraint docente_pk primary key,
		email varchar2(50),
		nome varchar2(30),
		sobrenome varchar2(30));

create table Agencia
	(nrobanco constraint banco_nrobanco_fk references Banco (nrobanco),
		nroagencia integer,
		cidade varchar2(30),
		constraint agencia_pk primary key (nrobanco, nroagencia));

create table Conta
	(nroconta varchar2(15),
		nrobanco,
		nroagencia,
		saldo number,
		gerente varchar2(50),
		constraint conta_agencia_fk foreign key (nrobanco, nroagencia) references Agencia (nrobanco, nroagencia),
		constraint conta_pk primary key (nrobanco, nroagencia, nroconta));

create table Corrente
	(nrobanco,
		nroagencia,
		nroconta,
		limite number,
		constraint corrente_conta_fk foreign key (nrobanco, nroagencia, nroconta) references Conta (nrobanco, nroagencia, nroconta),
		constraint corrente_pk primary key (nrobanco, nroagencia, nroconta));

create table Poupanca
	(nrobanco,
		nroagencia,
		nroconta,
		aniversario date,
		constraint poupanca_conta_fk foreign key (nrobanco, nroagencia, nroconta) references Conta (nrobanco, nroagencia, nroconta),
		constraint poupanca_pk primary key (nrobanco, nroagencia, nroconta));

create table Possui
	(cpf,
		nrobanco,
		nroagencia,
		nroconta,
		titular varchar2(50),
		constraint possui_cliente_fk foreign key (cpf) references Cliente (cpf),
		constraint possui_conta_fk foreign key (nrobanco, nroagencia, nroconta) references Conta (nrobanco, nroagencia, nroconta),
		constraint possui_pk primary key (cpf, nrobanco, nroagencia, nroconta));

create table Correntista
	(cpf,
		nrobanco,
		nroagencia,
		nroconta,
		constraint correntista_possui_fk foreign key (cpf, nrobanco, nroagencia, nroconta) references Possui (cpf, nrobanco, nroagencia, nroconta),
		constraint correntista_pk primary key (cpf, nrobanco, nroagencia, nroconta));

create table Movimentacao
	(cpf,
		nrobanco,
		nroagencia,
		nroconta,
		datahora date,
		valor number,
		tipo varchar2(10),
		constraint movimentacao_correntista_fk foreign key (cpf, nrobanco, nroagencia, nroconta) references Correntista (cpf, nrobanco, nroagencia, nroconta),
		constraint movimentacao_pk primary key (cpf, nrobanco, nroagencia, nroconta, datahora));

