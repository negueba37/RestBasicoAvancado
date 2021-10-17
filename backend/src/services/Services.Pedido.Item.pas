unit Services.Pedido.Item;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.JSON,
  System.Generics.Collections;

type
  TServicePedidoItem = class(TProvidersCadastro)
    qryCadastroID: TIntegerField;
    qryCadastroID_PEDIDO: TIntegerField;
    qryCadastroID_PRODUTO: TIntegerField;
    qryCadastroQUANTIDADE: TSingleField;
    qryCadastroVALOR: TSingleField;
    qryCadastroNOME_PRODUTO: TStringField;
    qryPesquisaID: TIntegerField;
    qryPesquisaID_PRODUTO: TIntegerField;
    qryPesquisaQUANTIDADE: TSingleField;
    qryPesquisaVALOR: TSingleField;
    qryPesquisaNOME_PRODUTO: TStringField;
  private
    { Private declarations }
  public
    function Append(const AJson:TJSONObject):Boolean;override;
    function ListAllByPedidos(const AParams:TDictionary<string,string>;AIdPedido:string):TFDQuery;
    function GetByPedido(const AIdPedido:string;const AIdPedidoItens:string):TFDQuery;
  end;

var
  ServicePedidoItem: TServicePedidoItem;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServerPedidoItem }

function TServicePedidoItem.Append(const AJson: TJSONObject): Boolean;
begin
  Result := inherited Append(AJson);
  qryCadastroID_PEDIDO.Visible := False;
end;

function TServicePedidoItem.GetByPedido(const AIdPedido, AIdPedidoItens: string): TFDQuery;
begin
  qryCadastroID_PEDIDO.Visible := False;
  qryCadastro.SQL.Add('WHERE ID_PEDIDO = :ID_PEDIDO AND PEDIDOITEM.ID = :ID_PEDIDO_ITENS');
  qryCadastro.ParamByName('ID_PEDIDO').AsLargeInt := AIdPedido.ToInt64;
  qryCadastro.ParamByName('ID_PEDIDO_ITENS').AsLargeInt := AIdPedidoItens.ToInt64;
  qryCadastro.Open;
  Result := qryCadastro;
end;

function TServicePedidoItem.ListAllByPedidos(const AParams:TDictionary<string,string>;AIdPedido:string): TFDQuery;
begin
  qryPesquisa.ParamByName('id_pedido').AsLargeInt := AIdPedido.ToInt64();
  qryRecordCount.ParamByName('id_pedido').AsLargeInt := AIdPedido.ToInt64();
  Result := ListAll(AParams);
end;

end.
