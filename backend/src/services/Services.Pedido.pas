unit Services.Pedido;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TProvidersCadastro1 = class(TProvidersCadastro)
    qryPesquisaID: TIntegerField;
    qryPesquisaDATA: TSQLTimeStampField;
    qryPesquisaID_CLIENTE: TIntegerField;
    qryPesquisaNOME_CLIENTE: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProvidersCadastro1: TProvidersCadastro1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
