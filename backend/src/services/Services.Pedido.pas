unit Services.Pedido;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Generics.Collections;

type
  TServicePedido = class(TProvidersCadastro)
    qryPesquisaID: TIntegerField;
    qryPesquisaDATA: TSQLTimeStampField;
    qryPesquisaID_CLIENTE: TIntegerField;
    qryPesquisaNOME_CLIENTE: TStringField;
    qryCadastroID: TIntegerField;
    qryCadastroDATA: TSQLTimeStampField;
    qryCadastroID_CLIENTE: TIntegerField;
    qryCadastroNOME_CLIENTE: TStringField;
    qryCadastroID_USUARIO: TIntegerField;
    procedure qryCadastroAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    function GetByID(const AId:string):TFDQuery;override;
    function ListAll(const AParams:TDictionary<string,string>):TFDQuery;override;
  end;

var
  ServicePedido: TServicePedido;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServicePedido }

function TServicePedido.GetByID(const AId: string): TFDQuery;
begin
  qryCadastro.SQL.Add('WHERE PEDIDO.ID = :ID');
  qryCadastro.ParamByName('ID').AsLargeInt := AId.ToInt64;
  qryCadastro.Open();
  Result := qryCadastro;
end;

function TServicePedido.ListAll(const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('id') then
  begin
    qryPesquisa.SQL.Add('and pedido.id = :id');
    qryPesquisa.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
    qryRecordCount.SQL.Add('id = :id');
    qryRecordCount.ParamByName('id').AsLargeInt := AParams.Items['id'].ToInt64;
  end;

  if AParams.ContainsKey('idCliente') then
  begin
    qryPesquisa.SQL.Add('and id_cliente = :id');
    qryPesquisa.ParamByName('id').AsLargeInt := AParams.Items['idCliente'].ToInt64;
    qryRecordCount.SQL.Add('id = :id');
    qryRecordCount.ParamByName('id').AsLargeInt := AParams.Items['idCliente'].ToInt64;
  end;

  if AParams.ContainsKey('idUsuario') then
  begin
    qryPesquisa.SQL.Add('and id_usuario = :id');
    qryPesquisa.ParamByName('id').AsLargeInt := AParams.Items['idUsuario'].ToInt64;
    qryRecordCount.SQL.Add('id = :id');
    qryRecordCount.ParamByName('id').AsLargeInt := AParams.Items['idUsuario'].ToInt64;
  end;

  if AParams.ContainsKey('nomeCliente') then
  begin
    qryPesquisa.SQL.Add('and lower(cliente.nome) = like lower(:nome)');
    qryPesquisa.ParamByName('nome').AsString := '%'+AParams.Items['nomeCliente']+'%';
    qryRecordCount.SQL.Add('id = :nome');
    qryRecordCount.ParamByName('nome').AsString := '%'+AParams.Items['nomeCliente']+'%';
  end;

  qryPesquisa.SQL.Add('order by pedido.id');
  Result := inherited ListAll(AParams);
end;

procedure TServicePedido.qryCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryCadastroDATA.AsDateTime := Now;
end;

end.
