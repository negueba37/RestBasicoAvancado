program business;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Providers.Connection in 'src\providers\Providers.Connection.pas' {ProvidersConnection: TDataModule},
  Providers.Cadastro in 'src\providers\Providers.Cadastro.pas' {ProvidersCadastro: TDataModule},
  Services.Produto in 'src\services\Services.Produto.pas' {ServiceProduto: TDataModule},
  Controllers.Produto in 'src\controllers\Controllers.Produto.pas',
  Controllers.Cliente in 'src\controllers\Controllers.Cliente.pas',
  Services.Cliente in 'src\services\Services.Cliente.pas' {ServiceCliente: TDataModule},
  Services.Pedido in 'src\services\Services.Pedido.pas' {ProvidersCadastro1: TDataModule};

begin
  THorse
    .Use(Jhonson())
    .Use(HandleException);
  Controllers.Produto.Registry;
  Controllers.Cliente.Registry;
  THorse.Listen(9000);
end.
