program meu_clube;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, frmMain, untDM, untFrmBase, untContaBancaria, untJobs,
  untAtualizacoes, untMembro, untAutoUpdate, untContaContabil, untMensalidades,
  untSobre, untApagar;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Meu Clube';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmBase, frmBase);
  Application.CreateForm(TfrmContaBancaria, frmContaBancaria);
  Application.CreateForm(TfrmAtualizacoes, frmAtualizacoes);
  Application.CreateForm(TfrmMembro, frmMembro);
  Application.CreateForm(TfrmContaContabil, frmContaContabil);
  Application.CreateForm(TfrmMensalidades, frmMensalidades);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.CreateForm(TfrmApagar, frmApagar);
  Application.Run;
  end.

