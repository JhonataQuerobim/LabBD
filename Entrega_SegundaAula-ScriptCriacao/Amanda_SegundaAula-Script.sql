create TABLE banco (
  nrobanco    Number(10),
  cnpj        Number(10)    constraint cnpj_banco NOT NULL,
  cep         Number(10)    constraint cep_banco NOT NULL,
  estado      Varchar2(2)   constraint estado_banco NOT NULL,
  logradouro  Varchar2(100) constraint logradouro_banco NOT NULL,
  nro         Number(5)     constraint nro_banco NOT NULL,  
  compl       Varchar2(100),
  constraint pk_banco PRIMARY KEY (nrobanco) 
 );
  
  create TABLE agencia(
    nrobanco    Number(10),
    nroagencia  Number(10),
    cidade      Varchar2(20)  constraint cidade_agencia NOT NULL,
    constraint fk_agencia FOREIGN KEY (nrobanco) REFERENCES banco(nrobanco),
    constraint pk_agencia PRIMARY KEY (nrobanco, nroagencia)
 );
  
create TABLE conta(
  nrobanco    Number(10),
  nroagencia  Number(10),
  nroconta    Number(10),
  saldo       Number(10)  constraint saldo_conta NOT NULL,
  constraint fk_conta_nrobanco FOREIGN KEY (nrobanco) REFERENCES banco(nrobanco),
  constraint fk_conta_nroagencia FOREIGN KEY (nroagencia) REFERENCES agencia(nroagencia),
  constraint pk_conta PRIMARY KEY (nrobanco, nroagencia, nroconta)
);

create TABLE cliente(
  cpf       Varchar2(10),
  email     Varchar2(100) constraint email_cliente NOT NULL,
  pnome     Varchar2(20)  constraint pnome_cliente NOT NULL,
  sobrenome Varchar2(50)  constraint sobrenome_cliente NOT NULL,
  constraint pk_cliente PRIMARY KEY (cpf)
);

create TABLE corrente(
  nrobanco    Number(10),
  nroagencia  Number(10),
  nroconta    Number(10),
  limite      Number(10)  constraint limite_corrente NOT NULL,
  constraint fk_corrente_nrobanco FOREIGN KEY (nrobanco) REFERENCES banco(nrobanco),
  constraint fk_corrente_nroagencia FOREIGN KEY (nroagencia) REFERENCES agencia(nroagencia),
  constraint fk_corrente_nroconta FOREIGN KEY (nroconta) REFERENCES conta(nroconta),
  constraint pk_corrente PRIMARY KEY (nrobanco, nroagencia, nroconta)
);

create TABLE poupanca(
  nrobanco      Number(10),
  nroagencia    Number(10),
  nroconta      Number(10),
  aniversario   Number(10)  constraint limite_corrente NOT NULL,
  constraint fk_corrente_nrobanco FOREIGN KEY (nrobanco) REFERENCES banco(nrobanco),
  constraint fk_corrente_nroagencia FOREIGN KEY (nroagencia) REFERENCES agencia(nroagencia),
  constraint fk_corrente_nroconta FOREIGN KEY (nroconta) REFERENCES conta(nroconta),
  constraint pk_corrente PRIMARY KEY (nrobanco, nroagencia, nroconta)
);

create TABLE correntista(
  cpf        Number(10),
  nrobanco   Number(10),
  nroagencia Number(10),
  nroconta   Number(10),
  constraint fk_correntista_cpf FOREIGN KEY (cpf) REFERENCES cliente(cpf),
  constraint fk_correntista_nrobanco FOREIGN KEY (nrobanco) REFERENCES banco(nrobanco),
  constraint fk_correntista_nroagencia FOREIGN KEY (nroagencia) REFERENCES agencia(nroagencia),
  constraint fk_correntista_nroconta FOREIGN KEY (nroconta) REFERENCES conta(nroconta),
  constraint pk_correntista PRIMARY KEY (cpf, nrobanco, nroagencia, nroconta)
);

create TABLE movimentacao(
  cpf         Number(10),
  nrobanco    Number(10),
  nroagencia  Number(10),
  nroconta    Number(10),
  datahora    Varchar2(10),
  valor       Varchar2(10)  constraint valor_movimentacao NOT NULL,
  tipo        Varchar2(10)  constraint tipo_movimentacao NOT NULL,
  constraint fk_movimentacao_cpf FOREIGN KEY (cpf) REFERENCES cliente(cpf),
  constraint fk_movimentacao_nrobanco FOREIGN KEY (nrobanco) REFERENCES banco(nrobanco),
  constraint fk_movimentacao_nroagencia FOREIGN KEY (nroagencia) REFERENCES agencia(nroagencia),
  constraint fk_movimentacao_nroconta FOREIGN KEY (nroconta) REFERENCES conta(nroconta),
  constraint pk_movimentacao PRIMARY KEY (cpf, nrobanco, nroagencia, nroconta, datahora)
);

create TABLE possui(
  cpf         Number(10),
  nrobanco    Number(10),
  nroagencia  Number(10),
  nroconta    Number(10),
  titular     Varchar2(50)  constraint titular_possui NOT NULL,
  constraint fk_possui_cpf FOREIGN KEY (cpf) REFERENCES cliente(cpf),
  constraint fk_possui_nrobanco FOREIGN KEY (nrobanco) REFERENCES banco(nrobanco),
  constraint fk_possui_nroagencia FOREIGN KEY (nroagencia) REFERENCES agencia(nroagencia),
  constraint fk_possui_nroconta FOREIGN KEY (nroconta) REFERENCES conta(nroconta),
  constraint pk_possui PRIMARY KEY (cpf, nrobanco, nroagencia, nroconta)
);
