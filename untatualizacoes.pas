unit untAtualizacoes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, untDM;

type

  { TfrmAtualizacoes }

  TfrmAtualizacoes = class(TForm)
    btnRun: TButton;
    mnSQL: TMemo;
    procedure btnRunClick(Sender: TObject);
  private

  public

  end;

var
  frmAtualizacoes: TfrmAtualizacoes;

implementation

{$R *.lfm}

{ TfrmAtualizacoes }

procedure TfrmAtualizacoes.btnRunClick(Sender: TObject);
begin
     DataModule1.runQuery(mnSQL.Text);
     Application.MessageBox('Atualização executada com sucesso!', 'Sucesso');
end;

end.

