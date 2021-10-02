unit Services.Produto;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Generics.Collections;

type
  TServiceProduto = class(TProvidersCadastro)
    qryPesquisaID: TIntegerField;
    qryPesquisaNOME: TStringField;
    qryPesquisaVALOR: TSingleField;
    qryPesquisaSTATUS: TSmallintField;
    qryPesquisaESTOQUE: TSingleField;
    qryCadastroID: TIntegerField;
    qryCadastroNOME: TStringField;
    qryCadastroVALOR: TSingleField;
    qryCadastroSTATUS: TSmallintField;
    qryCadastroESTOQUE: TSingleField;
  private
    { Private declarations }
  public
    function ListAll(const AParams:TDictionary<string,string>):TFDQuery;virtual;
  end;

var
  ServiceProduto: TServiceProduto;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceProduto }

function TServiceProduto.ListAll(const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('id') then
  begin
    qryPesquisa.SQL.Add(' and id = :id');
    qryPesquisa.ParamByName('id').AsString := AParams['id'];
    qryRecordCount.SQL.Add(' and id = :id');
    qryRecordCount.ParamByName('id').AsString := AParams['id'];
  end;
  if AParams.ContainsKey('nome') then
  begin
    qryPesquisa.SQL.Add(' and lower(nome) like :nome');
    qryPesquisa.ParamByName('nome').AsString := '%'+AParams['nome'].ToLower+'%';
    qryRecordCount.SQL.Add(' and lower(nome) like :nome');
    qryRecordCount.ParamByName('nome').AsString := '%'+AParams['nome'].ToLower+'%';
  end;
  qryPesquisa.SQL.Add(' order by id');
  Result := inherited ListAll(AParams);
end;

end.
