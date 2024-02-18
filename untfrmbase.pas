unit untFrmBase;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, ExtCtrls,
  StdCtrls, LCLType, DBCtrls, ComCtrls, SQLDB;

type

  { TfrmBase }

  TfrmBase = class(TForm)
    btnCancelar: TButton;
    btnInserir: TButton;
    btnEditar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnPesquisar: TButton;
    DS: TDataSource;
    DBGrid1: TDBGrid;
    PageControl1: TPageControl;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DSStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private

  public
    procedure ChangeButtonsState(insert: Boolean; edit: Boolean; save: Boolean;
      del: Boolean; cancel: Boolean);
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.lfm}

{ TfrmBase }

procedure TfrmBase.btnInserirClick(Sender: TObject);
begin
  DS.DataSet.Cancel;
  DS.DataSet.Last;
  DS.DataSet.Append;
  DS.DataSet.ClearFields;
  ChangeButtonsState(false, false, true, false, true);

  StatusBar1.Panels[1].Text := 'Inserindo';
end;

procedure TfrmBase.btnPesquisarClick(Sender: TObject);
begin
  PageControl1.TabIndex := 1;
end;

procedure TfrmBase.btnEditarClick(Sender: TObject);
begin
  DS.DataSet.Edit;
  ChangeButtonsState(false, false, true, false, true);
  StatusBar1.Panels[1].Text := 'Editando';
end;

procedure TfrmBase.btnCancelarClick(Sender: TObject);
begin
  DS.DataSet.Cancel;
  ChangeButtonsState(true, true, false, true, false);
  StatusBar1.Panels[1].Text := 'Consultando';
end;

procedure TfrmBase.btnExcluirClick(Sender: TObject);
begin

  if (Application.MessageBox('Deseja Deletar?', 'Atenção', MB_ICONQUESTION + MB_YESNO) = IDYES) then
  begin
    DS.DataSet.Delete;

    Application.MessageBox('Registro removido com sucesso!', 'Sucesso');
    DS.DataSet.Open;
  end;
end;

procedure TfrmBase.btnSalvarClick(Sender: TObject);
begin
  DS.DataSet.Post;
  ChangeButtonsState(true, true, false, true, false);

  Application.MessageBox('Registro salvo com sucesso!', 'Sucesso');
  DS.DataSet.Open;

  StatusBar1.Panels[1].Text := 'Consultando';
end;

procedure TfrmBase.DBGrid1TitleClick(Column: TColumn);
begin
  (DS.DataSet as TSQLQuery).IndexFieldNames := Column.FieldName;
end;

procedure TfrmBase.DSStateChange(Sender: TObject);
begin
  StatusBar1.Panels[3].Text := DS.DataSet.RecordCount.ToString;
end;

procedure TfrmBase.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  DS.DataSet.Close;
end;

procedure TfrmBase.FormCreate(Sender: TObject);
begin

end;

procedure TfrmBase.FormShow(Sender: TObject);
begin
  DS.DataSet.Active := true;
  ChangeButtonsState(true, true, false, true, false);
  StatusBar1.Panels[1].Text := 'Consultando';
end;

procedure TfrmBase.PageControl1Change(Sender: TObject);
begin

end;

procedure TfrmBase.ChangeButtonsState(insert: Boolean; edit: Boolean;
  save: Boolean; del: Boolean; cancel: Boolean);
begin
  btnInserir.Enabled := insert;
  btnEditar.Enabled := edit;
  btnSalvar.Enabled := save;
  btnExcluir.Enabled := del;
  btnCancelar.Enabled := cancel;
end;



end.

