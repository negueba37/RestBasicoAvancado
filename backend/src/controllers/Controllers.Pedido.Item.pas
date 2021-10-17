unit Controllers.Pedido.Item;

interface
  uses Horse,Services.Pedido.Item, System.JSON,DataSet.Serialize;
procedure Registry;
procedure ListarItens(Req: THorseRequest; Res:THorseResponse; Next: TProc);
procedure ObterItem(Req: THorseRequest; Res:THorseResponse; Next: TProc);
procedure DeletarItem(Req: THorseRequest; Res:THorseResponse; Next: TProc);
procedure CadastrarItem(Req: THorseRequest; Res:THorseResponse; Next: TProc);
procedure AlterarItem(Req: THorseRequest; Res:THorseResponse; Next: TProc);
implementation

procedure Registry;
begin
  THorse.Get('/pedidos/:id_pedido/itens',ListarItens);
  THorse.Get('/pedidos/:id_pedido/itens/:id_pedido_itens',ObterItem);
  THorse.Post('/pedidos/:id_pedido/itens',CadastrarItem);
  THorse.Put('/pedidos/:id_pedido/itens/:id_pedido_itens',AlterarItem);
  THorse.Delete('/pedidos/:id_pedido/itens/:id_pedido_itens',DeletarItem);
end;

procedure ListarItens(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService:TServicePedidoItem;
  LRetorno:TJSONObject;
  LIdPedido:string;
begin
  LService := TServicePedidoItem.Create;
  try
    LIdPedido := Req.Params.Items['id_pedido'];
    LRetorno := TJSONObject.Create;
    LRetorno.AddPair('data',LService.ListAllByPedidos(Req.Query,LIdPedido).ToJSONArray());
    LRetorno.AddPair('records',TJSONNumber.Create(LService.GetRecordCount));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;

procedure ObterItem(Req: THorseRequest; Res:THorseResponse; Next: TProc);
var
  LService:TServicePedidoItem;
  LIdPedido,LIdPedidoItens:string;
begin
  LService := TServicePedidoItem.Create;
  try
    LIdPedido := Req.Params.Items['id_pedido'];
    LIdPedidoItens := Req.Params.Items['id_pedido_itens'];
    if LService.GetByPedido(LIdPedido,LIdPedidoItens).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound ,'Itens do pedido não cadastrado !');

    Res.Send(LService.qryCadastro.ToJSONObject());
  finally
    LService.Free;
  end;
end;

procedure DeletarItem(Req: THorseRequest; Res:THorseResponse; Next: TProc);
var
  LService:TServicePedidoItem;
  LIdPedido,LIdPedidoItens:string;
begin
  LService := TServicePedidoItem.Create;
  try
    LIdPedido := Req.Params.Items['id_pedido'];
    LIdPedidoItens := Req.Params.Items['id_pedido_itens'];
    if LService.GetByPedido(LIdPedido,LIdPedidoItens).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound ,'Itens do pedido não cadastrado !');

    if(LService.Delete) then
      Res.Status(THTTPStatus.NoContent);

  finally
    LService.Free;
  end;
end;

procedure CadastrarItem(Req: THorseRequest; Res:THorseResponse; Next: TProc);
var
  LService:TServicePedidoItem;
  LIdPedido:string;
  LPedido:TJSONObject;
begin
  LService := TServicePedidoItem.Create;
  try
    LPedido := Req.Body<TJSONObject>;
    LIdPedido := Req.Params.Items['id_pedido'];
    LPedido.RemovePair('idPedido').Free;
    LPedido.AddPair('idPedido',LIdPedido);
    if LService.Append(LPedido)then
      Res.Send(LService.qryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;

procedure AlterarItem(Req: THorseRequest; Res:THorseResponse; Next: TProc);
var
  LService:TServicePedidoItem;
  LIdPedido,LIdItem:string;
  LPedido:TJSONObject;
begin
  LService := TServicePedidoItem.Create;
  try
    LPedido := Req.Body<TJSONObject>;
    LIdPedido := Req.Params.Items['id_pedido'];
    LIdItem := Req.Params.Items['id_pedido_itens'];

    if LService.GetByPedido(LIdPedido,LIdItem).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound ,'Itens do pedido não cadastrado !');

    LPedido.RemovePair('idPedido').Free;

    if LService.Update(LPedido)then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;

end;

end.
