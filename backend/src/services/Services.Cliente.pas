unit Services.Cliente;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServiceCliente = class(TProvidersCadastro)
    qryPesquisaID: TIntegerField;
    qryPesquisaNOME: TStringField;
    qryPesquisaSTATUS: TSmallintField;
    qryCadastroID: TIntegerField;
    qryCadastroNOME: TStringField;
    qryCadastroSTATUS: TSmallintField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceCliente: TServiceCliente;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
