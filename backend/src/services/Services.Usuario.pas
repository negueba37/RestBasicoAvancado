unit Services.Usuario;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,System.JSON,
  System.Generics.Collections;

type
  TServiceUsuario = class(TProvidersCadastro)
    qryPesquisaID: TIntegerField;
    qryPesquisaNOME: TStringField;
    qryPesquisaLOGIN: TStringField;
    qryPesquisaSTATUS: TSmallintField;
    qryPesquisaSEXO: TSmallintField;
    qryPesquisaTELEFONE: TStringField;
    qryCadastroID: TIntegerField;
    qryCadastroNOME: TStringField;
    qryCadastroLOGIN: TStringField;
    qryCadastroSENHA: TStringField;
    qryCadastroSTATUS: TSmallintField;
    qryCadastroSEXO: TSmallintField;
    qryCadastroTELEFONE: TStringField;
    qryCadastroFOTO: TBlobField;
    procedure qryCadastroBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    function Append(const AJson:TJSONObject):Boolean;override;
    function SalvarFotoUsuario(const AFoto: TStream): Boolean;
    function ObterFotoUsuario: TStream;
    function Update(const AJson:TJSONObject):Boolean;override;
    function GetByID(const AId:string):TFDQuery;override;
    function ListAll(const AParams:TDictionary<string,string>):TFDQuery;Override;

  end;

var
  ServiceUsuario: TServiceUsuario;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceUsuario }
uses BCrypt;

function TServiceUsuario.Append(const AJson: TJSONObject): Boolean;
begin
  Result := inherited Append(AJson);
  qryCadastroSENHA.Visible := False;
end;

function TServiceUsuario.GetByID(const AId: string): TFDQuery;
begin
  Result := inherited GetByID(AId);
  qryCadastroSENHA.Visible := False;
end;

function TServiceUsuario.ListAll(const AParams: TDictionary<string, string>): TFDQuery;
begin

end;

function TServiceUsuario.ObterFotoUsuario: TStream;
begin
  Result := nil;
  if (qryCadastroFOTO.IsNull) then
    Exit;
  Result := TMemoryStream.Create;
  qryCadastroFOTO.SaveToStream(Result);
end;

procedure TServiceUsuario.qryCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryCadastroSENHA.OldValue <> qryCadastroSENHA.NewValue) and (not qryCadastroSENHA.AsString.Trim.IsEmpty) then
    qryCadastroSENHA.AsString := TBCrypt.GenerateHash(qryCadastroSENHA.AsString);
end;

function TServiceUsuario.SalvarFotoUsuario(const AFoto: TStream): Boolean;
begin
  qryCadastro.Edit;
  qryCadastroFOTO.LoadFromStream(AFoto);
  qryCadastro.Post;
  Result := qryCadastro.ApplyUpdates(0) = 0;
end;

function TServiceUsuario.Update(const AJson: TJSONObject): Boolean;
begin
  qryCadastroSENHA.Visible := True;
  Result := inherited Update(AJson);
end;
end.
