unit clsRecorrencia;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB,

  untDM;

type

{ TclsRecorrencia }

 TclsRecorrencia = class

private

protected

public
  function pendentes(): TSQLQuery;
end;


implementation

{ TclsRecorrencia }

function TclsRecorrencia.pendentes(): TSQLQuery;
begin
  //0 - mensal, 1 - semestra, 2 - anual
  Result := DataModule1.returnQuery('SELECT * FROM RECORRENTE ' +
                                  ' WHERE (DATEADD(month, 1, RECORRENTE.ULTIMA_GERADA) < current_date AND RECORRENTE.RECORRENCIA = 0) OR '+
                                          ' (DATEADD(month, 6, RECORRENTE.ULTIMA_GERADA) < current_date AND RECORRENTE.RECORRENCIA = 1) OR'+
                                          ' (DATEADD(month, 12, RECORRENTE.ULTIMA_GERADA) < current_date AND RECORRENTE.RECORRENCIA = 2)');
end;

end.

