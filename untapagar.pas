unit untApagar;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBDateTimePicker, untFrmBase, untDM, DB;

type

  { TfrmApagar }

  TfrmApagar = class(TfrmBase)
    btnRedefinirPgot: TButton;
    cbTipoRecorrencia: TComboBox;
    DBDateTimePicker1: TDBDateTimePicker;
    DBDateTimePicker2: TDBDateTimePicker;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnInserirClick(Sender: TObject);
    procedure btnRedefinirPgotClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DSDataChange(Sender: TObject; Field: TField);
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

procedure TfrmApagar.btnSalvarClick(Sender: TObject);
begin

  if cbTipoRecorrencia.ItemIndex > -1 then
  begin
    //TODO: Move this to a class method, so we can reuseit
    DataModule1.queRecorrente.close;
    DataModule1.queRecorrente.open;
    DataModule1.queRecorrente.Insert;
    DataModule1.queRecorrente.FieldByName('TIPO').AsInteger := 0; // A pagar
    DataModule1.queRecorrente.FieldByName('RECORRENCIA').AsInteger := cbTipoRecorrencia.ItemIndex;
    DataModule1.queRecorrente.FieldByName('TITULO').AsString := DS.DataSet.FieldByName('DESCRICAO').AsString;
    DataModule1.queRecorrente.FieldByName('VALOR').AsString := DS.DataSet.FieldByName('VALOR').AsString;
    DataModule1.queRecorrente.FieldByName('ULTIMA_GERADA').AsDateTime := Now;
    DataModule1.queRecorrente.Post;

    DS.DataSet.FieldByName('RECORRENTE_ID').AsInteger := DataModule1.queRecorrente.FieldByName('ID').AsInteger;
  end;

  inherited;
end;

procedure TfrmApagar.DSDataChange(Sender: TObject; Field: TField);
begin

end;

end.

