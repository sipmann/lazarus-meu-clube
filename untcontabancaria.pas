unit untContaBancaria;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  untFrmBase;

type

  { TfrmContaBancaria }

  TfrmContaBancaria = class(TfrmBase)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnEditarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmContaBancaria: TfrmContaBancaria;

implementation

{$R *.lfm}

{ TfrmContaBancaria }

procedure TfrmContaBancaria.FormCreate(Sender: TObject);
begin
  DS.DataSet.Open;
end;

procedure TfrmContaBancaria.btnInserirClick(Sender: TObject);
begin
  inherited;

  DBEdit1.SetFocus;
end;

procedure TfrmContaBancaria.btnEditarClick(Sender: TObject);
begin
  inherited;

  DBEdit1.SetFocus;
end;

end.

