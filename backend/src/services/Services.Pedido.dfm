inherited ProvidersCadastro1: TProvidersCadastro1
  inherited FDConnection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'SELECT PEDIDO.*,CLIENTE.NOME AS NOME_CLIENTE FROM PEDIDO'
      'INNER JOIN CLIENTE ON CLIENTE.ID = PEDIDO.ID_CLIENTE'
      'where 1=1')
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
      'INNER JOIN CLIENTE ON CLIENTE.ID = PEDIDO.ID_CLIENTE')
  end
  inherited qryCadastro: TFDQuery
    SQL.Strings = (
      'SELECT PEDIDO.*,CLIENTE.NOME AS NOME_CLIENTE FROM PEDIDO'
      'INNER JOIN CLIENTE ON CLIENTE.ID = PEDIDO.ID_CLIENTE'
      'where ')
  end
end
