unit untAutoUpdate;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, untDM,
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  SQLDB, IBConnection {for Firebird};

  type

    { tuntAutoUpdate }

    tuntAutoUpdate = class
      public
        procedure ensureDb();
        procedure updateVersion();
        procedure loadVersion();
        procedure updVersion(version: int32);
        procedure autoInc(name: string);
    end;

var
  version: int32;

implementation

{ tuntAutoUpdate }

procedure tuntAutoUpdate.ensureDb();
var
  Fire: TIBConnection;
begin
  //Connection to Firebird database
    // The next line is needed for quite old FPC versions
    // Newer versions will first look for fbembed.dll in the application directory automatically
    //UseEmbeddedFirebird:=true; // Using embedded (and fbembed.dll) or regular client/server (fbclient.dll), requires ibase60dyn in uses
    Fire:=TIBConnection.Create(nil);
    try
      Fire.HostName := ''; //must be empty for embedded Firebird; must be filled for client/server Firebird
      Fire.DatabaseName := 'rodaty.fdb'; //(path and) filename
      // Username and password do not matter for authentication, but you do get authorizations in the database
      // based on the name (and optionally role) you give.
      Fire.Username := 'SYSDBA';
      Fire.Password := 'masterkey'; //default password for SYSDBA
      Fire.Charset := 'UTF8'; //Send and receive string data in UTF8 encoding
      Fire.Dialect := 3; //Nobody uses 1 or 2 anymore.
      Fire.Params.Add('PAGE_SIZE=16384'); //I like a large page size (used when creating a database). Useful for larger indexes=>larger possible column sizes

      // Find out if there is a database in the application directory.
      // If not, create it. Note: this may fail if you don't have enough permissions.

      // If you use client/server, you obviously don't need this part of the code.
      if (FileExists('rodaty.fdb')=false) then
      begin
//          writeln('File '+'rodaty.fdb'+' does not exist.');
//          writeln('Creating a Firebird embedded database...');
          // Create the database as it doesn't exist
          try
            Fire.CreateDB; //Create the database file.
            DataModule1.runQuery('CREATE TABLE SISTEMA (id INTEGER PRIMARY KEY, '+
                     'versao VARCHAR(10), ano_mes_ultima_mensalidade VARCHAR(6));');
          except
            on E: Exception do
            begin
              writeln('ERROR creating database. Probably problems loading embedded library:');
              writeln('- not all files present');
              writeln('- wrong architecture (e.g. 32 bit instead of 64 bit)');
              writeln('Exception message:');
              writeln(E.ClassName+'/'+E.Message);
            end;
          end;
          Fire.Close;
      end;
    finally
      Fire.Free;
    end;
end;

procedure tuntAutoUpdate.updateVersion();
begin
  DataModule1.runQuery('INSERT INTO SISTEMA (id, versao, ano_mes_ultima_mensalidade) '+
                       'SELECT 1, ''1'', '''' FROM RDB$DATABASE WHERE NOT EXISTS ( '+
                       'SELECT 1 FROM SISTEMA WHERE id = 1)');

  loadVersion();

  if version <= 1 then
  begin
    DataModule1.runQuery('CREATE TABLE CONTABANCARIA (id INTEGER PRIMARY KEY, nome VARCHAR(50), saldo bigint);');
    autoInc('CONTABANCARIA');

    DataModule1.runQuery('CREATE TABLE MEMBRO (id INTEGER PRIMARY KEY, '+
                                              'nome VARCHAR(100), '+
                                              'ativo INTEGER, '+
                                              'whatsapp VARCHAR(20));');
    autoInc('MEMBRO');

    DataModule1.runQuery('CREATE TABLE CONTACONTABIL (id INTEGER PRIMARY KEY, nome VARCHAR(100));');
    autoInc('CONTACONTABIL');

    updVersion(2);
  end;

  if version <= 2 then
  begin
    DataModule1.runQuery('CREATE TABLE MENSALIDADE (id INTEGER PRIMARY KEY, '+
                         ' membro_id INTEGER, '+
                         ' anomes VARCHAR(6), '+
                         ' pago INTEGER)');
    autoInc('MENSALIDADE');


    updVersion(3);
  end;

  if version <= 3 then
  begin
    DataModule1.runQuery('CREATE TABLE RECORRENTE (id INTEGER PRIMARY KEY, '+
                         ' tipo INTEGER, '+
                         ' recorrencia INTEGER, '+
                         ' valor BIGINT, '+
                         ' ultima_gerada DATE)');
    autoInc('RECORRENTE');

    DataModule1.runQuery('CREATE TABLE APAGAR (id INTEGER PRIMARY KEY, '+
                         ' descricao VARCHAR(100), '+
                         ' vencimento DATE, '+
                         ' pago DATE, '+
                         ' valor BIGINT, '+
                         ' recorrente_id INTEGER)');
    autoInc('APAGAR');

    updVersion(4);
  end;

  if version <= 4 then
  begin
    DataModule1.runQuery('CREATE TABLE ARECEBER (id INTEGER PRIMARY KEY, '+
                         ' descricao VARCHAR(100), '+
                         ' vencimento DATE, '+
                         ' pago DATE, '+
                         ' valor BIGINT)');
    autoInc('ARECEBER');

    DataModule1.runQuery('ALTER TABLE SISTEMA ADD ano_mes_ultima_recorrencia VARCHAR(6) DEFAULT '''';');

    updVersion(5);
  end;
end;

procedure tuntAutoUpdate.loadVersion();
begin
  version := DataModule1.runIntScalar('SELECT versao FROM SISTEMA');
end;

procedure tuntAutoUpdate.updVersion(version: int32);
begin
  DataModule1.runQuery('UPDATE SISTEMA SET versao = '''+ IntToStr(version)+'''');
end;

procedure tuntAutoUpdate.autoInc(name: string);
begin
  DataModule1.runQuery('CREATE SEQUENCE ' + LowerCase(name) + '_generator');
  DataModule1.runQuery('CREATE TRIGGER trg_bef_ins_' + LowerCase(name) + ' for ' + LowerCase(name) + ' '+
                       'BEFORE INSERT position 0 '+
                       'AS BEGIN '+
//                       'new.id = gen_id("' + LowerCase(name) + '_generator",1); '+
                       'new.id = NEXT VALUE FOR ' + LowerCase(name) + '_generator; '+
                       'END;');
end;

end.

