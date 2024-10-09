CREATE DATABASE IF NOT EXISTS sncf ;

CREATE TABLE GARE (
    codeGare INT,
    nomGare VARCHAR(50),
    nomVille VARCHAR(50),
    CONSTRAINT pk_gare PRIMARY KEY(codeGare)
);

CREATE TABLE TRAIN (
    numTrain INT,
    codeGareDep INT, 
    CodeGareARR INT,
    HDep DATETIME,
    HArr DATETIME,
    CodeTrf CHAR(1),
    CONSTRAINT pk_train PRIMARY KEY (numTrain),
    CONSTRAINt fk_gareDep FOREIGN KEY (codeGareDep)  REFERENCES GARE(codeGare),
    CONSTRAINt fk_gareArr FOREIGN KEY (codeGareArr)  REFERENCES GARE(codeGare)
);

CREATE TABLE COMPOSITION (
    numTrain INT,
    dateDep DATETIME,
    Ass1 INT, 
    Ass2 INT, 
    Cch1 INT, 
    Cch2 INT,
    CONSTRAINT pk_composition PRIMARY KEY (numTrain, dateDep),
    CONSTRAINt fk_trainComp FOREIGN KEY (numTrain)  REFERENCES TRAIN(numTrain)
);

CREATE TABLE EXCEPTION (
    numTrain INT,
    dateDep DATETIME,
    CONSTRAINT pk_exception PRIMARY KEY (numTrain, dateDep),
    CONSTRAINt fk_trainExcep FOREIGN KEY (numTrain)  REFERENCES TRAIN(numTrain)
);