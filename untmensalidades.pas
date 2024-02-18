unit untMensalidades;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, StdCtrls,
  DBDateTimePicker, untFrmBase;

type

  { TfrmMensalidades }

  TfrmMensalidades = class(TfrmBase)
    DBEdit1: TDBEdit;
    Label1: TLabel;
  private

  public

  end;

var
  frmMensalidades: TfrmMensalidades;

implementation

{$R *.lfm}

end.

