unit Controllers.Usuario;

interface

uses Horse, Services.Usuario, System.JSON,DataSet.Serialize,Data.DB,
  System.Classes;

procedure Registry;
procedure ListarUsuarios(Req : THorseRequest; Res:THorseResponse; Next:TProc);
procedure ObterUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
procedure ObterFotoUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
procedure CadastrarUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
procedure CadastrarFotoUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
procedure AlterarUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
procedure DeletarUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
implementation

procedure Registry;
begin
  THorse.Get('/usuarios',ListarUsuarios);
  THorse.Get('/usuarios/:id',ObterUsuario);
  THorse.Get('/usuarios/:id/foto',ObterFotoUsuario);
  THorse.Post('/usuarios',CadastrarUsuario);
  THorse.Post('/usuarios/:id/foto',CadastrarFotoUsuario);
  THorse.Put('/usuarios/:id',AlterarUsuario);
  THorse.Delete('/usuarios/:id',DeletarUsuario);
end;

procedure ListarUsuarios(Req : THorseRequest; Res:THorseResponse; Next:TProc);
var
  LService:TServiceUsuario;
  LRetorno:TJSONObject;
begin
  LService := TServiceUsuario.Create;
  try
    LRetorno :=  TJSONObject.Create;
    LRetorno.AddPair('DATA',LService.ListAll(Req.Query).ToJSONArray());
    LRetorno.AddPair('RECORDS',TJSONNumber.Create(LService.GetRecordCount));
    Res.Send(LRetorno);
  finally
    LService.Free;
  end;
end;
procedure ObterUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
var
  LService:TServiceUsuario;
  LIdUsuario:string;
begin
  LService := TServiceUsuario.Create;
  try
    LIdUsuario := Req.Params.Items['id'];
    if LService.GetByID(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Usuário não cadastrado');

    Res.Send(LService.qryCadastro.ToJSONObject());

  finally
    LService.Free;
  end;
end;
procedure CadastrarUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
var
  LUsuario:TJSONObject;
  LService:TServiceUsuario;
begin
  LService := TServiceUsuario.Create;
  try
    LUsuario := Req.Body<TJSONObject>;
    if LService.Append(LUsuario) then
      Res.Send(LService.qryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    LService.Free;
  end;
end;
procedure AlterarUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
var
  LIdUsuario:string;
  LUsuario:TJSONObject;
  LService:TServiceUsuario;
begin
  LService := TServiceUsuario.Create;
  try
    LIdUsuario := Req.Params.Items['id'];
    if LService.GetByID(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Usuário não cadastrado');
    LUsuario := Req.Body<TJSONObject>;

    if LService.Update(LUsuario) then
      res.Status(THTTPStatus.NoContent)
  finally
    LService.Free;
  end;
end;
procedure DeletarUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
var
  LIdUsuario:string;
  LService:TServiceUsuario;
begin
  LService := TServiceUsuario.Create;
  try
    LIdUsuario := Req.Params.Items['id'];
    if LService.GetByID(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Usuário não cadastrado');

    if LService.Delete then
      res.Status(THTTPStatus.NoContent)
  finally
    LService.Free;
  end;
end;
procedure CadastrarFotoUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
var
  LFotoUsuario:TMemoryStream;
  LIdUsuario:string;
  LService:TServiceUsuario;
begin
  LService := TServiceUsuario.Create;
  try
    LIdUsuario := Req.Params.Items['id'];
    if LService.GetByID(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Usuário não cadastrado');

    LFotoUsuario := Req.Body<TMemoryStream>;
    if not Assigned(LFotoUsuario) then
      raise EHorseException.Create(THTTPStatus.BadRequest,'Foto inválida');

    if LService.SalvarFotoUsuario(LFotoUsuario) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;
procedure ObterFotoUsuario(Req : THorseRequest; Res:THorseResponse; Next:TProc);
var
  LIdUsuario:string;
  LFotoUsuario:TStream;
  LService:TServiceUsuario;
begin
  LService := TServiceUsuario.Create;
  try
    LIdUsuario := Req.Params.Items['id'];
    if LService.GetByID(LIdUsuario).IsEmpty then
      raise EHorseException.Create(THTTPStatus.NotFound,'Usuário não cadastrado');

    LFotoUsuario := LService.ObterFotoUsuario;
    if not Assigned(LFotoUsuario) then
      raise EHorseException.Create(THTTPStatus.NotFound,'Foto não cadastrada');

    Res.Send(LFotoUsuario);
  finally
    LService.Free;
  end;
end;

end.
