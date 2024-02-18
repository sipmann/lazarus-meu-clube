unit untMembro;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  untFrmBase;

type

  { TfrmMembro }

  TfrmMembro = class(TfrmBase)
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnInserirClick(Sender: TObject);
  private

  public

  end;

var
  frmMembro: TfrmMembro;

implementation

{$R *.lfm}

{ TfrmMembro }

procedure TfrmMembro.btnInserirClick(Sender: TObject);
begin
  inherited;
  DBEdit1.SetFocus;
end;

end.

