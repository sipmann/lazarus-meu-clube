unit untContaContabil;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  untFrmBase;

type

  { TfrmContaContabil }

  TfrmContaContabil = class(TfrmBase)
    DBEdit1: TDBEdit;
    Label1: TLabel;
    procedure btnEditarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
  private

  public

  end;

var
  frmContaContabil: TfrmContaContabil;

implementation

{$R *.lfm}

{ TfrmContaContabil }

procedure TfrmContaContabil.btnInserirClick(Sender: TObject);
begin
  inherited;
  DBEdit1.SetFocus;
end;

procedure TfrmContaContabil.btnEditarClick(Sender: TObject);
begin
  inherited;
  DBEdit1.SetFocus;
end;

end.

