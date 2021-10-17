inherited ServicePedidoItem: TServicePedidoItem
  inherited FDConnection: TFDConnection
    Connected = True
  end
  inherited qryPesquisa: TFDQuery
    SQL.Strings = (
      
        'SELECT PEDIDOITEM.ID, PEDIDOITEM.ID_PRODUTO, PEDIDOITEM.QUANTIDA' +
        'DE, PEDIDOITEM.VALOR,'
      'PRODUTO.NOME AS NOME_PRODUTO'
      'FROM PEDIDOITEM'
      'INNER JOIN PRODUTO ON PRODUTO.ID = PEDIDOITEM.ID_PRODUTO'
      'WHERE PEDIDOITEM.ID_PEDIDO = :ID_PEDIDO')
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryPesquisaID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPesquisaID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
    end
    object qryPesquisaQUANTIDADE: TSingleField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
    end
    object qryPesquisaVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
    end
    object qryPesquisaNOME_PRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_PRODUTO'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
  end
  inherited qryRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT Count(PEDIDOITEM.ID)'
      'FROM PEDIDOITEM'
      'INNER JOIN PRODUTO ON PRODUTO.ID = PEDIDOITEM.ID_PRODUTO'
      'WHERE PEDIDOITEM.ID_PEDIDO = :ID_PEDIDO')
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  inherited qryCadastro: TFDQuery
    SQL.Strings = (
      
        'SELECT PEDIDOITEM.ID, PEDIDOITEM.ID_PEDIDO, PEDIDOITEM.ID_PRODUT' +
        'O, PEDIDOITEM.QUANTIDADE, PEDIDOITEM.VALOR,'
      'PRODUTO.NOME AS NOME_PRODUTO'
      'FROM PEDIDOITEM'
      'INNER JOIN PRODUTO ON PRODUTO.ID = PEDIDOITEM.ID_PRODUTO'
      '')
    object qryCadastroID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
      Required = True
    end
    object qryCadastroID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Origin = 'ID_PEDIDO'
    end
    object qryCadastroID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
      Origin = 'ID_PRODUTO'
    end
    object qryCadastroQUANTIDADE: TSingleField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
    end
    object qryCadastroVALOR: TSingleField
      FieldName = 'VALOR'
      Origin = 'VALOR'
    end
    object qryCadastroNOME_PRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_PRODUTO'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 60
    end
  end
end
