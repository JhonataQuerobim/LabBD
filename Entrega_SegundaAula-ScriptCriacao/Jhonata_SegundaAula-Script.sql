drop table banco;
drop table agencia;
drop table conta;
drop table cliente;
drop table corrente;
drop table poupanca;
drop table possui;
drop table correntista;
drop table movimentacao;

create table banco(
nrobanco	number(10)	constraint banco_pk primary key,
cnpj		varchar2(14)	constraint banco_cnpj not null,
cep		varchar2(9)	constraint banco_cep not null,
estado		varchar2(2)	constraint banco_estado not null,
logradouro	varchar2(100)	constraint banco_logradouro not null,
nro		number(5)	constraint banco_nro not null,
complemento	varchar2(100));

create table agencia(
nrobanco,			constraint agencia_fk foreign key (nrobanco) references banco(nrobanco),
nroagencia	number(10),
cidade		varchar2(20)	constraint agencia_cidade not null,
constraint agencia_pk primary key (nrobanco, nroagencia));

create table conta(
nrobanco, nroagencia,
nroconta	number(10),
gerente		varchar2(100)	constraint conta_gerente not null,
saldo		number(10)	constraint conta_saldo not null,
constraint conta_fk foreign key (nrobanco, nroagencia) references agencia(nrobanco, nroagencia),
constraint conta_pk primary key (nrobanco, nroagencia, nroconta));

create table cliente(
cpf		varchar2(14)	constraint cliente_pk primary key,
email		varchar2(100)	constraint cliente_email not null,
pnome		varchar2(50)	constraint cliente_pnome not null,
sobrenome	varchar2(50)	constraint cliente_sobrenome not null);

create table corrente(
nrobanco, nroagencia, nroconta,
limite		number(10)	constraint corrente_limite not null,
constraint corrente_fk foreign key (nrobanco, nroagencia, nroconta) references conta (nrobanco, nroagencia, nroconta),
constraint corrente_pk primary key (nrobanco, nroagencia, nroconta));

create table poupanca(
nrobanco, nroagencia, nroconta,
aniversario	number(10)	constraint poupanca_aniversario not null,
constraint poupanca_fk foreign key (nrobanco, nroagencia, nroconta) references conta (nrobanco, nroagencia, nroconta),
constraint poupanca_pk primary key (nrobanco, nroagencia, nroconta));

create table possui(
cpf, nrobanco, nroagencia, nroconta,
titular		varchar2(50)	constraint possui_titular not null,
constraint possui_fk_cliente foreign key (cpf) references cliente(cpf),
constraint possui_fk_conta foreign key (nrobanco, nroagencia, nroconta) references conta (nrobanco, nroagencia, nroconta),
constraint possui_pk primary key (cpf, nrobanco, nroagencia, nroconta));

create table correntista(
cpf, nrobanco, nroagencia, nroconta,
constraint correntista_fk foreign key (cpf, nrobanco, nroagencia, nroconta) references possui (cpf, nrobanco, nroagencia, nroconta),
constraint correntista_pk primary key (cpf, nrobanco, nroagencia, nroconta));

create table movimentacao(
cpf, nrobanco, nroagencia, nroconta,
valor		varchar2(10)	constraint movimentacao_valor not null,
tipo		varchar2(10)	constraint movimentacao_tipo not null,
constraint movimentacao_fk foreign key (cpf, nrobanco, nroagencia, nroconta) references correntista (cpf, nrobanco, nroagencia, nroconta),
constraint movimentacao_pk primary key (cpf, nrobanco, nroagencia, nroconta));