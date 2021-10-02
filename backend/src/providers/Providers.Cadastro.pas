unit Providers.Cadastro;

interface

uses
  System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet,System.JSON, System.Generics.Collections,
  FireDAC.VCLUI.Wait;

type
  TProvidersCadastro = class(TProvidersConnection)
    qryPesquisa: TFDQuery;
    qryRecordCount: TFDQuery;
    qryCadastro: TFDQuery;
    qryRecordCountCOUNT: TLargeintField;
  private
    { Private declarations }
  public
    constructor Create;reintroduce;
    function Append(const AJson:TJSONObject):Boolean;virtual;
    function Update(const AJson:TJSONObject):Boolean;virtual;
    function Delete:Boolean;virtual;
    function ListAll(const AParams:TDictionary<string,string>):TFDQuery;virtual;
    function GetByID(const AId:string):TFDQuery;virtual;
    function GetRecordCount:Int64;virtual;
  end;

var
  ProvidersCadastro: TProvidersCadastro;

implementation
 uses
 DataSet.Serialize;
{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TProvidersCadastro }

function TProvidersCadastro.Append(const AJson: TJSONObject): Boolean;
begin
  qryCadastro.SQL.Add('WHERE 1 <> 1');
  qryCadastro.Open;
  qryCadastro.LoadFromJSON(AJson,False);
  Result := qryCadastro.ApplyUpdates(0) = 0;
end;

constructor TProvidersCadastro.Create;
begin
  inherited Create(nil);
end;

function TProvidersCadastro.Delete: Boolean;
begin
  qryCadastro.Delete;
  Result := qryCadastro.ApplyUpdates(0) = 0;
end;

function TProvidersCadastro.GetByID(const AId: string): TFDQuery;
begin
  qryCadastro.SQL.Add('WHERE ID = :ID');
  qryCadastro.ParamByName('ID').AsLargeInt := AId.ToInt64;
  qryCadastro.Open();
  Result := qryCadastro;
end;

function TProvidersCadastro.GetRecordCount: Int64;
begin
  qryRecordCount.Open();
  Result := qryRecordCountCOUNT.AsLargeInt;
end;

function TProvidersCadastro.ListAll(const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('limit') then
  begin
    qryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'],50);
    qryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'],50);
  end;

  if AParams.ContainsKey('offset') then
    qryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'],0);

  qryPesquisa.Open();
  Result := qryPesquisa;
end;

function TProvidersCadastro.Update(const AJson: TJSONObject): Boolean;
begin
  qryCadastro.MergeFromJSONObject(AJson,False);
  Result := qryCadastro.ApplyUpdates(0) = 0;
end;

end.
