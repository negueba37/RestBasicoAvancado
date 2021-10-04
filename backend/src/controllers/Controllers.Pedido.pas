unit Controllers.Pedido;

interface
  uses Horse,System.JSON,Services.Pedido,DataSet.Serialize;
procedure Registry;
procedure ListarPedidos(Req: THorseRequest;Res: THorseResponse;Next: TProc);
procedure ObterPedido(Req: THorseRequest;Res: THorseResponse;Next: TProc);
procedure CadastrarPedido(Req: THorseRequest;Res: THorseResponse;Next: TProc);
procedure AlterarPedido(Req: THorseRequest;Res: THorseResponse;Next: TProc);
procedure DeletarPedido(Req: THorseRequest;Res: THorseResponse;Next: TProc);

implementation

procedure Registry;
begin
  THorse.Get('/pedidos',ListarPedidos);
  THorse.Get('/pedidos/:id',ObterPedido);
  THorse.Post('/pedidos',CadastrarPedido);
  THorse.Put('/pedidos/:id',AlterarPedido);
  THorse.Delete('/pedidos/:id',DeletarPedido);
end;
procedure ListarPedidos(Req: THorseRequest;Res: THorseResponse;Next: TProc);
var
  LRetorno:TJSONObject;
  LService:TServicePedido;
begin
  LService := TServicePedido.Create;
  try
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('data',LService.ListAll(Req.Query).ToJSONArray());
    LRetorno.AddPair('records',TJSONNumber.Create(LService.GetRecordCount));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;
procedure ObterPedido(Req: THorseRequest;Res: THorseResponse;Next: TProc);
var
  LService:TServicePedido;
  LIdPedido:string;
begin
  LService := TServicePedido.Create;
  try
    LIdPedido := Req.Params['id'];
    if LService.GetByID(LIdPedido).IsEmpty then
      raise EHorseException.Create(THttpStatus.NotFound,'Pedido não cadastrado');
    Res.Send(LService.qryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;
procedure CadastrarPedido(Req: THorseRequest;Res: THorseResponse;Next: TProc);
var
  LService:TServicePedido;
  LPedido:TJSONObject;
begin
  LService := TServicePedido.Create;
  try
    LPedido := Req.Body<TJSONObject>;
    if LService.Append(LPedido)then
      Res.Send(LService.qryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;
procedure AlterarPedido(Req: THorseRequest;Res: THorseResponse;Next: TProc);
var
  LService:TServicePedido;
  LIdPedido:string;
  LPedido:TJSONObject;
begin
  LService := TServicePedido.Create;
  try
    LIdPedido := Req.Params.Items['id'];
    if LService.GetByID(LIdPedido).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Pedido não cadastrado');
    LPedido := Req.Body<TJSONObject>;
    if LService.Update(LPedido)then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;
procedure DeletarPedido(Req: THorseRequest;Res: THorseResponse;Next: TProc);
var
  LService:TServicePedido;
  LIdPedido:string;
begin
  LService := TServicePedido.Create;
  try
    LIdPedido := Req.Params.Items['id'];
    if LService.GetByID(LIdPedido).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Pedido não cadastrado');
    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;
end.
