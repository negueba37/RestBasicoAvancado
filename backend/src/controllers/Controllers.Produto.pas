unit Controllers.Produto;

interface
uses
  Horse,
  Services.Produto,
  System.JSON,
  DataSet.Serialize;
  procedure Registry;
  procedure ListarProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure ObterProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure CadastrarProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure AlterarProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure DeletarProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
implementation
procedure ListarProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceProduto;
  LRetorno:TJSONObject;

begin
  LService := TServiceProduto.Create;
  try
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('DATA',LService.ListAll(Req.Query).ToJSONArray());
    LRetorno.AddPair('RECORDS',TJSONNumber.Create(LService.GetRecordCount));
    Res.Send(LRetorno)
  finally
    LService.Free;
  end;
end;
procedure ObterProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceProduto;
begin
  LService := TServiceProduto.Create;
  try
    if LService.GetByID(Req.Params['id']).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Produto não encontrado');
    Res.Send(LService.qryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;
procedure CadastrarProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceProduto;
  LProduto:TJSONObject;
begin
  LService := TServiceProduto.Create;
  try
    LProduto := Req.Body<TJSONObject>;
    if LService.Append(LProduto) then
      Res.Send(LService.qryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;
procedure AlterarProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceProduto;
  LProduto:TJSONObject;
begin
  LService := TServiceProduto.Create;
  try
    if LService.GetByID(Req.Params['id']).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Produto não encontrado');

    LProduto := Req.Body<TJSONObject>;
    if LService.Update(LProduto)then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;
procedure DeletarProdutos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServiceProduto;
  LProduto:TJSONObject;
begin
  LService := TServiceProduto.Create;
  try
    if LService.GetByID(Req.Params['id']).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Produto não encontrado');

    LProduto := Req.Body<TJSONObject>;
    if LService.Delete then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/produtos',ListarProdutos);
  THorse.Get('/produtos/:id',ObterProduto);
  THorse.Post('/produtos',CadastrarProduto);
  THorse.Put('/produtos/:id',AlterarProdutos);
  THorse.Delete('/produtos/:id',DeletarProdutos);
end;

end.
