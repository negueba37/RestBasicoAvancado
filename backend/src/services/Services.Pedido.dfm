inherited ServicePedido: TServicePedido
  inherited FDConnection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'SELECT PEDIDO.*,CLIENTE.NOME AS NOME_CLIENTE FROM PEDIDO'
      'INNER JOIN CLIENTE ON CLIENTE.ID = PEDIDO.ID_CLIENTE'
      'WHERE 1=1')
    object qryPesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object qryPesquisaID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
    end
    object qryPesquisaNOME_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(PEDIDO.ID) FROM PEDIDO'
      'INNER JOIN CLIENTE ON CLIENTE.ID = PEDIDO.ID_CLIENTE'
      'WHERE 1 = 1')
  end
  inherited qryCadastro: TFDQuery
    AfterInsert = qryCadastroAfterInsert
    SQL.Strings = (
      'SELECT PEDIDO.*,CLIENTE.NOME AS NOME_CLIENTE FROM PEDIDO'
      'INNER JOIN CLIENTE ON CLIENTE.ID = PEDIDO.ID_CLIENTE'
      '')
    object qryCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryCadastroDATA: TSQLTimeStampField
      FieldName = 'DATA'
      Origin = '"DATA"'
    end
    object qryCadastroID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
    end
    object qryCadastroNOME_CLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_CLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      Size = 60
    end
    object qryCadastroID_USUARIO: TIntegerField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
    end
  end
end
