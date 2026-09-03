-- *********************************************
-- * Standard SQL generation                   
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Wed Sep  2 18:06:05 2026 
-- * LUN file: C:\Users\fedep\Desktop\Gestione di un B&B\Gestione di un Bed & Breakfast.lun 
-- * Schema: Schema Logico/SQL1 
-- ********************************************* 
-- Database Section
-- ________________ 
-- CREATE database Schema Logico; (creato in automatico da db-main)

CREATE DATABASE IF NOT EXISTS bedandbreakfast;

-- DBSpace Section
-- _______________

-- TABLES Section
-- _____________ 

USE bedandbreakfast; -- dice in quale DataBase creare le tabelle

CREATE TABLE CAMERA (
    tipologia char(15) not null,
    numeroMassimoOspiti numeric(2) not null,
    piano numeric(2) not null,
    descrizione varchar(200) not null,
    stato char(12) not null,
    prezzoBaseNotte numeric(8,2) not null,
    numeroCamera numeric(3) not null,
    CONSTRAINT ID_CAMERA_ID PRIMARY KEY (piano, numeroCamera));
    
CREATE TABLE INCLUDE (
    nomeServizio varchar(20) not null,
    codicePrenotazione numeric(6) not null,
    CONSTRAINT ID_INCLUDE_ID PRIMARY KEY (codicePrenotazione, nomeServizio));
    
CREATE TABLE OCCUPANTE (
    codicePrenotazione numeric(6) not null,
    nome varchar(25) not null,
    cognome varchar(25) not null,
    documentoIdentita char(9) not null,
    CONSTRAINT ID_OCCUPANTE_ID PRIMARY KEY (codicePrenotazione, documentoIdentita));
    
CREATE TABLE OSPITE (
    nome varchar(25) not null,
    cognome varchar(25) not null,
    telefono char(15) not null,
    e_mail varchar(50) not null,
    password varchar(16) not null,
    documentoIdentita char(9) not null,
    CONSTRAINT ID_OSPITE_ID PRIMARY KEY (documentoIdentita),
    CONSTRAINT SID_OSPITE_ID UNIQUE (e_mail));
    
CREATE TABLE PAGAMENTO (
    codicePagamento numeric(6) not null,
    codicePrenotazione numeric(6) not null,
    importoTotale numeric(8,2) not null,
    metodo varchar(20) not null,
    data date not null,
    CONSTRAINT ID_PAGAMENTO_ID PRIMARY KEY (codicePagamento),
    CONSTRAINT SID_PAGAM_PRENO_ID UNIQUE (codicePrenotazione));
    
CREATE TABLE PERSONALE (
    nome varchar(25) not null,
    cognome varchar(25) not null,
    telefono char(15) not null,
    e_mail varchar(50) not null,
    password varchar(16) not null,
    documentoIdentita char(9) not null,
    ruolo char(25) not null,
    CONSTRAINT ID_PERSONALE_ID PRIMARY KEY (documentoIdentita),
    CONSTRAINT SID_PERSONALE_ID UNIQUE (e_mail));
    
CREATE TABLE PRENOTAZIONE (
    codicePrenotazione numeric(6) not null,
    dataArrivo date not null,
    dataPartenza date not null,
    numeroOspiti numeric(2) not null,
    stato char(12) not null,
    dataCheckInEffettivo date,
    documentoIdentitaOspite char(9) not null,
    piano numeric(2) not null,
    numeroCamera numeric(3) not null,
    dataInizioStagione date,
    CONSTRAINT ID_PRENOTAZIONE_ID PRIMARY KEY (codicePrenotazione));
    
CREATE TABLE PULIZIA (
    piano numeric(2) not null,
    numeroCamera numeric(3) not null,
    data date not null,
    documentoIdentitaADDetto char(9) not null,
    CONSTRAINT ID_PULIZIA_ID PRIMARY KEY (piano, numeroCamera, data));
    
CREATE TABLE RECENSIONE (
    codiceRecensione numeric(6) not null,
    codicePrenotazione numeric(6) not null,
    voto numeric(2) not null,
    commento varchar(300),
    data date not null,
    CONSTRAINT ID_RECENSIONE_ID PRIMARY KEY (codiceRecensione),
    CONSTRAINT SID_RECEN_PRENO_ID UNIQUE (codicePrenotazione));
    
CREATE TABLE SERVIZIO_AGGIUNTIVO (
    nome varchar(20) not null,
    descrizione varchar(200) not null,
    costo numeric(5,2) not null,
    CONSTRAINT ID_SERVIZIO_AGGIUNTIVO_ID PRIMARY KEY (nome));
    
