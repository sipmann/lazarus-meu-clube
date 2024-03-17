unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ComCtrls, Calendar, StdCtrls, DBCtrls, DBGrids, IniPropStorage,
  untContaBancaria, untAtualizacoes, untMembro, untDM,
  untContaContabil, untMensalidades, untSobre, untAPagar, DB, SQLDB, untConfiguracoes;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    calendarioContas: TCalendar;
    DSContasAPagar: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    MenuItem1: TMenuItem;
    mnConfiguracoes: TMenuItem;
    miContasAPagar: TMenuItem;
    MISobre: TMenuItem;
    MIMensalidades: TMenuItem;
    mnUpdate: TMenuItem;
    MIContaContabil: TMenuItem;
    MIContaBancaria: TMenuItem;
    MNMembro: TMenuItem;
    MICadastro: TMenuItem;
    MISair: TMenuItem;
    mnArquivo: TMenuItem;
    MM: TMainMenu;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MIContaBancariaClick(Sender: TObject);
    procedure MIContaContabilClick(Sender: TObject);
    procedure miContasAPagarClick(Sender: TObject);
    procedure MIMensalidadesClick(Sender: TObject);
    procedure MISairClick(Sender: TObject);
    procedure MISobreClick(Sender: TObject);
    procedure mnConfiguracoesClick(Sender: TObject);
    procedure MNMembroClick(Sender: TObject);
    procedure mnUpdateClick(Sender: TObject);
  private
    procedure carregarDatasCalendario();

    procedure carregarAPagar();
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.MISairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.MISobreClick(Sender: TObject);
begin
  frmSobre.ShowModal;
end;

procedure TfrmPrincipal.mnConfiguracoesClick(Sender: TObject);
begin
  frmConfig.ShowModal;
end;

procedure TfrmPrincipal.MNMembroClick(Sender: TObject);
begin
  frmMembro.ShowModal;
end;

procedure TfrmPrincipal.mnUpdateClick(Sender: TObject);
begin
  frmAtualizacoes.Show;
end;

procedure TfrmPrincipal.carregarDatasCalendario();
begin

end;

procedure TfrmPrincipal.carregarAPagar();
begin
  DSContasAPagar.DataSet := DataModule1.returnQuery('SELECT * FROM APAGAR ' +
                                                            ' WHERE PAGO = NULL OR PAGO IS NULL'+
                                                            ' AND VENCIMENTO <= DATEADD(5 day to current_date) '+
                                                            ' ORDER BY VENCIMENTO ASC;');
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  DataModule1.FBConn.Connected:= true;

  calendarioContas.DateTime:= now;

  carregarAPagar();
end;

procedure TfrmPrincipal.MIContaBancariaClick(Sender: TObject);
begin
     frmContaBancaria.Show;
end;

procedure TfrmPrincipal.MIContaContabilClick(Sender: TObject);
begin
  frmContaContabil.ShowModal;
end;

procedure TfrmPrincipal.miContasAPagarClick(Sender: TObject);
begin
  frmAPagar.ShowModal;
  carregarAPagar();
end;

procedure TfrmPrincipal.MIMensalidadesClick(Sender: TObject);
begin
  frmMensalidades.ShowModal;
end;

end.

