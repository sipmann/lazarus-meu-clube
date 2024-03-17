unit untConfiguracoes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls;

type

  { TfrmConfig }

  TfrmConfig = class(TForm)
    btnSalvar: TButton;
    DSConfig: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.lfm}

{ TfrmConfig }

procedure TfrmConfig.FormCreate(Sender: TObject);
begin
  DSConfig.DataSet.Open;
  DSConfig.DataSet.Edit;
end;

procedure TfrmConfig.btnSalvarClick(Sender: TObject);
begin
  DSConfig.DataSet.Post;
  Close;
end;

end.

