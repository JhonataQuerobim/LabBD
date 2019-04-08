-- ESQUEMA LÓGICO PARA REFERÊNCIA

-- Banco(PK(nrobanco), cnpj, cep, estado, logradouro, nro, compl)
-- Cliente(PK(cpf), pnome, sobrenome, email)

-- Agência(PK(FK_Banco(nrobanco), nroagencia), cidade)
-- Conta(PK(FK_Agencia(nrobanco, nroagencia), nroconta), saldo, gerente)

-- Conta_Corrente(PK(FK_Conta(nrobanco, nroagencia, nroconta)), limite)
-- Conta_Poupança(PK(FK_Conta(nrobanco, nroagencia, nroconta)), aniversário)

-- Cl_Possui_Ct(PK(FK_Cliente(cpf), FK_Conta(nrobanco, nroagencia, nroconta)), titular)
-- Correntista(PK(FK_Cl_Possui_Ct(cpf, nrobanco, nroagencia, nroconta)))
-- Movimentação(PK(FK_Correntista(cpf, nrobanco, nroagencia, nroconta), datahora), valor, tipo)

DROP TABLE banco
DROP TABLE cliente
DROP TABLE agencia
DROP TABLE conta
DROP TABLE corrente
DROP TABLE poupanca
DROP TABLE cl_possui_ct
DROP TABLE correntista
DROP TABLE movimentacao

CREATE TABLE banco(
	nrobanco	NUMBER(10),
	cnpj		NUMBER(14)		CONSTRAINT cnpj_banco NOT NULL,
	cep			NUMBER(8)		CONSTRAINT cep_banco NOT NULL,
	estado		VARCHAR2(2) 	CONSTRAINT estado_banco NOT NULL,
	logradouro	VARCHAR2(80)	CONSTRAINT logr_banco NOT NULL,
	nro			NUMBER(6),
	compl		VARCHAR2(80),
	
	CONSTRAINT pk_banco PRIMARY KEY (nrobanco)
)

CREATE TABLE cliente(
	cpf			NUMBER(11),
	pnome		VARCHAR2(80)	CONSTRAINT pnome_cliente NOT NULL,
	sobrenome	VARCHAR2(80)	CONSTRAINT sobre_cliente NOT NULL,
	email		VARCHAR2(80)	CONSTRAINT email_cliente NOT NULL,
	
	CONSTRAINT pk_cliente PRIMARY KEY (cpf)
)

CREATE TABLE agencia(
	nrobanco	NUMBER(10),
	nroagencia	NUMBER(10),
	cidade		VARCHAR2(80)	CONSTRAINT cidade_agencia NOT NULL,
	
	CONSTRAINT fk_banco FOREIGN KEY (nrobanco) REFERENCES banco(nrobanco),
	CONSTRAINT pk_agencia PRIMARY KEY (nrobanco, nroagencia)
)

CREATE TABLE conta(
	nrobanco	NUMBER(10),
	nroagencia	NUMBER(10),
	nroconta	NUMBER(10),
	saldo		NUMBER(10),
	gerente		VARCHAR2(80)	CONSTRAINT gerente_conta NOT NULL,
	
	CONSTRAINT fk_agencia FOREIGN KEY (nrobanco, nroagencia) REFERENCES agencia(nrobanco, nroagencia),
	CONSTRAINT pk_conta PRIMARY KEY (nrobanco, nroagencia, nroconta)
)

CREATE TABLE corrente(
	nrobanco	NUMBER(10),
	nroagencia	NUMBER(10),
	nroconta	NUMBER(10),
	limite		NUMBER(10)		CONSTRAINT limite_corrente NOT NULL,
	
	CONSTRAINT fk_cc FOREIGN KEY (nrobanco, nroagencia, nroconta) REFERENCES conta(nrobanco, nroagencia, nroconta),
	CONSTRAINT pk_corrente PRIMARY KEY (nrobanco, nroagencia, nroconta)
)

CREATE TABLE poupanca(
	nrobanco	NUMBER(10),
	nroagencia	NUMBER(10),
	nroconta	NUMBER(10),
	aniversario	NUMBER(8)		CONSTRAINT niver_poupanca NOT NULL,
	
	CONSTRAINT fk_cp FOREIGN KEY (nrobanco, nroagencia, nroconta) REFERENCES conta(nrobanco, nroagencia, nroconta),
	CONSTRAINT pk_poupanca PRIMARY KEY (nrobanco, nroagencia, nroconta)
)

CREATE TABLE cl_possui_ct(
	cpf			NUMBER(11),
	nrobanco	NUMBER(10),
	nroagencia	NUMBER(10),
	nroconta	NUMBER(10),
	titular		VARCHAR2(80)	CONSTRAINT titular_possui NOT NULL,
	
	CONSTRAINT fk_cl_possui FOREIGN KEY (cpf) REFERENCES cliente(cpf),
	CONSTRAINT fk_possui_ct FOREIGN KEY (nrobanco, nroagencia, nroconta) REFERENCES conta(nrobanco, nroagencia, nroconta),
	CONSTRAINT pk_cl_possui_ct PRIMARY KEY (cpf, nrobanco, nroagencia, nroconta)
)

CREATE TABLE correntista(
	cpf			NUMBER(11),
	nrobanco	NUMBER(10),
	nroagencia	NUMBER(10),
	nroconta	NUMBER(10),
	
	CONSTRAINT fk_cl_possui_ct FOREIGN KEY (cpf, nrobanco, nroagencia, nroconta) REFERENCES cl_possui_ct(cpf, nrobanco, nroagencia, nroconta),
	CONSTRAINT pk_correntista PRIMARY KEY (cpf, nrobanco, nroagencia, nroconta)
)

CREATE TABLE movimentacao(
	cpf			NUMBER(11),
	nrobanco	NUMBER(10),
	nroagencia	NUMBER(10),
	nroconta	NUMBER(10),
	datahora	DATE,			-- O Oracle não reconheceu o uso de DATETIME
	valor		NUMBER(10)		CONSTRAINT valor_movimentacao NOT NULL,
	tipo		VARCHAR2(20)	CONSTRAINT tipo_movimentacao NOT NULL,
	
	CONSTRAINT fk_correntista FOREIGN KEY (cpf, nrobanco, nroagencia, nroconta) REFERENCES correntista(cpf, nrobanco, nroagencia, nroconta),
	CONSTRAINT pk_ PRIMARY KEY (cpf, nrobanco, nroagencia, nroconta, datahora)
)