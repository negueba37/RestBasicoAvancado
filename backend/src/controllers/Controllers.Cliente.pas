unit Controllers.Cliente;

interface
uses
  Horse,
  Services.Cliente,
  System.JSON,
  DataSet.Serialize;
  procedure Registry;
  procedure ListarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ObterCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure CadastrarCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure AlterarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure DeletarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
implementation
procedure ListarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceCliente;
  LRetorno:TJSONObject;

begin
  LService := TServiceCliente.Create;
  try
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('DATA',LService.ListAll(Req.Query).ToJSONArray());
    LRetorno.AddPair('RECORDS',TJSONNumber.Create(LService.GetRecordCount));
    Res.Send(LRetorno)
  finally
    LService.Free;
  end;
end;
procedure ObterCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceCliente;
begin
  LService := TServiceCliente.Create;
  try
    if LService.GetByID(Req.Params['id']).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Cliente não encontrado');
    Res.Send(LService.qryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;
procedure CadastrarCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceCliente;
  LCliente:TJSONObject;
begin
  LService := TServiceCliente.Create;
  try
    LCliente := Req.Body<TJSONObject>;
    if LService.Append(LCliente) then
      Res.Send(LService.qryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;
procedure AlterarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceCliente;
  LCliente:TJSONObject;
begin
  LService := TServiceCliente.Create;
  try
    if LService.GetByID(Req.Params['id']).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Cliente não encontrado');

    LCliente := Req.Body<TJSONObject>;
    if LService.Update(LCliente)then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;
procedure DeletarClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceCliente;
  LCliente:TJSONObject;
begin
  LService := TServiceCliente.Create;
  try
    if LService.GetByID(Req.Params['id']).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Cliente não encontrado');

    LCliente := Req.Body<TJSONObject>;
    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/clientes',ListarClientes);
  THorse.Get('/clientes/:id',ObterCliente);
  THorse.Post('/clientes',CadastrarCliente);
  THorse.Put('/clientes/:id',AlterarClientes);
  THorse.Delete('/clientes/:id',DeletarClientes);
end;

end.
