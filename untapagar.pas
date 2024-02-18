unit untApagar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBDateTimePicker, untFrmBase;

type

  { TfrmApagar }

  TfrmApagar = class(TfrmBase)
    btnRedefinirPgot: TButton;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnInserirClick(Sender: TObject);
    procedure btnRedefinirPgotClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmApagar: TfrmApagar;

implementation

{$R *.lfm}

{ TfrmApagar }

procedure TfrmApagar.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmApagar.btnInserirClick(Sender: TObject);
begin
  inherited;
  DBEdit2.SetFocus;
  DS.DataSet.FieldByName('VENCIMENTO').AsDateTime:= now;
end;

procedure TfrmApagar.btnRedefinirPgotClick(Sender: TObject);
begin
  DS.DataSet.Edit;
  DS.DataSet.FieldByName('PAGO').AsString := '';
  DS.DataSet.Post;

  Application.MessageBox('Data de pagamento removida', 'Aviso');
  DS.DataSet.close;
  DS.DataSet.open;
end;

end.

