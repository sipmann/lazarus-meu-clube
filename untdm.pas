unit untDM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, IBConnection, DB, sqlite3dyn;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    FBConn: TIBConnection;
    queApagarDESCRICAO: TStringField;
    queApagarID: TLongintField;
    queApagarPAGO: TDateField;
    queApagarRECORRENTE_ID: TLongintField;
    queApagarVALOR: TBCDField;
    queApagarVENCIMENTO: TDateField;
    queContaBancariaID: TLongintField;
    queContaBancariaNOME: TStringField;
    queContaBancariaSALDO: TBCDField;
    queContaContabilID: TLongintField;
    queContaContabilNOME: TStringField;
    queMembroATIVO: TLongintField;
    queMembroID: TLongintField;
    queMembroNOME: TStringField;
    queMembroWHATSAPP: TStringField;
    queApagar: TSQLQuery;
    queMensalidadeANOMES: TStringField;
    queMensalidadeID: TLongintField;
    queMensalidadeMEMBRO_ID: TLongintField;
    queMensalidadePAGO: TLongintField;
    queRecorrenteID: TLongintField;
    queRecorrenteRECORRENCIA: TLongintField;
    queRecorrenteTIPO: TLongintField;
    queRecorrenteTITULO: TStringField;
    queRecorrenteULTIMA_GERADA: TDateField;
    queRecorrenteVALOR: TLargeintField;
    queSistemaANO_MES_ULTIMA_MENSALIDADE: TStringField;
    queSistemaANO_MES_ULTIMA_RECORRENCIA: TStringField;
    queSistemaID: TLongintField;
    queSistemaVALOR_MENSALIDADE: TBCDField;
    queSistemaVERSAO: TStringField;
    SQLConn: TSQLite3Connection;
    queContaBancaria: TSQLQuery;
    queMembro: TSQLQuery;
    queContaContabil: TSQLQuery;
    queMensalidade: TSQLQuery;
    queRecorrente: TSQLQuery;
    queSistema: TSQLQuery;
    trGeral: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure queContaBancariaAfterDelete(DataSet: TDataSet);
    procedure queContaBancariaAfterPost(DataSet: TDataSet);
  private

  public
    procedure runQuery(sql: String);
    function returnQuery(sql: String): TSQLQuery;
    function runScalar(sql: String): String;
    function runIntScalar(sql: String): Int32;

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  sqlite3dyn.SQLiteDefaultLibrary := GetCurrentDir + '\sqlite3.dll';


end;

procedure TDataModule1.queContaBancariaAfterDelete(DataSet: TDataSet);
begin
  (DataSet as TSQLQuery).ApplyUpdates();
  trGeral.Commit;
end;

procedure TDataModule1.queContaBancariaAfterPost(DataSet: TDataSet);
begin
  (DataSet as TSQLQuery).ApplyUpdates();
  trGeral.Commit;
end;

procedure TDataModule1.runQuery(sql: String);
var
  cds: TSQLQuery;
begin
  cds := TSQLQuery.Create(nil);
  cds.SQLConnection := FBConn;
  cds.SQL.Add(sql);
  cds.ExecSQL();
  trGeral.Commit;
  FreeAndNil(cds);
end;

function TDataModule1.returnQuery(sql: String): TSQLQuery;
var
  cds: TSQLQuery;
begin

  cds := TSQLQuery.Create(nil);
  cds.SQLConnection := FBConn;
  cds.SQL.Add(sql);
  cds.open;
  result := cds;
end;

function TDataModule1.runScalar(sql: String): String;
var
  cds: TSQLQuery;
begin
  cds := TSQLQuery.Create(nil);
  cds.SQLConnection := FBConn;
  cds.SQL.Add(sql);
  cds.open();
  if not cds.eof then
     result := cds.Fields[0].AsString;

  trGeral.Commit;
  FreeAndNil(cds);
end;

function TDataModule1.runIntScalar(sql: String): Int32;
var
  cds: TSQLQuery;
begin
  cds := TSQLQuery.Create(nil);
  cds.SQLConnection := FBConn;
  cds.SQL.Add(sql);
  cds.open();
  if not cds.eof then
     result := cds.Fields[0].AsInteger;

  trGeral.Commit;
  FreeAndNil(cds);
end;

end.