CREATE TABLE STAGIONE (
    nome varchar(20) not null,
    moltiplicatore numeric(3,2) not null,
    dataInizio date not null,
    dataFine date not null,
    CONSTRAINT ID_STAGIONE_ID PRIMARY KEY (dataInizio));
    
-- CONSTRAINTs Section
-- ___________________ 

ALTER TABLE INCLUDE ADD CONSTRAINT REF_INCLU_PRENO
FOREIGN KEY (codicePrenotazione)
REFERENCES PRENOTAZIONE;

ALTER TABLE INCLUDE ADD CONSTRAINT REF_INCLU_SERVI_FK
FOREIGN KEY (nomeServizio)
REFERENCES SERVIZIO_AGGIUNTIVO;

ALTER TABLE OCCUPANTE ADD CONSTRAINT REF_OCCUP_PRENO
FOREIGN KEY (codicePrenotazione)
REFERENCES PRENOTAZIONE;

ALTER TABLE PAGAMENTO ADD CONSTRAINT SID_PAGAM_PRENO_FK
FOREIGN KEY (codicePrenotazione)
REFERENCES PRENOTAZIONE;

ALTER TABLE PRENOTAZIONE ADD CONSTRAINT REF_PRENO_OSPIT_FK
FOREIGN KEY (documentoIdentitaOspite)
REFERENCES OSPITE;

ALTER TABLE PRENOTAZIONE ADD CONSTRAINT REF_PRENO_CAMER_FK
FOREIGN KEY (piano, numeroCamera)
REFERENCES CAMERA;

ALTER TABLE PRENOTAZIONE ADD CONSTRAINT REF_PRENO_STAGI_FK
FOREIGN KEY (dataInizioStagione)
REFERENCES STAGIONE;

ALTER TABLE PULIZIA ADD CONSTRAINT REF_PULIZ_PERSO_FK
FOREIGN KEY (documentoIdentitaADDetto)
REFERENCES PERSONALE;

ALTER TABLE PULIZIA ADD CONSTRAINT REF_PULIZ_CAMER
FOREIGN KEY (piano, numeroCamera)
REFERENCES CAMERA;

ALTER TABLE RECENSIONE ADD CONSTRAINT SID_RECEN_PRENO_FK
FOREIGN KEY (codicePrenotazione)
REFERENCES PRENOTAZIONE;

-- INDEX Section
-- _____________ 

CREATE UNIQUE INDEX ID_CAMERA_IND
ON CAMERA (piano, numeroCamera);

CREATE UNIQUE INDEX ID_INCLUDE_IND
ON INCLUDE (codicePrenotazione, nomeServizio);

CREATE INDEX REF_INCLU_SERVI_IND
ON INCLUDE (nomeServizio);

CREATE UNIQUE INDEX ID_OCCUPANTE_IND
ON OCCUPANTE (codicePrenotazione, documentoIdentita);

CREATE UNIQUE INDEX ID_OSPITE_IND
ON OSPITE (documentoIdentita);

CREATE UNIQUE INDEX SID_OSPITE_IND
ON OSPITE (e_mail);

CREATE UNIQUE INDEX ID_PAGAMENTO_IND
ON PAGAMENTO (codicePagamento);

CREATE UNIQUE INDEX SID_PAGAM_PRENO_IND
ON PAGAMENTO (codicePrenotazione);

CREATE UNIQUE INDEX ID_PERSONALE_IND
ON PERSONALE (documentoIdentita);

CREATE UNIQUE INDEX SID_PERSONALE_IND
ON PERSONALE (e_mail);

CREATE UNIQUE INDEX ID_PRENOTAZIONE_IND
ON PRENOTAZIONE (codicePrenotazione);

CREATE INDEX REF_PRENO_OSPIT_IND
ON PRENOTAZIONE (documentoIdentitaOspite);

CREATE INDEX REF_PRENO_CAMER_IND
ON PRENOTAZIONE (piano, numeroCamera);

CREATE INDEX REF_PRENO_STAGI_IND
ON PRENOTAZIONE (dataInizioStagione);

CREATE UNIQUE INDEX ID_PULIZIA_IND
ON PULIZIA (piano, numeroCamera, data);

CREATE INDEX REF_PULIZ_PERSO_IND
ON PULIZIA (documentoIdentitaADDetto);

CREATE UNIQUE INDEX ID_RECENSIONE_IND
ON RECENSIONE (codiceRecensione);

CREATE UNIQUE INDEX SID_RECEN_PRENO_IND
ON RECENSIONE (codicePrenotazione);

CREATE UNIQUE INDEX ID_SERVIZIO_AGGIUNTIVO_IND
ON SERVIZIO_AGGIUNTIVO (nome);

CREATE UNIQUE INDEX ID_STAGIONE_IND
ON STAGIONE (dataInizio);