inherited ServiceProduto: TServiceProduto
  inherited FDConnection: TFDConnection
    Connected = True
    Left = 40
    Top = 128
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      'SELECT ID,NOME,VALOR,STATUS,ESTOQUE FROM PRODUTO'
      'WHERE 1 = 1')
    Left = 136
    Top = 16
    object qryPesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryPesquisaVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
    end
    object qryPesquisaSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
    object qryPesquisaESTOQUE: TSingleField
      FieldName = 'ESTOQUE'
      Origin = 'ESTOQUE'
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(ID) FROM PRODUTO'
      'WHERE 1 = 1')
    Left = 32
    Top = 16
  end
  inherited qryCadastro: TFDQuery
    SQL.Strings = (
      'SELECT ID,NOME,VALOR,STATUS,ESTOQUE FROM PRODUTO')
    object qryCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCadastroNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 60
    end
    object qryCadastroVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
    end
    object qryCadastroSTATUS: TSmallintField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
    object qryCadastroESTOQUE: TSingleField
      FieldName = 'ESTOQUE'
      Origin = 'ESTOQUE'
    end
  end
end
